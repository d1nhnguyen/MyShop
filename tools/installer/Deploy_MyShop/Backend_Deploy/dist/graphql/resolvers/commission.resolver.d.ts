import { Context } from '../../types/context';
import { Prisma } from '@prisma/client';
export interface CommissionFilterInput {
    userId?: number;
    isPaid?: boolean;
    dateRange?: {
        from: Date;
        to: Date;
    };
}
export interface PaginationInput {
    page?: number;
    pageSize?: number;
}
export declare const commissionResolvers: {
    Query: {
        getCommissions: (_: any, { filter, pagination, }: {
            filter?: CommissionFilterInput;
            pagination?: PaginationInput;
        }, { prisma, user }: Context) => Promise<{
            items: {
                id: number;
                createdAt: Date;
                userId: number;
                orderId: number;
                orderTotal: Prisma.Decimal;
                commissionRate: Prisma.Decimal;
                commissionAmount: Prisma.Decimal;
                isPaid: boolean;
                paidAt: Date | null;
            }[];
            total: number;
            page: number;
            pageSize: number;
            totalPages: number;
        }>;
        getUserCommissions: (_: any, { userId }: {
            userId: number;
        }, { prisma, user }: Context) => Promise<{
            id: number;
            createdAt: Date;
            userId: number;
            orderId: number;
            orderTotal: Prisma.Decimal;
            commissionRate: Prisma.Decimal;
            commissionAmount: Prisma.Decimal;
            isPaid: boolean;
            paidAt: Date | null;
        }[]>;
        getCommissionStats: (_: any, { userId, dateRange, }: {
            userId?: number;
            dateRange?: {
                from: Date;
                to: Date;
            };
        }, { prisma, user }: Context) => Promise<{
            totalCommission: number;
            paidCommission: number;
            unpaidCommission: number;
            totalOrders: number;
        }>;
    };
    Mutation: {
        calculateCommission: (_: any, { orderId }: {
            orderId: number;
        }, { prisma, user }: Context) => Promise<{
            id: number;
            createdAt: Date;
            userId: number;
            orderId: number;
            orderTotal: Prisma.Decimal;
            commissionRate: Prisma.Decimal;
            commissionAmount: Prisma.Decimal;
            isPaid: boolean;
            paidAt: Date | null;
        }>;
        markCommissionPaid: (_: any, { id }: {
            id: number;
        }, { prisma, user }: Context) => Promise<{
            id: number;
            createdAt: Date;
            userId: number;
            orderId: number;
            orderTotal: Prisma.Decimal;
            commissionRate: Prisma.Decimal;
            commissionAmount: Prisma.Decimal;
            isPaid: boolean;
            paidAt: Date | null;
        }>;
    };
    Commission: {
        user: (parent: any, _: any, { prisma }: Context) => Promise<{
            id: number;
            username: string;
            email: string;
            password: string;
            role: import(".prisma/client").$Enums.UserRole;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
        } | null>;
        order: (parent: any, _: any, { prisma }: Context) => Promise<{
            id: number;
            createdAt: Date;
            updatedAt: Date;
            total: Prisma.Decimal;
            notes: string | null;
            customerId: number | null;
            orderNumber: string;
            userId: number;
            status: import(".prisma/client").$Enums.OrderStatus;
            subtotal: Prisma.Decimal;
            discountId: number | null;
            discountAmount: Prisma.Decimal;
            taxAmount: Prisma.Decimal;
            completedAt: Date | null;
        } | null>;
    };
};
//# sourceMappingURL=commission.resolver.d.ts.map