"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.userResolvers = void 0;
const graphql_1 = require("graphql");
const auth_1 = require("../../utils/auth");
const auth_middleware_1 = require("../../middleware/auth.middleware");
exports.userResolvers = {
    Query: {
        users: async (_, { pagination, sort }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            (0, auth_middleware_1.requireRole)(context, ['ADMIN', 'MANAGER']);
            const page = pagination?.page || 1;
            const pageSize = Math.min(pagination?.pageSize || 20, 100);
            const skip = (page - 1) * pageSize;
            const orderBy = sort
                ? { [sort.field]: sort.order.toLowerCase() }
                : { createdAt: 'desc' };
            const [users, total] = await Promise.all([
                context.prisma.user.findMany({
                    skip,
                    take: pageSize,
                    orderBy,
                }),
                context.prisma.user.count(),
            ]);
            return {
                users,
                total,
                page,
                pageSize,
                totalPages: Math.ceil(total / pageSize),
            };
        },
        user: async (_, { id }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const user = await context.prisma.user.findUnique({
                where: { id },
            });
            if (!user) {
                throw new graphql_1.GraphQLError('User not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            return user;
        },
        userByUsername: async (_, { username }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const user = await context.prisma.user.findFirst({
                where: {
                    username: {
                        equals: username,
                        mode: 'insensitive'
                    }
                },
            });
            return user;
        },
    },
    Mutation: {
        createUser: async (_, { input }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            (0, auth_middleware_1.requireRole)(context, ['ADMIN']);
            const existingUser = await context.prisma.user.findFirst({
                where: {
                    username: {
                        equals: input.username,
                        mode: 'insensitive'
                    }
                },
            });
            if (existingUser) {
                throw new graphql_1.GraphQLError('Username already exists', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            const existingEmail = await context.prisma.user.findUnique({
                where: { email: input.email },
            });
            if (existingEmail) {
                throw new graphql_1.GraphQLError('Email already exists', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            const hashedPassword = await auth_1.AuthUtils.hashPassword(input.password);
            const user = await context.prisma.user.create({
                data: {
                    ...input,
                    password: hashedPassword,
                },
            });
            return user;
        },
        updateUser: async (_, { id, input }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            (0, auth_middleware_1.requireRole)(context, ['ADMIN']);
            const existingUser = await context.prisma.user.findUnique({
                where: { id },
            });
            if (!existingUser) {
                throw new graphql_1.GraphQLError('User not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            const updateData = { ...input };
            if (input.password) {
                updateData.password = await auth_1.AuthUtils.hashPassword(input.password);
            }
            const user = await context.prisma.user.update({
                where: { id },
                data: updateData,
            });
            return user;
        },
        deleteUser: async (_, { id }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            (0, auth_middleware_1.requireRole)(context, ['ADMIN']);
            if (context.user?.id === id) {
                throw new graphql_1.GraphQLError('Cannot delete your own account', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            const existingUser = await context.prisma.user.findUnique({
                where: { id },
            });
            if (!existingUser) {
                throw new graphql_1.GraphQLError('User not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            await context.prisma.user.delete({
                where: { id },
            });
            return true;
        },
    },
};
//# sourceMappingURL=user.resolver.js.map