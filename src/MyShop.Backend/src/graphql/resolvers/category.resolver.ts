import { GraphQLError } from 'graphql';
import { Context } from '../../types/context';
import { requireAuth, requireRole } from '../../middleware/auth.middleware';

export const categoryResolvers = {
  Query: {
    categories: async (_: any, { pagination, sort }: any, context: Context) => {
      requireAuth(context);

      const page = pagination?.page || 1;
      const pageSize = Math.min(pagination?.pageSize || 20, 100);
      const skip = (page - 1) * pageSize;

      const orderBy: any = sort
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

    category: async (_: any, { id }: any, context: Context) => {
      requireAuth(context);

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
        throw new GraphQLError('Category not found', {
          extensions: { code: 'NOT_FOUND' },
        });
      }

      return category;
    },

    activeCategories: async (_: any, __: any, context: Context) => {
      requireAuth(context);

      return context.prisma.category.findMany({
        where: { isActive: true },
        orderBy: { name: 'asc' },
      });
    },
  },

  Mutation: {
    createCategory: async (_: any, { input }: any, context: Context) => {
      requireAuth(context);
      requireRole(context, ['ADMIN', 'MANAGER']);

      // Check if name exists
      const existingCategory = await context.prisma.category.findUnique({
        where: { name: input.name },
      });

      if (existingCategory) {
        throw new GraphQLError('Category name already exists', {
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

    updateCategory: async (_: any, { id, input }: any, context: Context) => {
      requireAuth(context);
      requireRole(context, ['ADMIN', 'MANAGER']);

      const existingCategory = await context.prisma.category.findUnique({
        where: { id },
      });

      if (!existingCategory) {
        throw new GraphQLError('Category not found', {
          extensions: { code: 'NOT_FOUND' },
        });
      }

      // Check if new name conflicts
      if (input.name && input.name !== existingCategory.name) {
        const nameConflict = await context.prisma.category.findUnique({
          where: { name: input.name },
        });

        if (nameConflict) {
          throw new GraphQLError('Category name already exists', {
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

    deleteCategory: async (_: any, { id }: any, context: Context) => {
      requireAuth(context);
      requireRole(context, ['ADMIN']);

      const existingCategory = await context.prisma.category.findUnique({
        where: { id },
        include: {
          _count: {
            select: { products: true },
          },
        },
      });

      if (!existingCategory) {
        throw new GraphQLError('Category not found', {
          extensions: { code: 'NOT_FOUND' },
        });
      }

      if (existingCategory._count.products > 0) {
        throw new GraphQLError('Cannot delete category with products', {
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
    productCount: async (parent: any, _: any, context: Context) => {
      const count = await context.prisma.product.count({
        where: { categoryId: parent.id },
      });
      return count;
    },

    products: async (parent: any, _: any, context: Context) => {
      return context.prisma.product.findMany({
        where: { categoryId: parent.id },
      });
    },
  },
};
