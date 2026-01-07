import { Prisma } from '@prisma/client';
import { Context } from '../../types/context';
export declare const orderResolvers: {
    Query: {
        orders: (_: any, { pagination, sort, filter }: any, context: Context) => Promise<{
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
                        price: Prisma.Decimal;
                        costPrice: Prisma.Decimal | null;
                        stock: number;
                        minStock: number;
                        popularity: number;
                    };
                } & {
                    id: number;
                    total: Prisma.Decimal;
                    quantity: number;
                    productId: number;
                    subtotal: Prisma.Decimal;
                    discountAmount: Prisma.Decimal;
                    orderId: number;
                    unitPrice: Prisma.Decimal;
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
                    totalSpent: Prisma.Decimal;
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
                    value: Prisma.Decimal;
                    minPurchase: Prisma.Decimal | null;
                    maxDiscount: Prisma.Decimal | null;
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
            })[];
            total: number;
            page: any;
            pageSize: number;
            totalPages: number;
        }>;
        order: (_: any, { id }: any, context: Context) => Promise<{
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
                        total: Prisma.Decimal;
                        quantity: number;
                        productId: number;
                        subtotal: Prisma.Decimal;
                        discountAmount: Prisma.Decimal;
                        orderId: number;
                        unitPrice: Prisma.Decimal;
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
                        total: Prisma.Decimal;
                        quantity: number;
                        productId: number;
                        subtotal: Prisma.Decimal;
                        discountAmount: Prisma.Decimal;
                        orderId: number;
                        unitPrice: Prisma.Decimal;
                    } | {
                        id: number;
                        total: Prisma.Decimal;
                        quantity: number;
                        productId: number;
                        subtotal: Prisma.Decimal;
                        discountAmount: Prisma.Decimal;
                        orderId: number;
                        unitPrice: Prisma.Decimal;
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
                    price: Prisma.Decimal;
                    costPrice: Prisma.Decimal | null;
                    stock: number;
                    minStock: number;
                    popularity: number;
                };
            } & {
                id: number;
                total: Prisma.Decimal;
                quantity: number;
                productId: number;
                subtotal: Prisma.Decimal;
                discountAmount: Prisma.Decimal;
                orderId: number;
                unitPrice: Prisma.Decimal;
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
                totalSpent: Prisma.Decimal;
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
                value: Prisma.Decimal;
                minPurchase: Prisma.Decimal | null;
                maxDiscount: Prisma.Decimal | null;
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
        }>;
        orderByNumber: (_: any, { orderNumber }: any, context: Context) => Promise<{
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
                    price: Prisma.Decimal;
                    costPrice: Prisma.Decimal | null;
                    stock: number;
                    minStock: number;
                    popularity: number;
                };
            } & {
                id: number;
                total: Prisma.Decimal;
                quantity: number;
                productId: number;
                subtotal: Prisma.Decimal;
                discountAmount: Prisma.Decimal;
                orderId: number;
                unitPrice: Prisma.Decimal;
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
                totalSpent: Prisma.Decimal;
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
                value: Prisma.Decimal;
                minPurchase: Prisma.Decimal | null;
                maxDiscount: Prisma.Decimal | null;
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
        }>;
    };
    Mutation: {
        createOrder: (_: any, { input }: any, context: Context) => Promise<{
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
                    price: Prisma.Decimal;
                    costPrice: Prisma.Decimal | null;
                    stock: number;
                    minStock: number;
                    popularity: number;
                };
            } & {
                id: number;
                total: Prisma.Decimal;
                quantity: number;
                productId: number;
                subtotal: Prisma.Decimal;
                discountAmount: Prisma.Decimal;
                orderId: number;
                unitPrice: Prisma.Decimal;
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
                totalSpent: Prisma.Decimal;
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
                value: Prisma.Decimal;
                minPurchase: Prisma.Decimal | null;
                maxDiscount: Prisma.Decimal | null;
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
        }>;
        updateOrder: (_: any, { id, input }: any, context: Context) => Promise<{
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
                    price: Prisma.Decimal;
                    costPrice: Prisma.Decimal | null;
                    stock: number;
                    minStock: number;
                    popularity: number;
                };
            } & {
                id: number;
                total: Prisma.Decimal;
                quantity: number;
                productId: number;
                subtotal: Prisma.Decimal;
                discountAmount: Prisma.Decimal;
                orderId: number;
                unitPrice: Prisma.Decimal;
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
                totalSpent: Prisma.Decimal;
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
                value: Prisma.Decimal;
                minPurchase: Prisma.Decimal | null;
                maxDiscount: Prisma.Decimal | null;
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
        }>;
        cancelOrder: (_: any, { id }: any, context: Context) => Promise<{
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
                    price: Prisma.Decimal;
                    costPrice: Prisma.Decimal | null;
                    stock: number;
                    minStock: number;
                    popularity: number;
                };
            } & {
                id: number;
                total: Prisma.Decimal;
                quantity: number;
                productId: number;
                subtotal: Prisma.Decimal;
                discountAmount: Prisma.Decimal;
                orderId: number;
                unitPrice: Prisma.Decimal;
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
                totalSpent: Prisma.Decimal;
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
                value: Prisma.Decimal;
                minPurchase: Prisma.Decimal | null;
                maxDiscount: Prisma.Decimal | null;
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
        }>;
    };
    Order: {
        customer: (parent: any, _: any, context: Context) => Promise<{
            id: number;
            email: string | null;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            phone: string;
            address: string | null;
            isMember: boolean;
            memberSince: Date | null;
            totalSpent: Prisma.Decimal;
            notes: string | null;
        } | null>;
        createdBy: (parent: any, _: any, context: Context) => Promise<{
            id: number;
            username: string;
            email: string;
            password: string;
            role: import(".prisma/client").$Enums.UserRole;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
        } | null>;
        discount: (parent: any, _: any, context: Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            code: string;
            description: string | null;
            type: import(".prisma/client").$Enums.DiscountType;
            value: Prisma.Decimal;
            minPurchase: Prisma.Decimal | null;
            maxDiscount: Prisma.Decimal | null;
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
        orderItems: (parent: any, _: any, context: Context) => Promise<({
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
                price: Prisma.Decimal;
                costPrice: Prisma.Decimal | null;
                stock: number;
                minStock: number;
                popularity: number;
            };
        } & {
            id: number;
            total: Prisma.Decimal;
            quantity: number;
            productId: number;
            subtotal: Prisma.Decimal;
            discountAmount: Prisma.Decimal;
            orderId: number;
            unitPrice: Prisma.Decimal;
        })[]>;
    };
    OrderItem: {
        product: (parent: any, _: any, context: Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            description: string | null;
            categoryId: number;
            sku: string;
            barcode: string | null;
            price: Prisma.Decimal;
            costPrice: Prisma.Decimal | null;
            stock: number;
            minStock: number;
            popularity: number;
        } | null>;
    };
};
//# sourceMappingURL=order.resolver.d.ts.map