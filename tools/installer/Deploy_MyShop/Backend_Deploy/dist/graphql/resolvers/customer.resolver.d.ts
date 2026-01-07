import { Context } from '../../types/context';
export declare const customerResolvers: {
    Query: {
        customers: (_: any, { pagination, sort, filter }: any, context: Context) => Promise<{
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
        customer: (_: any, { id }: any, context: Context) => Promise<{
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
    };
    Mutation: {
        createCustomer: (_: any, { input }: any, context: Context) => Promise<{
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
        updateCustomer: (_: any, { id, input }: any, context: Context) => Promise<{
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
        deleteCustomer: (_: any, { id }: any, context: Context) => Promise<boolean>;
    };
    Customer: {
        orderCount: (parent: any, _: any, context: Context) => Promise<number>;
        orders: (parent: any, _: any, context: Context) => Promise<{
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
};
//# sourceMappingURL=customer.resolver.d.ts.map