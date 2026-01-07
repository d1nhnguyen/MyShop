"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.customerResolvers = void 0;
const graphql_1 = require("graphql");
const auth_middleware_1 = require("../../middleware/auth.middleware");
exports.customerResolvers = {
    Query: {
        customers: async (_, { pagination, sort, filter }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const page = pagination?.page || 1;
            const pageSize = Math.min(pagination?.pageSize || 20, 100);
            const skip = (page - 1) * pageSize;
            const where = {};
            if (filter) {
                if (filter.name) {
                    where.name = { contains: filter.name, mode: 'insensitive' };
                }
                if (filter.email) {
                    where.email = { contains: filter.email, mode: 'insensitive' };
                }
                if (filter.phone) {
                    where.phone = { contains: filter.phone };
                }
                if (filter.isMember !== undefined) {
                    where.isMember = filter.isMember;
                }
            }
            const orderBy = sort
                ? { [sort.field]: sort.order.toLowerCase() }
                : { createdAt: 'desc' };
            const [customers, total] = await Promise.all([
                context.prisma.customer.findMany({
                    where,
                    skip,
                    take: pageSize,
                    orderBy,
                    include: {
                        _count: {
                            select: { orders: true },
                        },
                    },
                }),
                context.prisma.customer.count({ where }),
            ]);
            return {
                customers,
                total,
                page,
                pageSize,
                totalPages: Math.ceil(total / pageSize),
            };
        },
        customer: async (_, { id }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const customer = await context.prisma.customer.findUnique({
                where: { id },
                include: {
                    orders: {
                        orderBy: { createdAt: 'desc' },
                        take: 10,
                    },
                    _count: {
                        select: { orders: true },
                    },
                },
            });
            if (!customer) {
                throw new graphql_1.GraphQLError('Customer not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            return customer;
        },
    },
    Mutation: {
        createCustomer: async (_, { input }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            if (input.email) {
                const existingEmail = await context.prisma.customer.findUnique({
                    where: { email: input.email },
                });
                if (existingEmail) {
                    throw new graphql_1.GraphQLError('Email already exists', {
                        extensions: { code: 'BAD_USER_INPUT' },
                    });
                }
            }
            const customerData = {
                ...input,
            };
            if (!customerData.email)
                delete customerData.email;
            if (!customerData.address)
                delete customerData.address;
            if (!customerData.notes)
                delete customerData.notes;
            if (input.isMember) {
                customerData.memberSince = new Date();
            }
            const customer = await context.prisma.customer.create({
                data: customerData,
                include: {
                    _count: {
                        select: { orders: true },
                    },
                },
            });
            return customer;
        },
        updateCustomer: async (_, { id, input }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const existingCustomer = await context.prisma.customer.findUnique({
                where: { id },
            });
            if (!existingCustomer) {
                throw new graphql_1.GraphQLError('Customer not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            if (input.email && input.email !== existingCustomer.email) {
                const emailConflict = await context.prisma.customer.findUnique({
                    where: { email: input.email },
                });
                if (emailConflict) {
                    throw new graphql_1.GraphQLError('Email already exists', {
                        extensions: { code: 'BAD_USER_INPUT' },
                    });
                }
            }
            const updateData = { ...input };
            if (updateData.email === '')
                updateData.email = null;
            if (updateData.address === '')
                updateData.address = null;
            if (updateData.notes === '')
                updateData.notes = null;
            if (input.isMember && !existingCustomer.isMember) {
                updateData.memberSince = new Date();
            }
            const customer = await context.prisma.customer.update({
                where: { id },
                data: updateData,
                include: {
                    _count: {
                        select: { orders: true },
                    },
                },
            });
            return customer;
        },
        deleteCustomer: async (_, { id }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            (0, auth_middleware_1.requireRole)(context, ['ADMIN', 'MANAGER']);
            const existingCustomer = await context.prisma.customer.findUnique({
                where: { id },
                include: {
                    _count: {
                        select: { orders: true },
                    },
                },
            });
            if (!existingCustomer) {
                throw new graphql_1.GraphQLError('Customer not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            if (existingCustomer._count.orders > 0) {
                throw new graphql_1.GraphQLError('Cannot delete customer with orders', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            await context.prisma.customer.delete({
                where: { id },
            });
            return true;
        },
    },
    Customer: {
        orderCount: async (parent, _, context) => {
            const count = await context.prisma.order.count({
                where: { customerId: parent.id },
            });
            return count;
        },
        orders: async (parent, _, context) => {
            return context.prisma.order.findMany({
                where: { customerId: parent.id },
                orderBy: { createdAt: 'desc' },
            });
        },
    },
};
//# sourceMappingURL=customer.resolver.js.map