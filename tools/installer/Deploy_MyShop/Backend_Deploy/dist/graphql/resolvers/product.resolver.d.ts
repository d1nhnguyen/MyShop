import { Context } from '../../types/context';
export declare const productResolvers: {
    Query: {
        products: (_: any, { pagination, sort, filter }: any, context: Context) => Promise<{
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
        product: (_: any, { id }: any, context: Context) => Promise<{
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
        productBySku: (_: any, { sku }: any, context: Context) => Promise<{
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
        lowStockProducts: (_: any, { threshold }: any, context: Context) => Promise<({
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
    };
    Mutation: {
        createProduct: (_: any, { input }: any, context: Context) => Promise<({
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
        updateProduct: (_: any, { id, input }: any, context: Context) => Promise<({
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
        deleteProduct: (_: any, { id }: any, context: Context) => Promise<boolean>;
        updateProductStock: (_: any, { id, quantity }: any, context: Context) => Promise<{
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
    };
    Product: {
        category: (parent: any, _: any, context: Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
            name: string;
            description: string | null;
        } | null>;
        images: (parent: any, _: any, context: Context) => Promise<any>;
        mainImage: (parent: any, _: any, context: Context) => Promise<any>;
    };
};
//# sourceMappingURL=product.resolver.d.ts.map