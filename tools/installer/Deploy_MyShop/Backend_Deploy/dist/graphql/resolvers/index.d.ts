import { GraphQLScalarType } from 'graphql';
export declare const resolvers: {
    DateTime: GraphQLScalarType<Date, Date>;
    Decimal: GraphQLScalarType<number | null, number>;
    Query: {
        validateLicense: (_: any, { licenseKey }: {
            licenseKey: string;
        }, { prisma }: import("../../types/context").Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            licenseKey: string;
            deviceId: string | null;
            activatedAt: Date;
            expiresAt: Date;
        }>;
        checkTrialStatus: (_: any, __: any, { prisma }: import("../../types/context").Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            licenseKey: string;
            deviceId: string | null;
            activatedAt: Date;
            expiresAt: Date;
        } | null>;
        getSalesTargets: (_: any, { filter, pagination, }: {
            filter?: import("./salesTarget.resolver").SalesTargetFilterInput;
            pagination?: import("./salesTarget.resolver").PaginationInput;
        }, { prisma, user }: import("../../types/context").Context) => Promise<{
            items: {
                id: number;
                createdAt: Date;
                updatedAt: Date;
                userId: number;
                commissionRate: import("@prisma/client/runtime/library").Decimal;
                month: number;
                year: number;
                targetAmount: import("@prisma/client/runtime/library").Decimal;
                achievedAmount: import("@prisma/client/runtime/library").Decimal;
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
        }, { prisma, user }: import("../../types/context").Context) => Promise<{
            id: number;
            createdAt: Date;
            updatedAt: Date;
            userId: number;
            commissionRate: import("@prisma/client/runtime/library").Decimal;
            month: number;
            year: number;
            targetAmount: import("@prisma/client/runtime/library").Decimal;
            achievedAmount: import("@prisma/client/runtime/library").Decimal;
        } | null>;
        getUserTargets: (_: any, { userId }: {
            userId: number;
        }, { prisma, user }: import("../../types/context").Context) => Promise<{
            id: number;
            createdAt: Date;
            updatedAt: Date;
            userId: number;
            commissionRate: import("@prisma/client/runtime/library").Decimal;
            month: number;
            year: number;
            targetAmount: import("@prisma/client/runtime/library").Decimal;
            achievedAmount: import("@prisma/client/runtime/library").Decimal;
        }[]>;
        getCommissions: (_: any, { filter, pagination, }: {
            filter?: import("./commission.resolver").CommissionFilterInput;
            pagination?: import("./commission.resolver").PaginationInput;
        }, { prisma, user }: import("../../types/context").Context) => Promise<{
            items: {
                id: number;
                createdAt: Date;
                userId: number;
                orderId: number;
                orderTotal: import("@prisma/client/runtime/library").Decimal;
                commissionRate: import("@prisma/client/runtime/library").Decimal;
                commissionAmount: import("@prisma/client/runtime/library").Decimal;
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
        }, { prisma, user }: import("../../types/context").Context) => Promise<{
            id: number;
            createdAt: Date;
            userId: number;
            orderId: number;
            orderTotal: import("@prisma/client/runtime/library").Decimal;
            commissionRate: import("@prisma/client/runtime/library").Decimal;
            commissionAmount: import("@prisma/client/runtime/library").Decimal;
            isPaid: boolean;
            paidAt: Date | null;
        }[]>;
        getCommissionStats: (_: any, { userId, dateRange, }: {
            userId?: number;
            dateRange?: {
                from: Date;
                to: Date;
            };
        }, { prisma, user }: import("../../types/context").Context) => Promise<{
            totalCommission: number;
            paidCommission: number;
            unpaidCommission: number;
            totalOrders: number;
        }>;
        reportByPeriod: (_: any, { input }: any, context: import("../../types/context").Context) => Promise<{
            totalProductsSold: number;
            totalOrders: number;
            totalRevenue: import("@prisma/client/runtime/library").Decimal;
            totalProfit: import("@prisma/client/runtime/library").Decimal;
            previousTotalProductsSold: number | undefined;
            previousTotalOrders: number | undefined;
            previousTotalRevenue: import("@prisma/client/runtime/library").Decimal | undefined;
            previousTotalProfit: import("@prisma/client/runtime/library").Decimal | undefined;
            productsChange: number | null;
            ordersChange: number | null;
            revenueChange: number | null;
            profitChange: number | null;
            periodStart: Date;
            periodEnd: Date;
        }>;
        topProductsByQuantity: (_: any, { input }: any, context: import("../../types/context").Context) => Promise<{
            productId: number;
            productName: string;
            quantitySold: number;
            revenue: import("@prisma/client/runtime/library").Decimal;
        }[]>;
        topCustomers: (_: any, { input }: any, context: import("../../types/context").Context) => Promise<{
            customerId: number;
            customerName: string;
            totalOrders: number;
            totalSpent: import("@prisma/client/runtime/library").Decimal;
        }[]>;
        revenueAndProfitTimeline: (_: any, { input }: any, context: import("../../types/context").Context) => Promise<{
            date: string;
            revenue: import("@prisma/client/runtime/library").Decimal;
            profit: import("@prisma/client/runtime/library").Decimal;
            orders: number;
        }[]>;
        allStaffPerformance: (_: any, { input }: any, context: import("../../types/context").Context) => Promise<{
            staffId: number;
            username: string;
            email: string | null;
            totalOrders: number;
            totalRevenue: import("@prisma/client/runtime/library").Decimal;
            totalProfit: import("@prisma/client/runtime/library").Decimal;
            totalCommission: import("@prisma/client/runtime/library").Decimal;
        }[]>;
        dashboardStats: (_: any, __: any, context: import("../../types/context").Context) => Promise<{
            totalProducts: number;
            totalOrders: number;
            totalRevenue: import("@prisma/client/runtime/library").Decimal;
            totalCustomers: number;
            lowStockProducts: number;
            pendingOrders: number;
            todayRevenue: import("@prisma/client/runtime/library").Decimal;
            todayOrders: number;
        }>;
        salesReport: (_: any, { dateRange }: any, context: import("../../types/context").Context) => Promise<{
            totalRevenue: import("@prisma/client/runtime/library").Decimal;
            totalOrders: number;
            averageOrderValue: import("@prisma/client/runtime/library").Decimal;
            topProducts: {
                product: any;
                quantity: number;
                revenue: import("@prisma/client/runtime/library").Decimal;
            }[];
            revenueByDate: {
                date: string;
                revenue: import("@prisma/client/runtime/library").Decimal;
                orders: number;
            }[];
        }>;
        orders: (_: any, { pagination, sort, filter }: any, context: import("../../types/context").Context) => Promise<{
            orders: ({
                orderItems: ({
                    product: {
                        id: number;
                        isActive: boolean;
                        createdAt: Date;
                        updatedAt: Date;
                        name: string;
                        description: string | null;
                        categoryId: number;
                        sku: string;
                        barcode: string | null;
                        price: import("@prisma/client/runtime/library").Decimal;
                        costPrice: import("@prisma/client/runtime/library").Decimal | null;
                        stock: number;
                        minStock: number;
                        popularity: number;
                    };
                } & {
                    id: number;
                    total: import("@prisma/client/runtime/library").Decimal;
                    quantity: number;
                    productId: number;
                    subtotal: import("@prisma/client/runtime/library").Decimal;
                    discountAmount: import("@prisma/client/runtime/library").Decimal;
                    orderId: number;
                    unitPrice: import("@prisma/client/runtime/library").Decimal;
                })[];
                customer: {
                    id: number;
                    email: string | null;
                    createdAt: Date;
                    updatedAt: Date;
                    name: string;
                    phone: string;
                    address: string | null;
                    isMember: boolean;
                    memberSince: Date | null;
                    totalSpent: import("@prisma/client/runtime/library").Decimal;
                    notes: string | null;
                } | null;
                discount: {
                    id: number;
                    isActive: boolean;
                    createdAt: Date;
                    updatedAt: Date;
                    name: string;
                    code: string;
                    description: string | null;
                    type: import(".prisma/client").$Enums.DiscountType;
                    value: import("@prisma/client/runtime/library").Decimal;
                    minPurchase: import("@prisma/client/runtime/library").Decimal | null;
                    maxDiscount: import("@prisma/client/runtime/library").Decimal | null;
                    buyQuantity: number | null;
                    getQuantity: number | null;
                    startDate: Date | null;
                    endDate: Date | null;
                    usageLimit: number | null;
                    usageCount: number;
                    applicableToAll: boolean;
                    memberOnly: boolean;
                    wholesaleMinQty: number | null;
                } | null;
                createdBy: {
                    id: number;
                    username: string;
                    email: string;
                    password: string;
                    role: import(".prisma/client").$Enums.UserRole;
                    isActive: boolean;
                    createdAt: Date;
                    updatedAt: Date;
                };
            } & {
                id: number;
                createdAt: Date;
                updatedAt: Date;
                total: import("@prisma/client/runtime/library").Decimal;
                notes: string | null;
                customerId: number | null;
                orderNumber: string;
                userId: number;
                status: import(".prisma/client").$Enums.OrderStatus;
                subtotal: import("@prisma/client/runtime/library").Decimal;
                discountId: number | null;
                discountAmount: import("@prisma/client/runtime/library").Decimal;
                taxAmount: import("@prisma/client/runtime/library").Decimal;
                completedAt: Date | null;
            })[];
            total: number;
            page: any;
            pageSize: number;
            totalPages: number;
        }>;
        order: (_: any, { id }: any, context: import("../../types/context").Context) => Promise<{
            orderItems: ({
                product: {
                    [x: string]: {
                        id: number;
                        createdAt: Date;
                        displayOrder: number;
                        isMain: boolean;
                        productId: number;
                        imageUrl: string;
                    }[] | {
                        id: number;
                        total: import("@prisma/client/runtime/library").Decimal;
                        quantity: number;
                        productId: number;
                        subtotal: import("@prisma/client/runtime/library").Decimal;
                        discountAmount: import("@prisma/client/runtime/library").Decimal;
                        orderId: number;
                        unitPrice: import("@prisma/client/runtime/library").Decimal;
                    }[] | ({
                        id: number;
                        createdAt: Date;
                        displayOrder: number;
                        isMain: boolean;
                        productId: number;
                        imageUrl: string;
                    } | {
                        id: number;
                        createdAt: Date;
                        displayOrder: number;
                        isMain: boolean;
                        productId: number;
                        imageUrl: string;
                    })[] | ({
                        id: number;
                        total: import("@prisma/client/runtime/library").Decimal;
                        quantity: number;
                        productId: number;
                        subtotal: import("@prisma/client/runtime/library").Decimal;
                        discountAmount: import("@prisma/client/runtime/library").Decimal;
                        orderId: number;
                        unitPrice: import("@prisma/client/runtime/library").Decimal;
                    } | {
                        id: number;
                        total: import("@prisma/client/runtime/library").Decimal;
                        quantity: number;
                        productId: number;
                        subtotal: import("@prisma/client/runtime/library").Decimal;
                        discountAmount: import("@prisma/client/runtime/library").Decimal;
                        orderId: number;
                        unitPrice: import("@prisma/client/runtime/library").Decimal;
                    })[];
                    [x: number]: never;
                    [x: symbol]: never;
                } & {
                    id: number;
                    isActive: boolean;
                    createdAt: Date;
                    updatedAt: Date;
                    name: string;
                    description: string | null;
                    categoryId: number;
                    sku: string;
                    barcode: string | null;
                    price: import("@prisma/client/runtime/library").Decimal;
                    costPrice: import("@prisma/client/runtime/library").Decimal | null;
                    stock: number;
                    minStock: number;
                    popularity: number;
                };
            } & {
                id: number;
                total: import("@prisma/client/runtime/library").Decimal;
                quantity: number;
                productId: number;
                subtotal: import("@prisma/client/runtime/library").Decimal;
                discountAmount: import("@prisma/client/runtime/library").Decimal;
                orderId: number;
                unitPrice: import("@prisma/client/runtime/library").Decimal;
            })[];
            customer: {
                id: number;
                email: string | null;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                phone: string;
                address: string | null;
                isMember: boolean;
                memberSince: Date | null;
                totalSpent: import("@prisma/client/runtime/library").Decimal;
                notes: string | null;
            } | null;
            discount: {
                id: number;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                code: string;
                description: string | null;
                type: import(".prisma/client").$Enums.DiscountType;
                value: import("@prisma/client/runtime/library").Decimal;
                minPurchase: import("@prisma/client/runtime/library").Decimal | null;
                maxDiscount: import("@prisma/client/runtime/library").Decimal | null;
                buyQuantity: number | null;
                getQuantity: number | null;
                startDate: Date | null;
                endDate: Date | null;
                usageLimit: number | null;
                usageCount: number;
                applicableToAll: boolean;
                memberOnly: boolean;
                wholesaleMinQty: number | null;
            } | null;
            createdBy: {
                id: number;
                username: string;
                email: string;
                password: string;
                role: import(".prisma/client").$Enums.UserRole;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
            };
        } & {
            id: number;
            createdAt: Date;
            updatedAt: Date;
            total: import("@prisma/client/runtime/library").Decimal;
            notes: string | null;
            customerId: number | null;
            orderNumber: string;
            userId: number;
            status: import(".prisma/client").$Enums.OrderStatus;
            subtotal: import("@prisma/client/runtime/library").Decimal;
            discountId: number | null;
            discountAmount: import("@prisma/client/runtime/library").Decimal;
            taxAmount: import("@prisma/client/runtime/library").Decimal;
            completedAt: Date | null;
        }>;
        orderByNumber: (_: any, { orderNumber }: any, context: import("../../types/context").Context) => Promise<{
            orderItems: ({
                product: {
                    id: number;
                    isActive: boolean;
                    createdAt: Date;
                    updatedAt: Date;
                    name: string;
                    description: string | null;
                    categoryId: number;
                    sku: string;
                    barcode: string | null;
                    price: import("@prisma/client/runtime/library").Decimal;
                    costPrice: import("@prisma/client/runtime/library").Decimal | null;
                    stock: number;
                    minStock: number;
                    popularity: number;
                };
            } & {
                id: number;
                total: import("@prisma/client/runtime/library").Decimal;
                quantity: number;
                productId: number;
                subtotal: import("@prisma/client/runtime/library").Decimal;
                discountAmount: import("@prisma/client/runtime/library").Decimal;
                orderId: number;
                unitPrice: import("@prisma/client/runtime/library").Decimal;
            })[];
            customer: {
                id: number;
                email: string | null;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                phone: string;
                address: string | null;
                isMember: boolean;
                memberSince: Date | null;
                totalSpent: import("@prisma/client/runtime/library").Decimal;
                notes: string | null;
            } | null;
            discount: {
                id: number;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                code: string;
                description: string | null;
                type: import(".prisma/client").$Enums.DiscountType;
                value: import("@prisma/client/runtime/library").Decimal;
                minPurchase: import("@prisma/client/runtime/library").Decimal | null;
                maxDiscount: import("@prisma/client/runtime/library").Decimal | null;
                buyQuantity: number | null;
                getQuantity: number | null;
                startDate: Date | null;
                endDate: Date | null;
                usageLimit: number | null;
                usageCount: number;
                applicableToAll: boolean;
                memberOnly: boolean;
                wholesaleMinQty: number | null;
            } | null;
            createdBy: {
                id: number;
                username: string;
                email: string;
                password: string;
                role: import(".prisma/client").$Enums.UserRole;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
            };
        } & {
            id: number;
            createdAt: Date;
            updatedAt: Date;
            total: import("@prisma/client/runtime/library").Decimal;
            notes: string | null;
            customerId: number | null;
            orderNumber: string;
            userId: number;
            status: import(".prisma/client").$Enums.OrderStatus;
            subtotal: import("@prisma/client/runtime/library").Decimal;
            discountId: number | null;
            discountAmount: import("@prisma/client/runtime/library").Decimal;
            taxAmount: import("@prisma/client/runtime/library").Decimal;
            completedAt: Date | null;
        }>;
        discounts: (_: any, { pagination, sort }: any, context: import("../../types/context").Context) => Promise<{
            discounts: {
                id: number;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                code: string;
                description: string | null;
                type: import(".prisma/client").$Enums.DiscountType;
                value: import("@prisma/client/runtime/library").Decimal;
                minPurchase: import("@prisma/client/runtime/library").Decimal | null;
                maxDiscount: import("@prisma/client/runtime/library").Decimal | null;
                buyQuantity: number | null;
                getQuantity: number | null;
                startDate: Date | null;
                endDate: Date | null;
                usageLimit: number | null;
                usageCount: number;
                applicableToAll: boolean;
                memberOnly: boolean;
                wholesaleMinQty: number | null;
            }[];
            total: number;
            page: any;
            pageSize: number;
            totalPages: number;
        }>;
        discount: (_: any, { id }: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            code: string;
            description: string | null;
            type: import(".prisma/client").$Enums.DiscountType;
            value: import("@prisma/client/runtime/library").Decimal;
            minPurchase: import("@prisma/client/runtime/library").Decimal | null;
            maxDiscount: import("@prisma/client/runtime/library").Decimal | null;
            buyQuantity: number | null;
            getQuantity: number | null;
            startDate: Date | null;
            endDate: Date | null;
            usageLimit: number | null;
            usageCount: number;
            applicableToAll: boolean;
            memberOnly: boolean;
            wholesaleMinQty: number | null;
        }>;
        discountByCode: (_: any, { code }: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            code: string;
            description: string | null;
            type: import(".prisma/client").$Enums.DiscountType;
            value: import("@prisma/client/runtime/library").Decimal;
            minPurchase: import("@prisma/client/runtime/library").Decimal | null;
            maxDiscount: import("@prisma/client/runtime/library").Decimal | null;
            buyQuantity: number | null;
            getQuantity: number | null;
            startDate: Date | null;
            endDate: Date | null;
            usageLimit: number | null;
            usageCount: number;
            applicableToAll: boolean;
            memberOnly: boolean;
            wholesaleMinQty: number | null;
        }>;
        activeDiscounts: (_: any, __: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            code: string;
            description: string | null;
            type: import(".prisma/client").$Enums.DiscountType;
            value: import("@prisma/client/runtime/library").Decimal;
            minPurchase: import("@prisma/client/runtime/library").Decimal | null;
            maxDiscount: import("@prisma/client/runtime/library").Decimal | null;
            buyQuantity: number | null;
            getQuantity: number | null;
            startDate: Date | null;
            endDate: Date | null;
            usageLimit: number | null;
            usageCount: number;
            applicableToAll: boolean;
            memberOnly: boolean;
            wholesaleMinQty: number | null;
        }[]>;
        customers: (_: any, { pagination, sort, filter }: any, context: import("../../types/context").Context) => Promise<{
            customers: ({
                _count: {
                    orders: number;
                };
            } & {
                id: number;
                email: string | null;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                phone: string;
                address: string | null;
                isMember: boolean;
                memberSince: Date | null;
                totalSpent: import("@prisma/client/runtime/library").Decimal;
                notes: string | null;
            })[];
            total: number;
            page: any;
            pageSize: number;
            totalPages: number;
        }>;
        customer: (_: any, { id }: any, context: import("../../types/context").Context) => Promise<{
            _count: {
                orders: number;
            };
            orders: {
                id: number;
                createdAt: Date;
                updatedAt: Date;
                total: import("@prisma/client/runtime/library").Decimal;
                notes: string | null;
                customerId: number | null;
                orderNumber: string;
                userId: number;
                status: import(".prisma/client").$Enums.OrderStatus;
                subtotal: import("@prisma/client/runtime/library").Decimal;
                discountId: number | null;
                discountAmount: import("@prisma/client/runtime/library").Decimal;
                taxAmount: import("@prisma/client/runtime/library").Decimal;
                completedAt: Date | null;
            }[];
        } & {
            id: number;
            email: string | null;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            phone: string;
            address: string | null;
            isMember: boolean;
            memberSince: Date | null;
            totalSpent: import("@prisma/client/runtime/library").Decimal;
            notes: string | null;
        }>;
        products: (_: any, { pagination, sort, filter }: any, context: import("../../types/context").Context) => Promise<{
            products: ({
                category: {
                    id: number;
                    isActive: boolean;
                    createdAt: Date;
                    updatedAt: Date;
                    name: string;
                    description: string | null;
                };
                images: {
                    id: number;
                    createdAt: Date;
                    displayOrder: number;
                    isMain: boolean;
                    productId: number;
                    imageUrl: string;
                }[];
            } & {
                id: number;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                description: string | null;
                categoryId: number;
                sku: string;
                barcode: string | null;
                price: import("@prisma/client/runtime/library").Decimal;
                costPrice: import("@prisma/client/runtime/library").Decimal | null;
                stock: number;
                minStock: number;
                popularity: number;
            })[];
            total: number;
            page: any;
            pageSize: number;
            totalPages: number;
        }>;
        product: (_: any, { id }: any, context: import("../../types/context").Context) => Promise<{
            category: {
                id: number;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                description: string | null;
            };
            images: {
                id: number;
                createdAt: Date;
                displayOrder: number;
                isMain: boolean;
                productId: number;
                imageUrl: string;
            }[];
        } & {
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            description: string | null;
            categoryId: number;
            sku: string;
            barcode: string | null;
            price: import("@prisma/client/runtime/library").Decimal;
            costPrice: import("@prisma/client/runtime/library").Decimal | null;
            stock: number;
            minStock: number;
            popularity: number;
        }>;
        productBySku: (_: any, { sku }: any, context: import("../../types/context").Context) => Promise<{
            category: {
                id: number;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                description: string | null;
            };
            images: {
                id: number;
                createdAt: Date;
                displayOrder: number;
                isMain: boolean;
                productId: number;
                imageUrl: string;
            }[];
        } & {
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            description: string | null;
            categoryId: number;
            sku: string;
            barcode: string | null;
            price: import("@prisma/client/runtime/library").Decimal;
            costPrice: import("@prisma/client/runtime/library").Decimal | null;
            stock: number;
            minStock: number;
            popularity: number;
        }>;
        lowStockProducts: (_: any, { threshold }: any, context: import("../../types/context").Context) => Promise<({
            category: {
                id: number;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                description: string | null;
            };
            images: {
                id: number;
                createdAt: Date;
                displayOrder: number;
                isMain: boolean;
                productId: number;
                imageUrl: string;
            }[];
        } & {
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            description: string | null;
            categoryId: number;
            sku: string;
            barcode: string | null;
            price: import("@prisma/client/runtime/library").Decimal;
            costPrice: import("@prisma/client/runtime/library").Decimal | null;
            stock: number;
            minStock: number;
            popularity: number;
        })[]>;
        categories: (_: any, { pagination, sort }: any, context: import("../../types/context").Context) => Promise<{
            categories: ({
                _count: {
                    products: number;
                };
            } & {
                id: number;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                description: string | null;
            })[];
            total: number;
            page: any;
            pageSize: number;
            totalPages: number;
        }>;
        category: (_: any, { id }: any, context: import("../../types/context").Context) => Promise<{
            _count: {
                products: number;
            };
            products: {
                id: number;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                description: string | null;
                categoryId: number;
                sku: string;
                barcode: string | null;
                price: import("@prisma/client/runtime/library").Decimal;
                costPrice: import("@prisma/client/runtime/library").Decimal | null;
                stock: number;
                minStock: number;
                popularity: number;
            }[];
        } & {
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            description: string | null;
        }>;
        activeCategories: (_: any, __: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            description: string | null;
        }[]>;
        users: (_: any, { pagination, sort }: any, context: import("../../types/context").Context) => Promise<{
            users: {
                id: number;
                username: string;
                email: string;
                password: string;
                role: import(".prisma/client").$Enums.UserRole;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
            }[];
            total: number;
            page: any;
            pageSize: number;
            totalPages: number;
        }>;
        user: (_: any, { id }: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            username: string;
            email: string;
            password: string;
            role: import(".prisma/client").$Enums.UserRole;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
        }>;
        userByUsername: (_: any, { username }: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            username: string;
            email: string;
            password: string;
            role: import(".prisma/client").$Enums.UserRole;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
        } | null>;
        me: (_: any, __: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            username: string;
            email: string;
            password: string;
            role: import(".prisma/client").$Enums.UserRole;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
        }>;
    };
    Mutation: {
        activateTrial: (_: any, _input: any, { prisma, user }: import("../../types/context").Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            licenseKey: string;
            deviceId: string | null;
            activatedAt: Date;
            expiresAt: Date;
        }>;
        activateLicense: (_: any, { input }: {
            input: import("./appLicense.resolver").ActivateLicenseInput;
        }, { prisma, user }: import("../../types/context").Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            licenseKey: string;
            deviceId: string | null;
            activatedAt: Date;
            expiresAt: Date;
        }>;
        deactivateLicense: (_: any, { licenseKey }: {
            licenseKey: string;
        }, { prisma, user }: import("../../types/context").Context) => Promise<boolean>;
        createSalesTarget: (_: any, { input }: {
            input: import("./salesTarget.resolver").CreateSalesTargetInput;
        }, { prisma, user }: import("../../types/context").Context) => Promise<{
            id: number;
            createdAt: Date;
            updatedAt: Date;
            userId: number;
            commissionRate: import("@prisma/client/runtime/library").Decimal;
            month: number;
            year: number;
            targetAmount: import("@prisma/client/runtime/library").Decimal;
            achievedAmount: import("@prisma/client/runtime/library").Decimal;
        }>;
        updateSalesTarget: (_: any, { id, input }: {
            id: number;
            input: import("./salesTarget.resolver").UpdateSalesTargetInput;
        }, { prisma, user }: import("../../types/context").Context) => Promise<{
            id: number;
            createdAt: Date;
            updatedAt: Date;
            userId: number;
            commissionRate: import("@prisma/client/runtime/library").Decimal;
            month: number;
            year: number;
            targetAmount: import("@prisma/client/runtime/library").Decimal;
            achievedAmount: import("@prisma/client/runtime/library").Decimal;
        }>;
        deleteSalesTarget: (_: any, { id }: {
            id: number;
        }, { prisma, user }: import("../../types/context").Context) => Promise<boolean>;
        calculateCommission: (_: any, { orderId }: {
            orderId: number;
        }, { prisma, user }: import("../../types/context").Context) => Promise<{
            id: number;
            createdAt: Date;
            userId: number;
            orderId: number;
            orderTotal: import("@prisma/client/runtime/library").Decimal;
            commissionRate: import("@prisma/client/runtime/library").Decimal;
            commissionAmount: import("@prisma/client/runtime/library").Decimal;
            isPaid: boolean;
            paidAt: Date | null;
        }>;
        markCommissionPaid: (_: any, { id }: {
            id: number;
        }, { prisma, user }: import("../../types/context").Context) => Promise<{
            id: number;
            createdAt: Date;
            userId: number;
            orderId: number;
            orderTotal: import("@prisma/client/runtime/library").Decimal;
            commissionRate: import("@prisma/client/runtime/library").Decimal;
            commissionAmount: import("@prisma/client/runtime/library").Decimal;
            isPaid: boolean;
            paidAt: Date | null;
        }>;
        createOrder: (_: any, { input }: any, context: import("../../types/context").Context) => Promise<{
            orderItems: ({
                product: {
                    id: number;
                    isActive: boolean;
                    createdAt: Date;
                    updatedAt: Date;
                    name: string;
                    description: string | null;
                    categoryId: number;
                    sku: string;
                    barcode: string | null;
                    price: import("@prisma/client/runtime/library").Decimal;
                    costPrice: import("@prisma/client/runtime/library").Decimal | null;
                    stock: number;
                    minStock: number;
                    popularity: number;
                };
            } & {
                id: number;
                total: import("@prisma/client/runtime/library").Decimal;
                quantity: number;
                productId: number;
                subtotal: import("@prisma/client/runtime/library").Decimal;
                discountAmount: import("@prisma/client/runtime/library").Decimal;
                orderId: number;
                unitPrice: import("@prisma/client/runtime/library").Decimal;
            })[];
            customer: {
                id: number;
                email: string | null;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                phone: string;
                address: string | null;
                isMember: boolean;
                memberSince: Date | null;
                totalSpent: import("@prisma/client/runtime/library").Decimal;
                notes: string | null;
            } | null;
            discount: {
                id: number;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                code: string;
                description: string | null;
                type: import(".prisma/client").$Enums.DiscountType;
                value: import("@prisma/client/runtime/library").Decimal;
                minPurchase: import("@prisma/client/runtime/library").Decimal | null;
                maxDiscount: import("@prisma/client/runtime/library").Decimal | null;
                buyQuantity: number | null;
                getQuantity: number | null;
                startDate: Date | null;
                endDate: Date | null;
                usageLimit: number | null;
                usageCount: number;
                applicableToAll: boolean;
                memberOnly: boolean;
                wholesaleMinQty: number | null;
            } | null;
            createdBy: {
                id: number;
                username: string;
                email: string;
                password: string;
                role: import(".prisma/client").$Enums.UserRole;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
            };
        } & {
            id: number;
            createdAt: Date;
            updatedAt: Date;
            total: import("@prisma/client/runtime/library").Decimal;
            notes: string | null;
            customerId: number | null;
            orderNumber: string;
            userId: number;
            status: import(".prisma/client").$Enums.OrderStatus;
            subtotal: import("@prisma/client/runtime/library").Decimal;
            discountId: number | null;
            discountAmount: import("@prisma/client/runtime/library").Decimal;
            taxAmount: import("@prisma/client/runtime/library").Decimal;
            completedAt: Date | null;
        }>;
        updateOrder: (_: any, { id, input }: any, context: import("../../types/context").Context) => Promise<{
            orderItems: ({
                product: {
                    id: number;
                    isActive: boolean;
                    createdAt: Date;
                    updatedAt: Date;
                    name: string;
                    description: string | null;
                    categoryId: number;
                    sku: string;
                    barcode: string | null;
                    price: import("@prisma/client/runtime/library").Decimal;
                    costPrice: import("@prisma/client/runtime/library").Decimal | null;
                    stock: number;
                    minStock: number;
                    popularity: number;
                };
            } & {
                id: number;
                total: import("@prisma/client/runtime/library").Decimal;
                quantity: number;
                productId: number;
                subtotal: import("@prisma/client/runtime/library").Decimal;
                discountAmount: import("@prisma/client/runtime/library").Decimal;
                orderId: number;
                unitPrice: import("@prisma/client/runtime/library").Decimal;
            })[];
            customer: {
                id: number;
                email: string | null;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                phone: string;
                address: string | null;
                isMember: boolean;
                memberSince: Date | null;
                totalSpent: import("@prisma/client/runtime/library").Decimal;
                notes: string | null;
            } | null;
            discount: {
                id: number;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                code: string;
                description: string | null;
                type: import(".prisma/client").$Enums.DiscountType;
                value: import("@prisma/client/runtime/library").Decimal;
                minPurchase: import("@prisma/client/runtime/library").Decimal | null;
                maxDiscount: import("@prisma/client/runtime/library").Decimal | null;
                buyQuantity: number | null;
                getQuantity: number | null;
                startDate: Date | null;
                endDate: Date | null;
                usageLimit: number | null;
                usageCount: number;
                applicableToAll: boolean;
                memberOnly: boolean;
                wholesaleMinQty: number | null;
            } | null;
            createdBy: {
                id: number;
                username: string;
                email: string;
                password: string;
                role: import(".prisma/client").$Enums.UserRole;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
            };
        } & {
            id: number;
            createdAt: Date;
            updatedAt: Date;
            total: import("@prisma/client/runtime/library").Decimal;
            notes: string | null;
            customerId: number | null;
            orderNumber: string;
            userId: number;
            status: import(".prisma/client").$Enums.OrderStatus;
            subtotal: import("@prisma/client/runtime/library").Decimal;
            discountId: number | null;
            discountAmount: import("@prisma/client/runtime/library").Decimal;
            taxAmount: import("@prisma/client/runtime/library").Decimal;
            completedAt: Date | null;
        }>;
        cancelOrder: (_: any, { id }: any, context: import("../../types/context").Context) => Promise<{
            orderItems: ({
                product: {
                    id: number;
                    isActive: boolean;
                    createdAt: Date;
                    updatedAt: Date;
                    name: string;
                    description: string | null;
                    categoryId: number;
                    sku: string;
                    barcode: string | null;
                    price: import("@prisma/client/runtime/library").Decimal;
                    costPrice: import("@prisma/client/runtime/library").Decimal | null;
                    stock: number;
                    minStock: number;
                    popularity: number;
                };
            } & {
                id: number;
                total: import("@prisma/client/runtime/library").Decimal;
                quantity: number;
                productId: number;
                subtotal: import("@prisma/client/runtime/library").Decimal;
                discountAmount: import("@prisma/client/runtime/library").Decimal;
                orderId: number;
                unitPrice: import("@prisma/client/runtime/library").Decimal;
            })[];
            customer: {
                id: number;
                email: string | null;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                phone: string;
                address: string | null;
                isMember: boolean;
                memberSince: Date | null;
                totalSpent: import("@prisma/client/runtime/library").Decimal;
                notes: string | null;
            } | null;
            discount: {
                id: number;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                code: string;
                description: string | null;
                type: import(".prisma/client").$Enums.DiscountType;
                value: import("@prisma/client/runtime/library").Decimal;
                minPurchase: import("@prisma/client/runtime/library").Decimal | null;
                maxDiscount: import("@prisma/client/runtime/library").Decimal | null;
                buyQuantity: number | null;
                getQuantity: number | null;
                startDate: Date | null;
                endDate: Date | null;
                usageLimit: number | null;
                usageCount: number;
                applicableToAll: boolean;
                memberOnly: boolean;
                wholesaleMinQty: number | null;
            } | null;
            createdBy: {
                id: number;
                username: string;
                email: string;
                password: string;
                role: import(".prisma/client").$Enums.UserRole;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
            };
        } & {
            id: number;
            createdAt: Date;
            updatedAt: Date;
            total: import("@prisma/client/runtime/library").Decimal;
            notes: string | null;
            customerId: number | null;
            orderNumber: string;
            userId: number;
            status: import(".prisma/client").$Enums.OrderStatus;
            subtotal: import("@prisma/client/runtime/library").Decimal;
            discountId: number | null;
            discountAmount: import("@prisma/client/runtime/library").Decimal;
            taxAmount: import("@prisma/client/runtime/library").Decimal;
            completedAt: Date | null;
        }>;
        createDiscount: (_: any, { input }: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            code: string;
            description: string | null;
            type: import(".prisma/client").$Enums.DiscountType;
            value: import("@prisma/client/runtime/library").Decimal;
            minPurchase: import("@prisma/client/runtime/library").Decimal | null;
            maxDiscount: import("@prisma/client/runtime/library").Decimal | null;
            buyQuantity: number | null;
            getQuantity: number | null;
            startDate: Date | null;
            endDate: Date | null;
            usageLimit: number | null;
            usageCount: number;
            applicableToAll: boolean;
            memberOnly: boolean;
            wholesaleMinQty: number | null;
        }>;
        updateDiscount: (_: any, { id, input }: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            code: string;
            description: string | null;
            type: import(".prisma/client").$Enums.DiscountType;
            value: import("@prisma/client/runtime/library").Decimal;
            minPurchase: import("@prisma/client/runtime/library").Decimal | null;
            maxDiscount: import("@prisma/client/runtime/library").Decimal | null;
            buyQuantity: number | null;
            getQuantity: number | null;
            startDate: Date | null;
            endDate: Date | null;
            usageLimit: number | null;
            usageCount: number;
            applicableToAll: boolean;
            memberOnly: boolean;
            wholesaleMinQty: number | null;
        }>;
        deleteDiscount: (_: any, { id }: any, context: import("../../types/context").Context) => Promise<boolean>;
        createCustomer: (_: any, { input }: any, context: import("../../types/context").Context) => Promise<{
            _count: {
                orders: number;
            };
        } & {
            id: number;
            email: string | null;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            phone: string;
            address: string | null;
            isMember: boolean;
            memberSince: Date | null;
            totalSpent: import("@prisma/client/runtime/library").Decimal;
            notes: string | null;
        }>;
        updateCustomer: (_: any, { id, input }: any, context: import("../../types/context").Context) => Promise<{
            _count: {
                orders: number;
            };
        } & {
            id: number;
            email: string | null;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            phone: string;
            address: string | null;
            isMember: boolean;
            memberSince: Date | null;
            totalSpent: import("@prisma/client/runtime/library").Decimal;
            notes: string | null;
        }>;
        deleteCustomer: (_: any, { id }: any, context: import("../../types/context").Context) => Promise<boolean>;
        createProduct: (_: any, { input }: any, context: import("../../types/context").Context) => Promise<({
            category: {
                id: number;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                description: string | null;
            };
            images: {
                id: number;
                createdAt: Date;
                displayOrder: number;
                isMain: boolean;
                productId: number;
                imageUrl: string;
            }[];
        } & {
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            description: string | null;
            categoryId: number;
            sku: string;
            barcode: string | null;
            price: import("@prisma/client/runtime/library").Decimal;
            costPrice: import("@prisma/client/runtime/library").Decimal | null;
            stock: number;
            minStock: number;
            popularity: number;
        }) | null>;
        updateProduct: (_: any, { id, input }: any, context: import("../../types/context").Context) => Promise<({
            category: {
                id: number;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                description: string | null;
            };
            images: {
                id: number;
                createdAt: Date;
                displayOrder: number;
                isMain: boolean;
                productId: number;
                imageUrl: string;
            }[];
        } & {
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            description: string | null;
            categoryId: number;
            sku: string;
            barcode: string | null;
            price: import("@prisma/client/runtime/library").Decimal;
            costPrice: import("@prisma/client/runtime/library").Decimal | null;
            stock: number;
            minStock: number;
            popularity: number;
        }) | null>;
        deleteProduct: (_: any, { id }: any, context: import("../../types/context").Context) => Promise<boolean>;
        updateProductStock: (_: any, { id, quantity }: any, context: import("../../types/context").Context) => Promise<{
            category: {
                id: number;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                description: string | null;
            };
        } & {
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            description: string | null;
            categoryId: number;
            sku: string;
            barcode: string | null;
            price: import("@prisma/client/runtime/library").Decimal;
            costPrice: import("@prisma/client/runtime/library").Decimal | null;
            stock: number;
            minStock: number;
            popularity: number;
        }>;
        createCategory: (_: any, { input }: any, context: import("../../types/context").Context) => Promise<{
            _count: {
                products: number;
            };
        } & {
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            description: string | null;
        }>;
        updateCategory: (_: any, { id, input }: any, context: import("../../types/context").Context) => Promise<{
            _count: {
                products: number;
            };
        } & {
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            description: string | null;
        }>;
        deleteCategory: (_: any, { id }: any, context: import("../../types/context").Context) => Promise<boolean>;
        createUser: (_: any, { input }: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            username: string;
            email: string;
            password: string;
            role: import(".prisma/client").$Enums.UserRole;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
        }>;
        updateUser: (_: any, { id, input }: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            username: string;
            email: string;
            password: string;
            role: import(".prisma/client").$Enums.UserRole;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
        }>;
        deleteUser: (_: any, { id }: any, context: import("../../types/context").Context) => Promise<boolean>;
        login: (_: any, { input }: any, context: import("../../types/context").Context) => Promise<{
            token: string;
            refreshToken: string;
            user: {
                id: number;
                username: string;
                email: string;
                password: string;
                role: import(".prisma/client").$Enums.UserRole;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
            };
        }>;
        register: (_: any, { input }: any, context: import("../../types/context").Context) => Promise<{
            token: string;
            refreshToken: string;
            user: {
                id: number;
                username: string;
                email: string;
                password: string;
                role: import(".prisma/client").$Enums.UserRole;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
            };
        }>;
        refreshToken: (_: any, { refreshToken }: any, context: import("../../types/context").Context) => Promise<{
            token: string;
            refreshToken: string;
            user: {
                id: number;
                username: string;
                email: string;
                password: string;
                role: import(".prisma/client").$Enums.UserRole;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
            };
        }>;
    };
    Category: {
        productCount: (parent: any, _: any, context: import("../../types/context").Context) => Promise<number>;
        products: (parent: any, _: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            description: string | null;
            categoryId: number;
            sku: string;
            barcode: string | null;
            price: import("@prisma/client/runtime/library").Decimal;
            costPrice: import("@prisma/client/runtime/library").Decimal | null;
            stock: number;
            minStock: number;
            popularity: number;
        }[]>;
    };
    Product: {
        category: (parent: any, _: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            description: string | null;
        } | null>;
        images: (parent: any, _: any, context: import("../../types/context").Context) => Promise<any>;
        mainImage: (parent: any, _: any, context: import("../../types/context").Context) => Promise<any>;
    };
    Customer: {
        orderCount: (parent: any, _: any, context: import("../../types/context").Context) => Promise<number>;
        orders: (parent: any, _: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            createdAt: Date;
            updatedAt: Date;
            total: import("@prisma/client/runtime/library").Decimal;
            notes: string | null;
            customerId: number | null;
            orderNumber: string;
            userId: number;
            status: import(".prisma/client").$Enums.OrderStatus;
            subtotal: import("@prisma/client/runtime/library").Decimal;
            discountId: number | null;
            discountAmount: import("@prisma/client/runtime/library").Decimal;
            taxAmount: import("@prisma/client/runtime/library").Decimal;
            completedAt: Date | null;
        }[]>;
    };
    Order: {
        customer: (parent: any, _: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            email: string | null;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            phone: string;
            address: string | null;
            isMember: boolean;
            memberSince: Date | null;
            totalSpent: import("@prisma/client/runtime/library").Decimal;
            notes: string | null;
        } | null>;
        createdBy: (parent: any, _: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            username: string;
            email: string;
            password: string;
            role: import(".prisma/client").$Enums.UserRole;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
        } | null>;
        discount: (parent: any, _: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            code: string;
            description: string | null;
            type: import(".prisma/client").$Enums.DiscountType;
            value: import("@prisma/client/runtime/library").Decimal;
            minPurchase: import("@prisma/client/runtime/library").Decimal | null;
            maxDiscount: import("@prisma/client/runtime/library").Decimal | null;
            buyQuantity: number | null;
            getQuantity: number | null;
            startDate: Date | null;
            endDate: Date | null;
            usageLimit: number | null;
            usageCount: number;
            applicableToAll: boolean;
            memberOnly: boolean;
            wholesaleMinQty: number | null;
        } | null>;
        orderItems: (parent: any, _: any, context: import("../../types/context").Context) => Promise<({
            product: {
                id: number;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
                name: string;
                description: string | null;
                categoryId: number;
                sku: string;
                barcode: string | null;
                price: import("@prisma/client/runtime/library").Decimal;
                costPrice: import("@prisma/client/runtime/library").Decimal | null;
                stock: number;
                minStock: number;
                popularity: number;
            };
        } & {
            id: number;
            total: import("@prisma/client/runtime/library").Decimal;
            quantity: number;
            productId: number;
            subtotal: import("@prisma/client/runtime/library").Decimal;
            discountAmount: import("@prisma/client/runtime/library").Decimal;
            orderId: number;
            unitPrice: import("@prisma/client/runtime/library").Decimal;
        })[]>;
    };
    OrderItem: {
        product: (parent: any, _: any, context: import("../../types/context").Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            description: string | null;
            categoryId: number;
            sku: string;
            barcode: string | null;
            price: import("@prisma/client/runtime/library").Decimal;
            costPrice: import("@prisma/client/runtime/library").Decimal | null;
            stock: number;
            minStock: number;
            popularity: number;
        } | null>;
    };
    Commission: {
        user: (parent: any, _: any, { prisma }: import("../../types/context").Context) => Promise<{
            id: number;
            username: string;
            email: string;
            password: string;
            role: import(".prisma/client").$Enums.UserRole;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
        } | null>;
        order: (parent: any, _: any, { prisma }: import("../../types/context").Context) => Promise<{
            id: number;
            createdAt: Date;
            updatedAt: Date;
            total: import("@prisma/client/runtime/library").Decimal;
            notes: string | null;
            customerId: number | null;
            orderNumber: string;
            userId: number;
            status: import(".prisma/client").$Enums.OrderStatus;
            subtotal: import("@prisma/client/runtime/library").Decimal;
            discountId: number | null;
            discountAmount: import("@prisma/client/runtime/library").Decimal;
            taxAmount: import("@prisma/client/runtime/library").Decimal;
            completedAt: Date | null;
        } | null>;
    };
    SalesTarget: {
        achievementRate: (parent: any) => number;
        isAchieved: (parent: any) => boolean;
    };
    AppLicense: {
        isExpired: (parent: any) => boolean;
        daysRemaining: (parent: any) => number;
    };
};
//# sourceMappingURL=index.d.ts.map