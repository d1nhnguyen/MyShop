"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.orderResolvers = void 0;
const graphql_1 = require("graphql");
const client_1 = require("@prisma/client");
const auth_middleware_1 = require("../../middleware/auth.middleware");
exports.orderResolvers = {
    Query: {
        orders: async (_, { pagination, sort, filter }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const page = pagination?.page || 1;
            const pageSize = Math.min(pagination?.pageSize || 20, 10000);
            const skip = (page - 1) * pageSize;
            const where = {};
            if (filter) {
                if (filter.status) {
                    where.status = filter.status;
                }
                if (filter.customerId) {
                    where.customerId = filter.customerId;
                }
                if (filter.dateRange) {
                    where.createdAt = {};
                    if (filter.dateRange.from) {
                        where.createdAt.gte = new Date(filter.dateRange.from);
                    }
                    if (filter.dateRange.to) {
                        where.createdAt.lte = new Date(filter.dateRange.to);
                    }
                }
            }
            const orderBy = sort
                ? { [sort.field]: sort.order.toLowerCase() }
                : { createdAt: 'desc' };
            const [orders, total] = await Promise.all([
                context.prisma.order.findMany({
                    where,
                    skip,
                    take: pageSize,
                    orderBy,
                    include: {
                        customer: true,
                        createdBy: true,
                        discount: true,
                        orderItems: {
                            include: {
                                product: true,
                            },
                        },
                    },
                }),
                context.prisma.order.count({ where }),
            ]);
            return {
                orders,
                total,
                page,
                pageSize,
                totalPages: Math.ceil(total / pageSize),
            };
        },
        order: async (_, { id }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const order = await context.prisma.order.findUnique({
                where: { id },
                include: {
                    customer: true,
                    createdBy: true,
                    discount: true,
                    orderItems: {
                        include: {
                            product: {
                                include: {
                                    images: true,
                                },
                            },
                        },
                    },
                },
            });
            if (!order) {
                throw new graphql_1.GraphQLError('Order not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            return order;
        },
        orderByNumber: async (_, { orderNumber }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const order = await context.prisma.order.findUnique({
                where: { orderNumber },
                include: {
                    customer: true,
                    createdBy: true,
                    discount: true,
                    orderItems: {
                        include: {
                            product: true,
                        },
                    },
                },
            });
            if (!order) {
                throw new graphql_1.GraphQLError('Order not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            return order;
        },
    },
    Mutation: {
        createOrder: async (_, { input }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            if (!context.user) {
                throw new graphql_1.GraphQLError('User not authenticated', {
                    extensions: { code: 'UNAUTHENTICATED' },
                });
            }
            if (!input.items || input.items.length === 0) {
                throw new graphql_1.GraphQLError('Order must have at least one item', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            const orderNumber = `ORD-${Date.now()}-${Math.floor(Math.random() * 1000)}`;
            let subtotal = new client_1.Prisma.Decimal(0);
            const orderItemsData = [];
            for (const item of input.items) {
                const product = await context.prisma.product.findUnique({
                    where: { id: item.productId },
                });
                if (!product) {
                    throw new graphql_1.GraphQLError(`Product ${item.productId} not found`, {
                        extensions: { code: 'NOT_FOUND' },
                    });
                }
                if (product.stock < item.quantity) {
                    throw new graphql_1.GraphQLError(`Insufficient stock for product ${product.name}`, {
                        extensions: { code: 'BAD_USER_INPUT' },
                    });
                }
                const itemSubtotal = new client_1.Prisma.Decimal(item.unitPrice).mul(item.quantity);
                subtotal = subtotal.add(itemSubtotal);
                orderItemsData.push({
                    productId: item.productId,
                    quantity: item.quantity,
                    unitPrice: item.unitPrice,
                    subtotal: itemSubtotal,
                    discountAmount: new client_1.Prisma.Decimal(0),
                    total: itemSubtotal,
                });
            }
            let discountAmount = new client_1.Prisma.Decimal(0);
            let discountId = null;
            if (input.discountId) {
                const discount = await context.prisma.discount.findUnique({
                    where: { id: input.discountId },
                });
                if (!discount) {
                    throw new graphql_1.GraphQLError('Discount not found', {
                        extensions: { code: 'NOT_FOUND' },
                    });
                }
                if (!discount.isActive) {
                    throw new graphql_1.GraphQLError('Discount is not active', {
                        extensions: { code: 'BAD_USER_INPUT' },
                    });
                }
                if (discount.usageLimit && discount.usageCount >= discount.usageLimit) {
                    throw new graphql_1.GraphQLError('Discount usage limit reached', {
                        extensions: { code: 'BAD_USER_INPUT' },
                    });
                }
                const now = new Date();
                if (discount.startDate && discount.startDate > now) {
                    throw new graphql_1.GraphQLError('Discount not yet valid', {
                        extensions: { code: 'BAD_USER_INPUT' },
                    });
                }
                if (discount.endDate && discount.endDate < now) {
                    throw new graphql_1.GraphQLError('Discount has expired', {
                        extensions: { code: 'BAD_USER_INPUT' },
                    });
                }
                if (discount.minPurchase && subtotal.lt(discount.minPurchase)) {
                    throw new graphql_1.GraphQLError(`Minimum purchase of ${discount.minPurchase} required`, {
                        extensions: { code: 'BAD_USER_INPUT' },
                    });
                }
                if (discount.type === 'PERCENTAGE') {
                    discountAmount = subtotal.mul(discount.value).div(100);
                    if (discount.maxDiscount && discountAmount.gt(discount.maxDiscount)) {
                        discountAmount = discount.maxDiscount;
                    }
                }
                else if (discount.type === 'FIXED_AMOUNT') {
                    discountAmount = discount.value;
                }
                discountId = discount.id;
            }
            const taxAmount = new client_1.Prisma.Decimal(input.taxAmount || 0);
            const total = subtotal.sub(discountAmount).add(taxAmount);
            const order = await context.prisma.$transaction(async (tx) => {
                const newOrder = await tx.order.create({
                    data: {
                        orderNumber,
                        customerId: input.customerId || null,
                        userId: context.user.id,
                        status: input.status || 'PENDING',
                        subtotal,
                        discountId,
                        discountAmount,
                        taxAmount,
                        total,
                        notes: input.notes || null,
                        completedAt: input.status === 'COMPLETED' ? new Date() : null,
                        orderItems: {
                            create: orderItemsData,
                        },
                    },
                    include: {
                        customer: true,
                        createdBy: true,
                        discount: true,
                        orderItems: {
                            include: {
                                product: true,
                            },
                        },
                    },
                });
                for (const item of input.items) {
                    await tx.product.update({
                        where: { id: item.productId },
                        data: {
                            stock: {
                                decrement: item.quantity,
                            },
                            popularity: {
                                increment: item.quantity,
                            },
                        },
                    });
                }
                if (discountId) {
                    await tx.discount.update({
                        where: { id: discountId },
                        data: {
                            usageCount: {
                                increment: 1,
                            },
                        },
                    });
                }
                if (input.customerId && input.status === 'COMPLETED') {
                    await tx.customer.update({
                        where: { id: input.customerId },
                        data: {
                            totalSpent: {
                                increment: total,
                            },
                        },
                    });
                }
                if (input.status === 'COMPLETED') {
                    const orderTotalNumber = Number(total);
                    const commissionRate = orderTotalNumber >= 1000 ? 0.05 : 0.03;
                    const commissionAmount = orderTotalNumber * commissionRate;
                    await tx.commission.create({
                        data: {
                            userId: context.user.id,
                            orderId: newOrder.id,
                            orderTotal: orderTotalNumber,
                            commissionRate,
                            commissionAmount,
                            isPaid: true,
                        },
                    });
                }
                return newOrder;
            });
            return order;
        },
        updateOrder: async (_, { id, input }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const existingOrder = await context.prisma.order.findUnique({
                where: { id },
                include: {
                    orderItems: true,
                    discount: true,
                },
            });
            if (!existingOrder) {
                throw new graphql_1.GraphQLError('Order not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            if (existingOrder.status === 'COMPLETED' || existingOrder.status === 'CANCELLED') {
                throw new graphql_1.GraphQLError(`Cannot edit order with status ${existingOrder.status}`, {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            const order = await context.prisma.$transaction(async (tx) => {
                const updateData = {};
                if (input.customerId !== undefined) {
                    updateData.customerId = input.customerId;
                }
                if (input.discountId !== undefined) {
                    updateData.discountId = input.discountId;
                }
                if (input.status !== undefined) {
                    updateData.status = input.status;
                    if (input.status === 'COMPLETED' && existingOrder.status !== 'COMPLETED') {
                        updateData.completedAt = new Date();
                    }
                }
                if (input.notes !== undefined) {
                    updateData.notes = input.notes;
                }
                if (input.items && Array.isArray(input.items)) {
                    const existingItems = existingOrder.orderItems;
                    const newItems = input.items;
                    const existingItemMap = new Map(existingItems.map(item => [item.productId, item]));
                    const newItemProductIds = new Set(newItems.map((item) => item.productId));
                    const itemsToDelete = existingItems.filter(item => !newItemProductIds.has(item.productId));
                    for (const newItem of newItems) {
                        const existingItem = existingItemMap.get(newItem.productId);
                        if (existingItem) {
                            const itemSubtotal = new client_1.Prisma.Decimal(newItem.quantity).mul(new client_1.Prisma.Decimal(newItem.unitPrice));
                            await tx.orderItem.update({
                                where: { id: existingItem.id },
                                data: {
                                    quantity: newItem.quantity,
                                    unitPrice: new client_1.Prisma.Decimal(newItem.unitPrice),
                                    subtotal: itemSubtotal,
                                    total: itemSubtotal,
                                },
                            });
                        }
                        else {
                            const itemSubtotal = new client_1.Prisma.Decimal(newItem.quantity).mul(new client_1.Prisma.Decimal(newItem.unitPrice));
                            await tx.orderItem.create({
                                data: {
                                    orderId: id,
                                    productId: newItem.productId,
                                    quantity: newItem.quantity,
                                    unitPrice: new client_1.Prisma.Decimal(newItem.unitPrice),
                                    subtotal: itemSubtotal,
                                    discountAmount: new client_1.Prisma.Decimal(0),
                                    total: itemSubtotal,
                                },
                            });
                        }
                    }
                    for (const itemToDelete of itemsToDelete) {
                        await tx.orderItem.delete({
                            where: { id: itemToDelete.id },
                        });
                    }
                }
                if ((input.items && Array.isArray(input.items)) || input.discountId !== undefined) {
                    const updatedItems = await tx.orderItem.findMany({
                        where: { orderId: id },
                    });
                    const subtotal = updatedItems.reduce((sum, item) => sum.add(item.total), new client_1.Prisma.Decimal(0));
                    let discountAmount = new client_1.Prisma.Decimal(0);
                    const discountId = input.discountId !== undefined ? input.discountId : existingOrder.discountId;
                    if (discountId) {
                        const discount = await tx.discount.findUnique({ where: { id: discountId } });
                        if (discount && discount.isActive) {
                            if (discount.type === 'PERCENTAGE') {
                                discountAmount = subtotal.mul(discount.value).div(100);
                                if (discount.maxDiscount && discountAmount.gt(discount.maxDiscount)) {
                                    discountAmount = discount.maxDiscount;
                                }
                            }
                            else if (discount.type === 'FIXED_AMOUNT') {
                                discountAmount = discount.value;
                            }
                        }
                    }
                    const taxAmount = existingOrder.taxAmount ? new client_1.Prisma.Decimal(existingOrder.taxAmount) : new client_1.Prisma.Decimal(0);
                    const total = subtotal.sub(discountAmount).add(taxAmount);
                    updateData.subtotal = subtotal;
                    updateData.discountAmount = discountAmount;
                    updateData.total = total;
                }
                const updatedOrder = await tx.order.update({
                    where: { id },
                    data: updateData,
                    include: {
                        customer: true,
                        createdBy: true,
                        discount: true,
                        orderItems: {
                            include: {
                                product: true,
                            },
                        },
                    },
                });
                if (input.status === 'COMPLETED' && existingOrder.status !== 'COMPLETED') {
                    const existingCommission = await tx.commission.findUnique({
                        where: { orderId: id },
                    });
                    if (!existingCommission) {
                        const orderTotalNumber = Number(updatedOrder.total);
                        const commissionRate = orderTotalNumber >= 1000 ? 0.05 : 0.03;
                        const commissionAmount = orderTotalNumber * commissionRate;
                        await tx.commission.create({
                            data: {
                                userId: updatedOrder.userId,
                                orderId: updatedOrder.id,
                                orderTotal: orderTotalNumber,
                                commissionRate,
                                commissionAmount,
                                isPaid: true,
                            },
                        });
                    }
                    if (updatedOrder.customerId) {
                        await tx.customer.update({
                            where: { id: updatedOrder.customerId },
                            data: {
                                totalSpent: {
                                    increment: updatedOrder.total,
                                },
                            },
                        });
                    }
                }
                if (input.status === 'CANCELLED' && existingOrder.status !== 'CANCELLED') {
                    for (const item of existingOrder.orderItems) {
                        await tx.product.update({
                            where: { id: item.productId },
                            data: {
                                stock: {
                                    increment: item.quantity,
                                },
                                popularity: {
                                    decrement: item.quantity,
                                },
                            },
                        });
                    }
                    if (existingOrder.discountId) {
                        await tx.discount.update({
                            where: { id: existingOrder.discountId },
                            data: {
                                usageCount: {
                                    decrement: 1,
                                },
                            },
                        });
                    }
                    if (existingOrder.customerId) {
                        await tx.customer.update({
                            where: { id: existingOrder.customerId },
                            data: {
                                totalSpent: {
                                    decrement: existingOrder.total,
                                },
                            },
                        });
                    }
                }
                return updatedOrder;
            });
            return order;
        },
        cancelOrder: async (_, { id }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            (0, auth_middleware_1.requireRole)(context, ['ADMIN', 'MANAGER', 'STAFF']);
            const existingOrder = await context.prisma.order.findUnique({
                where: { id },
                include: {
                    orderItems: true,
                    customer: true,
                },
            });
            if (!existingOrder) {
                throw new graphql_1.GraphQLError('Order not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            if (existingOrder.status === 'CANCELLED') {
                throw new graphql_1.GraphQLError('Order is already cancelled', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            if (existingOrder.status === 'COMPLETED') {
                throw new graphql_1.GraphQLError('Cannot cancel completed order', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            const order = await context.prisma.$transaction(async (tx) => {
                const cancelledOrder = await tx.order.update({
                    where: { id },
                    data: {
                        status: 'CANCELLED',
                    },
                    include: {
                        customer: true,
                        createdBy: true,
                        discount: true,
                        orderItems: {
                            include: {
                                product: true,
                            },
                        },
                    },
                });
                for (const item of existingOrder.orderItems) {
                    await tx.product.update({
                        where: { id: item.productId },
                        data: {
                            stock: {
                                increment: item.quantity,
                            },
                            popularity: {
                                decrement: item.quantity,
                            },
                        },
                    });
                }
                if (existingOrder.discountId) {
                    await tx.discount.update({
                        where: { id: existingOrder.discountId },
                        data: {
                            usageCount: {
                                decrement: 1,
                            },
                        },
                    });
                }
                if (existingOrder.customerId) {
                    await tx.customer.update({
                        where: { id: existingOrder.customerId },
                        data: {
                            totalSpent: {
                                decrement: existingOrder.total,
                            },
                        },
                    });
                }
                return cancelledOrder;
            });
            return order;
        },
    },
    Order: {
        customer: async (parent, _, context) => {
            if (!parent.customerId)
                return null;
            return context.prisma.customer.findUnique({
                where: { id: parent.customerId },
            });
        },
        createdBy: async (parent, _, context) => {
            return context.prisma.user.findUnique({
                where: { id: parent.userId },
            });
        },
        discount: async (parent, _, context) => {
            if (!parent.discountId)
                return null;
            return context.prisma.discount.findUnique({
                where: { id: parent.discountId },
            });
        },
        orderItems: async (parent, _, context) => {
            return context.prisma.orderItem.findMany({
                where: { orderId: parent.id },
                include: {
                    product: true,
                },
            });
        },
    },
    OrderItem: {
        product: async (parent, _, context) => {
            return context.prisma.product.findUnique({
                where: { id: parent.productId },
            });
        },
    },
};
//# sourceMappingURL=order.resolver.js.map