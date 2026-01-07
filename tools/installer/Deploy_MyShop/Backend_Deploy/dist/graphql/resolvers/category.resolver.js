"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.categoryResolvers = void 0;
const graphql_1 = require("graphql");
const auth_middleware_1 = require("../../middleware/auth.middleware");
exports.categoryResolvers = {
    Query: {
        categories: async (_, { pagination, sort }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const page = pagination?.page || 1;
            const pageSize = Math.min(pagination?.pageSize || 20, 100);
            const skip = (page - 1) * pageSize;
            const orderBy = sort
                ? { [sort.field]: sort.order.toLowerCase() }
                : { name: 'asc' };
            const [categories, total] = await Promise.all([
                context.prisma.category.findMany({
                    skip,
                    take: pageSize,
                    orderBy,
                    include: {
                        _count: {
                            select: { products: true },
                        },
                    },
                }),
                context.prisma.category.count(),
            ]);
            return {
                categories,
                total,
                page,
                pageSize,
                totalPages: Math.ceil(total / pageSize),
            };
        },
        category: async (_, { id }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const category = await context.prisma.category.findUnique({
                where: { id },
                include: {
                    products: true,
                    _count: {
                        select: { products: true },
                    },
                },
            });
            if (!category) {
                throw new graphql_1.GraphQLError('Category not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            return category;
        },
        activeCategories: async (_, __, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            return context.prisma.category.findMany({
                where: { isActive: true },
                orderBy: { name: 'asc' },
            });
        },
    },
    Mutation: {
        createCategory: async (_, { input }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            (0, auth_middleware_1.requireRole)(context, ['ADMIN', 'MANAGER']);
            const existingCategory = await context.prisma.category.findUnique({
                where: { name: input.name },
            });
            if (existingCategory) {
                throw new graphql_1.GraphQLError('Category name already exists', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            const category = await context.prisma.category.create({
                data: input,
                include: {
                    _count: {
                        select: { products: true },
                    },
                },
            });
            return category;
        },
        updateCategory: async (_, { id, input }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            (0, auth_middleware_1.requireRole)(context, ['ADMIN', 'MANAGER']);
            const existingCategory = await context.prisma.category.findUnique({
                where: { id },
            });
            if (!existingCategory) {
                throw new graphql_1.GraphQLError('Category not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            if (input.name && input.name !== existingCategory.name) {
                const nameConflict = await context.prisma.category.findUnique({
                    where: { name: input.name },
                });
                if (nameConflict) {
                    throw new graphql_1.GraphQLError('Category name already exists', {
                        extensions: { code: 'BAD_USER_INPUT' },
                    });
                }
            }
            const category = await context.prisma.category.update({
                where: { id },
                data: input,
                include: {
                    _count: {
                        select: { products: true },
                    },
                },
            });
            return category;
        },
        deleteCategory: async (_, { id }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            (0, auth_middleware_1.requireRole)(context, ['ADMIN']);
            const existingCategory = await context.prisma.category.findUnique({
                where: { id },
                include: {
                    _count: {
                        select: { products: true },
                    },
                },
            });
            if (!existingCategory) {
                throw new graphql_1.GraphQLError('Category not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            if (existingCategory._count.products > 0) {
                throw new graphql_1.GraphQLError('Cannot delete category with products', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            await context.prisma.category.delete({
                where: { id },
            });
            return true;
        },
    },
    Category: {
        productCount: async (parent, _, context) => {
            const count = await context.prisma.product.count({
                where: { categoryId: parent.id },
            });
            return count;
        },
        products: async (parent, _, context) => {
            return context.prisma.product.findMany({
                where: { categoryId: parent.id },
            });
        },
    },
};
//# sourceMappingURL=category.resolver.js.map