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
export declare const salesTargetResolvers: {
    Query: {
        getSalesTargets: (_: any, { filter, pagination, }: {
            filter?: SalesTargetFilterInput;
            pagination?: PaginationInput;
        }, { prisma, user }: Context) => Promise<{
            items: {
                id: number;
                createdAt: Date;
                updatedAt: Date;
                userId: number;
                commissionRate: Prisma.Decimal;
                month: number;
                year: number;
                targetAmount: Prisma.Decimal;
                achievedAmount: Prisma.Decimal;
            }[];
            total: number;
            page: number;
            pageSize: number;
            totalPages: number;
        }>;
        getMonthlyTarget: (_: any, { userId, month, year }: {
            userId: number;
            month: number;
            year: number;
        }, { prisma, user }: Context) => Promise<{
            id: number;
            createdAt: Date;
            updatedAt: Date;
            userId: number;
            commissionRate: Prisma.Decimal;
            month: number;
            year: number;
            targetAmount: Prisma.Decimal;
            achievedAmount: Prisma.Decimal;
        } | null>;
        getUserTargets: (_: any, { userId }: {
            userId: number;
        }, { prisma, user }: Context) => Promise<{
            id: number;
            createdAt: Date;
            updatedAt: Date;
            userId: number;
            commissionRate: Prisma.Decimal;
            month: number;
            year: number;
            targetAmount: Prisma.Decimal;
            achievedAmount: Prisma.Decimal;
        }[]>;
    };
    Mutation: {
        createSalesTarget: (_: any, { input }: {
            input: CreateSalesTargetInput;
        }, { prisma, user }: Context) => Promise<{
            id: number;
            createdAt: Date;
            updatedAt: Date;
            userId: number;
            commissionRate: Prisma.Decimal;
            month: number;
            year: number;
            targetAmount: Prisma.Decimal;
            achievedAmount: Prisma.Decimal;
        }>;
        updateSalesTarget: (_: any, { id, input }: {
            id: number;
            input: UpdateSalesTargetInput;
        }, { prisma, user }: Context) => Promise<{
            id: number;
            createdAt: Date;
            updatedAt: Date;
            userId: number;
            commissionRate: Prisma.Decimal;
            month: number;
            year: number;
            targetAmount: Prisma.Decimal;
            achievedAmount: Prisma.Decimal;
        }>;
        deleteSalesTarget: (_: any, { id }: {
            id: number;
        }, { prisma, user }: Context) => Promise<boolean>;
    };
    SalesTarget: {
        achievementRate: (parent: any) => number;
        isAchieved: (parent: any) => boolean;
    };
};
//# sourceMappingURL=salesTarget.resolver.d.ts.map