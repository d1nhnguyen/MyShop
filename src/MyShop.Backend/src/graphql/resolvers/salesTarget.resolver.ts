import { Context } from '../../types/context';
import { Prisma } from '@prisma/client';

export interface CreateSalesTargetInput {
    userId: number;
    month: number;
    year: number;
    targetAmount: number;
    commissionRate: number;
}

export interface UpdateSalesTargetInput {
    targetAmount?: number;
    achievedAmount?: number;
    commissionRate?: number;
}

export interface SalesTargetFilterInput {
    userId?: number;
    month?: number;
    year?: number;
}

export interface PaginationInput {
    page?: number;
    pageSize?: number;
}

export const salesTargetResolvers = {
    Query: {
        // Get paginated sales targets with filters
        getSalesTargets: async (
            _: any,
            {
                filter,
                pagination,
            }: { filter?: SalesTargetFilterInput; pagination?: PaginationInput },
            { prisma, user }: Context
        ) => {
            if (!user) throw new Error('Not authenticated');

            const page = pagination?.page || 1;
            const pageSize = pagination?.pageSize || 20;
            const skip = (page - 1) * pageSize;

            // Build where clause
            const where: Prisma.SalesTargetWhereInput = {};

            if (filter?.userId) {
                where.userId = filter.userId;
            }

            if (filter?.month) {
                where.month = filter.month;
            }

            if (filter?.year) {
                where.year = filter.year;
            }

            // Execute queries
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

        // Get specific monthly target
        getMonthlyTarget: async (
            _: any,
            { userId, month, year }: { userId: number; month: number; year: number },
            { prisma, user }: Context
        ) => {
            if (!user) throw new Error('Not authenticated');

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

        // Get all targets for a user
        getUserTargets: async (
            _: any,
            { userId }: { userId: number },
            { prisma, user }: Context
        ) => {
            if (!user) throw new Error('Not authenticated');

            return prisma.salesTarget.findMany({
                where: { userId },
                orderBy: [{ year: 'desc' }, { month: 'desc' }],
            });
        },
    },

    Mutation: {
        // Create new sales target
        createSalesTarget: async (
            _: any,
            { input }: { input: CreateSalesTargetInput },
            { prisma, user }: Context
        ) => {
            if (!user) throw new Error('Not authenticated');

            // Validate month (1-12)
            if (input.month < 1 || input.month > 12) {
                throw new Error('Month must be between 1 and 12');
            }

            // Check if target already exists
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
                throw new Error(
                    `Target already exists for user ${input.userId} in ${input.month}/${input.year}`
                );
            }

            // Create target
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

        // Update sales target
        updateSalesTarget: async (
            _: any,
            { id, input }: { id: number; input: UpdateSalesTargetInput },
            { prisma, user }: Context
        ) => {
            if (!user) throw new Error('Not authenticated');

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

        // Delete sales target
        deleteSalesTarget: async (
            _: any,
            { id }: { id: number },
            { prisma, user }: Context
        ) => {
            if (!user) throw new Error('Not authenticated');

            await prisma.salesTarget.delete({
                where: { id },
            });

            return true;
        },
    },

    SalesTarget: {
        // Calculate achievement rate
        achievementRate: (parent: any) => {
            const target = Number(parent.targetAmount);
            const achieved = Number(parent.achievedAmount);
            if (target === 0) return 0;
            return (achieved / target) * 100;
        },

        // Check if target is achieved
        isAchieved: (parent: any) => {
            return Number(parent.achievedAmount) >= Number(parent.targetAmount);
        },
    },
};
