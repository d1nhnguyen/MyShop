"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.dashboardResolvers = void 0;
const client_1 = require("@prisma/client");
const auth_middleware_1 = require("../../middleware/auth.middleware");
exports.dashboardResolvers = {
    Query: {
        dashboardStats: async (_, __, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            const [totalProducts, totalOrders, totalRevenueResult, totalCustomers, lowStockProducts, pendingOrders, todayRevenueResult, todayOrders,] = await Promise.all([
                context.prisma.product.count({ where: { isActive: true } }),
                context.prisma.order.count(),
                context.prisma.order.aggregate({
                    _sum: { total: true },
                    where: { status: { in: ['COMPLETED', 'PROCESSING'] } },
                }),
                context.prisma.customer.count(),
                context.prisma.product.count({
                    where: {
                        stock: { lte: 10 },
                        isActive: true,
                    },
                }),
                context.prisma.order.count({ where: { status: 'PENDING' } }),
                context.prisma.order.aggregate({
                    _sum: { total: true },
                    where: {
                        createdAt: { gte: today, lt: tomorrow },
                        status: { in: ['COMPLETED', 'PROCESSING'] },
                    },
                }),
                context.prisma.order.count({
                    where: {
                        createdAt: { gte: today, lt: tomorrow },
                    },
                }),
            ]);
            return {
                totalProducts,
                totalOrders,
                totalRevenue: totalRevenueResult._sum.total || new client_1.Prisma.Decimal(0),
                totalCustomers,
                lowStockProducts,
                pendingOrders,
                todayRevenue: todayRevenueResult._sum.total || new client_1.Prisma.Decimal(0),
                todayOrders,
            };
        },
        salesReport: async (_, { dateRange }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const fromDate = dateRange.from ? new Date(dateRange.from) : new Date(0);
            const toDate = dateRange.to ? new Date(dateRange.to) : new Date();
            const orders = await context.prisma.order.findMany({
                where: {
                    createdAt: {
                        gte: fromDate,
                        lte: toDate,
                    },
                    status: 'COMPLETED',
                },
                include: {
                    orderItems: {
                        include: {
                            product: {
                                include: {
                                    images: true,
                                },
                            },
                        },
                    },
                },
            });
            const totalRevenue = orders.reduce((sum, order) => sum.add(order.total), new client_1.Prisma.Decimal(0));
            const totalOrders = orders.length;
            const averageOrderValue = totalOrders > 0
                ? totalRevenue.div(totalOrders)
                : new client_1.Prisma.Decimal(0);
            const productSales = new Map();
            for (const order of orders) {
                for (const item of order.orderItems) {
                    const existing = productSales.get(item.productId);
                    if (existing) {
                        existing.quantity += item.quantity;
                        existing.revenue = existing.revenue.add(item.total);
                    }
                    else {
                        productSales.set(item.productId, {
                            quantity: item.quantity,
                            revenue: new client_1.Prisma.Decimal(item.total),
                            product: item.product,
                        });
                    }
                }
            }
            const topProducts = Array.from(productSales.values())
                .sort((a, b) => b.revenue.comparedTo(a.revenue))
                .slice(0, 10)
                .map((item) => ({
                product: item.product,
                quantity: item.quantity,
                revenue: item.revenue,
            }));
            const revenueByDateMap = new Map();
            const daysDiff = Math.ceil((toDate.getTime() - fromDate.getTime()) / (1000 * 60 * 60 * 24));
            const groupByMonth = daysDiff > 31;
            for (const order of orders) {
                let dateKey;
                const orderDate = new Date(order.createdAt);
                if (groupByMonth) {
                    dateKey = `${orderDate.getFullYear()}-${String(orderDate.getMonth() + 1).padStart(2, '0')}`;
                }
                else {
                    dateKey = orderDate.toISOString().split('T')[0];
                }
                const existing = revenueByDateMap.get(dateKey);
                if (existing) {
                    existing.revenue = existing.revenue.add(order.total);
                    existing.orders += 1;
                }
                else {
                    revenueByDateMap.set(dateKey, {
                        revenue: new client_1.Prisma.Decimal(order.total),
                        orders: 1,
                    });
                }
            }
            const revenueByDate = Array.from(revenueByDateMap.entries())
                .sort((a, b) => a[0].localeCompare(b[0]))
                .map(([date, data]) => ({
                date,
                revenue: data.revenue,
                orders: data.orders,
            }));
            return {
                totalRevenue,
                totalOrders,
                averageOrderValue,
                topProducts,
                revenueByDate,
            };
        },
    },
};
//# sourceMappingURL=dashboard.resolver.js.map