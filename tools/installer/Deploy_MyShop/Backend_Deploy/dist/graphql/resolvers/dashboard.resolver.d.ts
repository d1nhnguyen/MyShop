import { Prisma } from '@prisma/client';
import { Context } from '../../types/context';
export declare const dashboardResolvers: {
    Query: {
        dashboardStats: (_: any, __: any, context: Context) => Promise<{
            totalProducts: number;
            totalOrders: number;
            totalRevenue: Prisma.Decimal;
            totalCustomers: number;
            lowStockProducts: number;
            pendingOrders: number;
            todayRevenue: Prisma.Decimal;
            todayOrders: number;
        }>;
        salesReport: (_: any, { dateRange }: any, context: Context) => Promise<{
            totalRevenue: Prisma.Decimal;
            totalOrders: number;
            averageOrderValue: Prisma.Decimal;
            topProducts: {
                product: any;
                quantity: number;
                revenue: Prisma.Decimal;
            }[];
            revenueByDate: {
                date: string;
                revenue: Prisma.Decimal;
                orders: number;
            }[];
        }>;
    };
};
//# sourceMappingURL=dashboard.resolver.d.ts.map