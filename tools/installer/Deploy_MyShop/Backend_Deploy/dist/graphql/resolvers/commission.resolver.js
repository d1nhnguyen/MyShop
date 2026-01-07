"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.commissionResolvers = void 0;
exports.commissionResolvers = {
    Query: {
        getCommissions: async (_, { filter, pagination, }, { prisma, user }) => {
            if (!user)
                throw new Error('Not authenticated');
            const page = pagination?.page || 1;
            const pageSize = pagination?.pageSize || 20;
            const skip = (page - 1) * pageSize;
            const where = {};
            if (filter?.userId) {
                where.userId = filter.userId;
            }
            if (filter?.isPaid !== undefined) {
                where.isPaid = filter.isPaid;
            }
            if (filter?.dateRange) {
                where.createdAt = {
                    gte: filter.dateRange.from,
                    lte: filter.dateRange.to,
                };
            }
            const [items, total] = await Promise.all([
                prisma.commission.findMany({
                    where,
                    skip,
                    take: pageSize,
                    orderBy: { createdAt: 'desc' },
                }),
                prisma.commission.count({ where }),
            ]);
            return {
                items,
                total,
                page,
                pageSize,
                totalPages: Math.ceil(total / pageSize),
            };
        },
        getUserCommissions: async (_, { userId }, { prisma, user }) => {
            if (!user)
                throw new Error('Not authenticated');
            return prisma.commission.findMany({
                where: { userId },
                orderBy: { createdAt: 'desc' },
            });
        },
        getCommissionStats: async (_, { userId, dateRange, }, { prisma, user }) => {
            if (!user)
                throw new Error('Not authenticated');
            const where = {};
            if (userId) {
                where.userId = userId;
            }
            if (dateRange) {
                where.createdAt = {
                    gte: dateRange.from,
                    lte: dateRange.to,
                };
            }
            const commissions = await prisma.commission.findMany({ where });
            const totalCommission = commissions.reduce((sum, c) => sum + Number(c.commissionAmount), 0);
            const paidCommission = commissions
                .filter((c) => c.isPaid)
                .reduce((sum, c) => sum + Number(c.commissionAmount), 0);
            const unpaidCommission = commissions
                .filter((c) => !c.isPaid)
                .reduce((sum, c) => sum + Number(c.commissionAmount), 0);
            return {
                totalCommission,
                paidCommission,
                unpaidCommission,
                totalOrders: commissions.length,
            };
        },
    },
    Mutation: {
        calculateCommission: async (_, { orderId }, { prisma, user }) => {
            if (!user)
                throw new Error('Not authenticated');
            const order = await prisma.order.findUnique({
                where: { id: orderId },
                include: { orderItems: true },
            });
            if (!order)
                throw new Error('Order not found');
            const existing = await prisma.commission.findUnique({
                where: { orderId },
            });
            if (existing) {
                throw new Error('Commission already calculated for this order');
            }
            const orderTotal = order.orderItems.reduce((sum, item) => sum + Number(item.unitPrice) * item.quantity, 0);
            const commissionRate = orderTotal >= 1000 ? 0.05 : 0.03;
            const commissionAmount = orderTotal * commissionRate;
            const commission = await prisma.commission.create({
                data: {
                    userId: order.userId,
                    orderId: order.id,
                    orderTotal,
                    commissionRate,
                    commissionAmount,
                    isPaid: false,
                },
            });
            return commission;
        },
        markCommissionPaid: async (_, { id }, { prisma, user }) => {
            if (!user)
                throw new Error('Not authenticated');
            const commission = await prisma.commission.update({
                where: { id },
                data: { isPaid: true },
            });
            return commission;
        },
    },
    Commission: {
        user: async (parent, _, { prisma }) => {
            return prisma.user.findUnique({
                where: { id: parent.userId },
            });
        },
        order: async (parent, _, { prisma }) => {
            return prisma.order.findUnique({
                where: { id: parent.orderId },
            });
        },
    },
};
//# sourceMappingURL=commission.resolver.js.map