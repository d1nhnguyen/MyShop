import { Prisma } from '@prisma/client';
import { Context } from '../../types/context';
export declare const reportResolvers: {
    Query: {
        reportByPeriod: (_: any, { input }: any, context: Context) => Promise<{
            totalProductsSold: number;
            totalOrders: number;
            totalRevenue: Prisma.Decimal;
            totalProfit: Prisma.Decimal;
            previousTotalProductsSold: number | undefined;
            previousTotalOrders: number | undefined;
            previousTotalRevenue: Prisma.Decimal | undefined;
            previousTotalProfit: Prisma.Decimal | undefined;
            productsChange: number | null;
            ordersChange: number | null;
            revenueChange: number | null;
            profitChange: number | null;
            periodStart: Date;
            periodEnd: Date;
        }>;
        topProductsByQuantity: (_: any, { input }: any, context: Context) => Promise<{
            productId: number;
            productName: string;
            quantitySold: number;
            revenue: Prisma.Decimal;
        }[]>;
        topCustomers: (_: any, { input }: any, context: Context) => Promise<{
            customerId: number;
            customerName: string;
            totalOrders: number;
            totalSpent: Prisma.Decimal;
        }[]>;
        revenueAndProfitTimeline: (_: any, { input }: any, context: Context) => Promise<{
            date: string;
            revenue: Prisma.Decimal;
            profit: Prisma.Decimal;
            orders: number;
        }[]>;
        allStaffPerformance: (_: any, { input }: any, context: Context) => Promise<{
            staffId: number;
            username: string;
            email: string | null;
            totalOrders: number;
            totalRevenue: Prisma.Decimal;
            totalProfit: Prisma.Decimal;
            totalCommission: Prisma.Decimal;
        }[]>;
    };
};
//# sourceMappingURL=report.resolver.d.ts.map