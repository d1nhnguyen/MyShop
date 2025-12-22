import { GraphQLError } from 'graphql';
import { Context } from '../../types/context';
import { requireAuth, requireRole } from '../../middleware/auth.middleware';

export const discountResolvers = {
  Query: {
    discounts: async (_: any, { pagination, sort }: any, context: Context) => {
      requireAuth(context);

      const page = pagination?.page || 1;
      const pageSize = Math.min(pagination?.pageSize || 20, 100);
      const skip = (page - 1) * pageSize;

      const orderBy: any = sort
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

    discount: async (_: any, { id }: any, context: Context) => {
      requireAuth(context);

      const discount = await context.prisma.discount.findUnique({
        where: { id },
      });

      if (!discount) {
        throw new GraphQLError('Discount not found', {
          extensions: { code: 'NOT_FOUND' },
        });
      }

      return discount;
    },

    discountByCode: async (_: any, { code }: any, context: Context) => {
      requireAuth(context);

      const discount = await context.prisma.discount.findUnique({
        where: { code },
      });

      if (!discount) {
        throw new GraphQLError('Discount not found', {
          extensions: { code: 'NOT_FOUND' },
        });
      }

      return discount;
    },

    activeDiscounts: async (_: any, __: any, context: Context) => {
      requireAuth(context);

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
        orderBy: { createdAt: 'desc' } as any,
      });
    },
  },

  Mutation: {
    createDiscount: async (_: any, { input }: any, context: Context) => {
      requireAuth(context);
      requireRole(context, ['ADMIN', 'MANAGER']);

      // Check if code exists
      const existingDiscount = await context.prisma.discount.findUnique({
        where: { code: input.code },
      });

      if (existingDiscount) {
        throw new GraphQLError('Discount code already exists', {
          extensions: { code: 'BAD_USER_INPUT' },
        });
      }

      // Validate discount data
      if (input.type === 'BUY_X_GET_Y' && (!input.buyQuantity || !input.getQuantity)) {
        throw new GraphQLError('Buy X Get Y discount requires buyQuantity and getQuantity', {
          extensions: { code: 'BAD_USER_INPUT' },
        });
      }

      if (input.type === 'WHOLESALE_DISCOUNT' && !input.wholesaleMinQty) {
        throw new GraphQLError('Wholesale discount requires wholesaleMinQty', {
          extensions: { code: 'BAD_USER_INPUT' },
        });
      }

      const discount = await context.prisma.discount.create({
        data: input,
      });

      return discount;
    },

    updateDiscount: async (_: any, { id, input }: any, context: Context) => {
      requireAuth(context);
      requireRole(context, ['ADMIN', 'MANAGER']);

      const existingDiscount = await context.prisma.discount.findUnique({
        where: { id },
      });

      if (!existingDiscount) {
        throw new GraphQLError('Discount not found', {
          extensions: { code: 'NOT_FOUND' },
        });
      }

      // Check if new code conflicts
      if (input.code && input.code !== existingDiscount.code) {
        const codeConflict = await context.prisma.discount.findUnique({
          where: { code: input.code },
        });

        if (codeConflict) {
          throw new GraphQLError('Discount code already exists', {
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

    deleteDiscount: async (_: any, { id }: any, context: Context) => {
      requireAuth(context);
      requireRole(context, ['ADMIN']);

      const existingDiscount = await context.prisma.discount.findUnique({
        where: { id },
      });

      if (!existingDiscount) {
        throw new GraphQLError('Discount not found', {
          extensions: { code: 'NOT_FOUND' },
        });
      }

      // Check if discount is used in orders
      const ordersCount = await context.prisma.order.count({
        where: { discountId: id },
      });

      if (ordersCount > 0) {
        throw new GraphQLError('Cannot delete discount that has been used', {
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
