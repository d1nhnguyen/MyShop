import { Context } from '../../types/context';
export declare const categoryResolvers: {
    Query: {
        categories: (_: any, { pagination, sort }: any, context: Context) => Promise<{
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
        category: (_: any, { id }: any, context: Context) => Promise<{
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
        activeCategories: (_: any, __: any, context: Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            description: string | null;
        }[]>;
    };
    Mutation: {
        createCategory: (_: any, { input }: any, context: Context) => Promise<{
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
        updateCategory: (_: any, { id, input }: any, context: Context) => Promise<{
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
        deleteCategory: (_: any, { id }: any, context: Context) => Promise<boolean>;
    };
    Category: {
        productCount: (parent: any, _: any, context: Context) => Promise<number>;
        products: (parent: any, _: any, context: Context) => Promise<{
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
};
//# sourceMappingURL=category.resolver.d.ts.map