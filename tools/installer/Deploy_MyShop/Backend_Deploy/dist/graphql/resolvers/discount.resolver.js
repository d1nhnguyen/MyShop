"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.discountResolvers = void 0;
const graphql_1 = require("graphql");
const auth_middleware_1 = require("../../middleware/auth.middleware");
exports.discountResolvers = {
    Query: {
        discounts: async (_, { pagination, sort }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const page = pagination?.page || 1;
            const pageSize = Math.min(pagination?.pageSize || 20, 100);
            const skip = (page - 1) * pageSize;
            const orderBy = sort
                ? { [sort.field]: sort.order.toLowerCase() }
                : { createdAt: 'desc' };
            const [discounts, total] = await Promise.all([
                context.prisma.discount.findMany({
                    skip,
                    take: pageSize,
                    orderBy,
                }),
                context.prisma.discount.count(),
            ]);
            return {
                discounts,
                total,
                page,
                pageSize,
                totalPages: Math.ceil(total / pageSize),
            };
        },
        discount: async (_, { id }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const discount = await context.prisma.discount.findUnique({
                where: { id },
            });
            if (!discount) {
                throw new graphql_1.GraphQLError('Discount not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            return discount;
        },
        discountByCode: async (_, { code }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const discount = await context.prisma.discount.findUnique({
                where: { code },
            });
            if (!discount) {
                throw new graphql_1.GraphQLError('Discount not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            return discount;
        },
        activeDiscounts: async (_, __, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const now = new Date();
            return context.prisma.discount.findMany({
                where: {
                    isActive: true,
                    AND: [
                        {
                            OR: [
                                { startDate: null },
                                { startDate: { lte: now } },
                            ],
                        },
                        {
                            OR: [
                                { endDate: null },
                                { endDate: { gte: now } },
                            ],
                        },
                    ],
                },
                orderBy: { createdAt: 'desc' },
            });
        },
    },
    Mutation: {
        createDiscount: async (_, { input }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            (0, auth_middleware_1.requireRole)(context, ['ADMIN', 'MANAGER']);
            const existingDiscount = await context.prisma.discount.findUnique({
                where: { code: input.code },
            });
            if (existingDiscount) {
                throw new graphql_1.GraphQLError('Discount code already exists', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            if (input.type === 'BUY_X_GET_Y' && (!input.buyQuantity || !input.getQuantity)) {
                throw new graphql_1.GraphQLError('Buy X Get Y discount requires buyQuantity and getQuantity', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            if (input.type === 'WHOLESALE_DISCOUNT' && !input.wholesaleMinQty) {
                throw new graphql_1.GraphQLError('Wholesale discount requires wholesaleMinQty', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            const discount = await context.prisma.discount.create({
                data: input,
            });
            return discount;
        },
        updateDiscount: async (_, { id, input }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            (0, auth_middleware_1.requireRole)(context, ['ADMIN', 'MANAGER']);
            const existingDiscount = await context.prisma.discount.findUnique({
                where: { id },
            });
            if (!existingDiscount) {
                throw new graphql_1.GraphQLError('Discount not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            if (input.code && input.code !== existingDiscount.code) {
                const codeConflict = await context.prisma.discount.findUnique({
                    where: { code: input.code },
                });
                if (codeConflict) {
                    throw new graphql_1.GraphQLError('Discount code already exists', {
                        extensions: { code: 'BAD_USER_INPUT' },
                    });
                }
            }
            const discount = await context.prisma.discount.update({
                where: { id },
                data: input,
            });
            return discount;
        },
        deleteDiscount: async (_, { id }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            (0, auth_middleware_1.requireRole)(context, ['ADMIN']);
            const existingDiscount = await context.prisma.discount.findUnique({
                where: { id },
            });
            if (!existingDiscount) {
                throw new graphql_1.GraphQLError('Discount not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            const ordersCount = await context.prisma.order.count({
                where: { discountId: id },
            });
            if (ordersCount > 0) {
                throw new graphql_1.GraphQLError('Cannot delete discount that has been used', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            await context.prisma.discount.delete({
                where: { id },
            });
            return true;
        },
    },
};
//# sourceMappingURL=discount.resolver.js.map