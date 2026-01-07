"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.reportResolvers = void 0;
const client_1 = require("@prisma/client");
const auth_middleware_1 = require("../../middleware/auth.middleware");
exports.reportResolvers = {
    Query: {
        reportByPeriod: async (_, { input }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const { period, startDate, endDate } = input;
            let currentStart, currentEnd, previousStart, previousEnd;
            const now = new Date();
            switch (period) {
                case 'WEEKLY': {
                    const dayOfWeek = now.getDay();
                    const diffToMonday = dayOfWeek === 0 ? -6 : 1 - dayOfWeek;
                    currentStart = new Date(now);
                    currentStart.setDate(now.getDate() + diffToMonday);
                    currentStart.setHours(0, 0, 0, 0);
                    currentEnd = new Date(currentStart);
                    currentEnd.setDate(currentStart.getDate() + 6);
                    currentEnd.setHours(23, 59, 59, 999);
                    previousStart = new Date(currentStart);
                    previousStart.setDate(currentStart.getDate() - 7);
                    previousEnd = new Date(currentEnd);
                    previousEnd.setDate(currentEnd.getDate() - 7);
                    break;
                }
                case 'MONTHLY': {
                    currentStart = new Date(now.getFullYear(), now.getMonth(), 1);
                    currentEnd = new Date(now.getFullYear(), now.getMonth() + 1, 0, 23, 59, 59, 999);
                    previousStart = new Date(now.getFullYear(), now.getMonth() - 1, 1);
                    previousEnd = new Date(now.getFullYear(), now.getMonth(), 0, 23, 59, 59, 999);
                    break;
                }
                case 'YEARLY': {
                    currentStart = new Date(now.getFullYear(), 0, 1);
                    currentEnd = new Date(now.getFullYear(), 11, 31, 23, 59, 59, 999);
                    previousStart = new Date(now.getFullYear() - 1, 0, 1);
                    previousEnd = new Date(now.getFullYear() - 1, 11, 31, 23, 59, 59, 999);
                    break;
                }
                case 'CUSTOM': {
                    currentStart = new Date(startDate);
                    currentEnd = new Date(endDate);
                    previousStart = new Date(0);
                    previousEnd = new Date(0);
                    break;
                }
                default:
                    throw new Error('Invalid period type');
            }
            const getStats = async (start, end) => {
                const orders = await context.prisma.order.findMany({
                    where: {
                        createdAt: { gte: start, lte: end },
                        status: 'COMPLETED',
                    },
                    include: {
                        orderItems: {
                            include: { product: true },
                        },
                    },
                });
                let totalProductsSold = 0;
                let totalRevenue = new client_1.Prisma.Decimal(0);
                let totalCost = new client_1.Prisma.Decimal(0);
                for (const order of orders) {
                    totalRevenue = totalRevenue.add(order.total);
                    for (const item of order.orderItems) {
                        totalProductsSold += item.quantity;
                        const cost = item.product.costPrice || new client_1.Prisma.Decimal(0);
                        totalCost = totalCost.add(cost.mul(item.quantity));
                    }
                }
                const totalProfit = totalRevenue.sub(totalCost);
                return {
                    totalProductsSold,
                    totalOrders: orders.length,
                    totalRevenue,
                    totalProfit,
                };
            };
            const currentStats = await getStats(currentStart, currentEnd);
            let previousStats = null;
            let productsChange = null;
            let ordersChange = null;
            let revenueChange = null;
            let profitChange = null;
            if (period !== 'CUSTOM') {
                previousStats = await getStats(previousStart, previousEnd);
                productsChange = previousStats.totalProductsSold > 0
                    ? ((currentStats.totalProductsSold - previousStats.totalProductsSold) / previousStats.totalProductsSold) * 100
                    : 0;
                ordersChange = previousStats.totalOrders > 0
                    ? ((currentStats.totalOrders - previousStats.totalOrders) / previousStats.totalOrders) * 100
                    : 0;
                revenueChange = previousStats.totalRevenue.toNumber() > 0
                    ? ((currentStats.totalRevenue.toNumber() - previousStats.totalRevenue.toNumber()) / previousStats.totalRevenue.toNumber()) * 100
                    : 0;
                profitChange = previousStats.totalProfit.toNumber() > 0
                    ? ((currentStats.totalProfit.toNumber() - previousStats.totalProfit.toNumber()) / previousStats.totalProfit.toNumber()) * 100
                    : 0;
            }
            return {
                totalProductsSold: currentStats.totalProductsSold,
                totalOrders: currentStats.totalOrders,
                totalRevenue: currentStats.totalRevenue,
                totalProfit: currentStats.totalProfit,
                previousTotalProductsSold: previousStats?.totalProductsSold,
                previousTotalOrders: previousStats?.totalOrders,
                previousTotalRevenue: previousStats?.totalRevenue,
                previousTotalProfit: previousStats?.totalProfit,
                productsChange,
                ordersChange,
                revenueChange,
                profitChange,
                periodStart: currentStart,
                periodEnd: currentEnd,
            };
        },
        topProductsByQuantity: async (_, { input }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const { startDate, endDate } = input;
            const orders = await context.prisma.order.findMany({
                where: {
                    createdAt: { gte: new Date(startDate), lte: new Date(endDate) },
                    status: 'COMPLETED',
                },
                include: {
                    orderItems: {
                        include: { product: true },
                    },
                },
            });
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
                            name: item.product.name,
                            quantity: item.quantity,
                            revenue: new client_1.Prisma.Decimal(item.total),
                        });
                    }
                }
            }
            return Array.from(productSales.entries())
                .map(([id, data]) => ({
                productId: id,
                productName: data.name,
                quantitySold: data.quantity,
                revenue: data.revenue,
            }))
                .sort((a, b) => b.quantitySold - a.quantitySold);
        },
        topCustomers: async (_, { input }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const { startDate, endDate, limit = 10 } = input;
            const orders = await context.prisma.order.findMany({
                where: {
                    createdAt: { gte: new Date(startDate), lte: new Date(endDate) },
                    status: 'COMPLETED',
                    customerId: { not: null },
                },
                include: {
                    customer: true,
                },
            });
            const customerSales = new Map();
            for (const order of orders) {
                const customerId = order.customerId;
                const customerName = order.customer.name;
                const existing = customerSales.get(customerId);
                if (existing) {
                    existing.orders += 1;
                    existing.spent = existing.spent.add(order.total);
                }
                else {
                    customerSales.set(customerId, {
                        name: customerName,
                        orders: 1,
                        spent: new client_1.Prisma.Decimal(order.total),
                    });
                }
            }
            return Array.from(customerSales.entries())
                .sort((a, b) => b[1].spent.comparedTo(a[1].spent))
                .slice(0, limit)
                .map(([customerId, data]) => ({
                customerId: customerId,
                customerName: data.name,
                totalOrders: data.orders,
                totalSpent: data.spent,
            }));
        },
        revenueAndProfitTimeline: async (_, { input }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const { startDate, endDate, groupBy = 'DAY' } = input;
            const orders = await context.prisma.order.findMany({
                where: {
                    createdAt: { gte: new Date(startDate), lte: new Date(endDate) },
                    status: 'COMPLETED',
                },
                include: {
                    orderItems: {
                        include: { product: true },
                    },
                },
            });
            const timeline = new Map();
            for (const order of orders) {
                let dateKey;
                const orderDate = new Date(order.createdAt);
                switch (groupBy) {
                    case 'DAY':
                        dateKey = orderDate.toISOString().split('T')[0];
                        break;
                    case 'WEEK': {
                        const weekStart = new Date(orderDate);
                        const dayOfWeek = weekStart.getDay();
                        const diffToMonday = dayOfWeek === 0 ? -6 : 1 - dayOfWeek;
                        weekStart.setDate(weekStart.getDate() + diffToMonday);
                        dateKey = `Week of ${weekStart.toISOString().split('T')[0]}`;
                        break;
                    }
                    case 'MONTH':
                        dateKey = `${orderDate.getFullYear()}-${String(orderDate.getMonth() + 1).padStart(2, '0')}`;
                        break;
                    default:
                        dateKey = orderDate.toISOString().split('T')[0];
                }
                let orderCost = new client_1.Prisma.Decimal(0);
                for (const item of order.orderItems) {
                    const cost = item.product.costPrice || new client_1.Prisma.Decimal(0);
                    orderCost = orderCost.add(cost.mul(item.quantity));
                }
                const existing = timeline.get(dateKey);
                if (existing) {
                    existing.revenue = existing.revenue.add(order.total);
                    existing.cost = existing.cost.add(orderCost);
                    existing.orders += 1;
                }
                else {
                    timeline.set(dateKey, {
                        revenue: new client_1.Prisma.Decimal(order.total),
                        cost: orderCost,
                        orders: 1,
                    });
                }
            }
            return Array.from(timeline.entries())
                .sort((a, b) => a[0].localeCompare(b[0]))
                .map(([date, data]) => ({
                date,
                revenue: data.revenue,
                profit: data.revenue.sub(data.cost),
                orders: data.orders,
            }));
        },
        allStaffPerformance: async (_, { input }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const { startDate, endDate } = input;
            console.log('[Staff Performance] Query params:', { startDate, endDate });
            const orders = await context.prisma.order.findMany({
                where: {
                    createdAt: { gte: new Date(startDate), lte: new Date(endDate) },
                    status: 'COMPLETED',
                },
                include: {
                    createdBy: true,
                    orderItems: {
                        include: { product: true },
                    },
                },
            });
            console.log('[Staff Performance] Found orders:', orders.length);
            const staffSales = new Map();
            for (const order of orders) {
                const staffId = order.userId;
                const staff = order.createdBy;
                if (!staff) {
                    console.log('[Staff Performance] Skipping order - no staff info');
                    continue;
                }
                if (staff.role !== 'STAFF') {
                    console.log(`[Staff Performance] Skipping user ${staff.username} - role: ${staff.role}`);
                    continue;
                }
                let orderCost = new client_1.Prisma.Decimal(0);
                for (const item of order.orderItems) {
                    const cost = item.product.costPrice || new client_1.Prisma.Decimal(0);
                    orderCost = orderCost.add(cost.mul(item.quantity));
                }
                const existing = staffSales.get(staffId);
                if (existing) {
                    existing.orders += 1;
                    existing.revenue = existing.revenue.add(order.total);
                    existing.cost = existing.cost.add(orderCost);
                }
                else {
                    staffSales.set(staffId, {
                        username: staff.username,
                        email: staff.email,
                        orders: 1,
                        revenue: new client_1.Prisma.Decimal(order.total),
                        cost: orderCost,
                    });
                }
            }
            console.log('[Staff Performance] Staff count:', staffSales.size);
            const commissions = await context.prisma.commission.findMany({
                where: {
                    createdAt: { gte: new Date(startDate), lte: new Date(endDate) },
                    isPaid: true,
                },
            });
            const commissionByUser = new Map();
            for (const commission of commissions) {
                const existing = commissionByUser.get(commission.userId);
                if (existing) {
                    commissionByUser.set(commission.userId, existing.add(commission.commissionAmount));
                }
                else {
                    commissionByUser.set(commission.userId, new client_1.Prisma.Decimal(commission.commissionAmount));
                }
            }
            const result = Array.from(staffSales.entries())
                .sort((a, b) => b[1].revenue.comparedTo(a[1].revenue))
                .map(([staffId, data]) => ({
                staffId,
                username: data.username,
                email: data.email,
                totalOrders: data.orders,
                totalRevenue: data.revenue,
                totalProfit: data.revenue.sub(data.cost),
                totalCommission: commissionByUser.get(staffId) || new client_1.Prisma.Decimal(0),
            }));
            console.log('[Staff Performance] Returning staff:', result.length);
            return result;
        },
    },
};
//# sourceMappingURL=report.resolver.js.map