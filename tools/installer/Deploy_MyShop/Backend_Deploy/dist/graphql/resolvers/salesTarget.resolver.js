"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.salesTargetResolvers = void 0;
exports.salesTargetResolvers = {
    Query: {
        getSalesTargets: async (_, { filter, pagination, }, { prisma, user }) => {
            if (!user)
                throw new Error('Not authenticated');
            const page = pagination?.page || 1;
            const pageSize = pagination?.pageSize || 20;
            const skip = (page - 1) * pageSize;
            const where = {};
            if (filter?.userId) {
                where.userId = filter.userId;
            }
            if (filter?.month) {
                where.month = filter.month;
            }
            if (filter?.year) {
                where.year = filter.year;
            }
            const [items, total] = await Promise.all([
                prisma.salesTarget.findMany({
                    where,
                    skip,
                    take: pageSize,
                    orderBy: [{ year: 'desc' }, { month: 'desc' }],
                }),
                prisma.salesTarget.count({ where }),
            ]);
            return {
                items,
                total,
                page,
                pageSize,
                totalPages: Math.ceil(total / pageSize),
            };
        },
        getMonthlyTarget: async (_, { userId, month, year }, { prisma, user }) => {
            if (!user)
                throw new Error('Not authenticated');
            return prisma.salesTarget.findUnique({
                where: {
                    userId_month_year: {
                        userId,
                        month,
                        year,
                    },
                },
            });
        },
        getUserTargets: async (_, { userId }, { prisma, user }) => {
            if (!user)
                throw new Error('Not authenticated');
            return prisma.salesTarget.findMany({
                where: { userId },
                orderBy: [{ year: 'desc' }, { month: 'desc' }],
            });
        },
    },
    Mutation: {
        createSalesTarget: async (_, { input }, { prisma, user }) => {
            if (!user)
                throw new Error('Not authenticated');
            if (input.month < 1 || input.month > 12) {
                throw new Error('Month must be between 1 and 12');
            }
            const existing = await prisma.salesTarget.findUnique({
                where: {
                    userId_month_year: {
                        userId: input.userId,
                        month: input.month,
                        year: input.year,
                    },
                },
            });
            if (existing) {
                throw new Error(`Target already exists for user ${input.userId} in ${input.month}/${input.year}`);
            }
            const target = await prisma.salesTarget.create({
                data: {
                    userId: input.userId,
                    month: input.month,
                    year: input.year,
                    targetAmount: input.targetAmount,
                    commissionRate: input.commissionRate,
                },
            });
            return target;
        },
        updateSalesTarget: async (_, { id, input }, { prisma, user }) => {
            if (!user)
                throw new Error('Not authenticated');
            const target = await prisma.salesTarget.update({
                where: { id },
                data: {
                    ...(input.targetAmount !== undefined && {
                        targetAmount: input.targetAmount,
                    }),
                    ...(input.achievedAmount !== undefined && {
                        achievedAmount: input.achievedAmount,
                    }),
                    ...(input.commissionRate !== undefined && {
                        commissionRate: input.commissionRate,
                    }),
                },
            });
            return target;
        },
        deleteSalesTarget: async (_, { id }, { prisma, user }) => {
            if (!user)
                throw new Error('Not authenticated');
            await prisma.salesTarget.delete({
                where: { id },
            });
            return true;
        },
    },
    SalesTarget: {
        achievementRate: (parent) => {
            const target = Number(parent.targetAmount);
            const achieved = Number(parent.achievedAmount);
            if (target === 0)
                return 0;
            return (achieved / target) * 100;
        },
        isAchieved: (parent) => {
            return Number(parent.achievedAmount) >= Number(parent.targetAmount);
        },
    },
};
//# sourceMappingURL=salesTarget.resolver.js.map