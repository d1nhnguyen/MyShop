"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.productResolvers = void 0;
const graphql_1 = require("graphql");
const auth_middleware_1 = require("../../middleware/auth.middleware");
exports.productResolvers = {
    Query: {
        products: async (_, { pagination, sort, filter }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const page = pagination?.page || 1;
            const pageSize = Math.min(pagination?.pageSize || 20, 1000);
            const skip = (page - 1) * pageSize;
            const where = {};
            if (filter) {
                if (filter.name) {
                    where.name = { contains: filter.name, mode: 'insensitive' };
                }
                if (filter.categoryId) {
                    where.categoryId = filter.categoryId;
                }
                if (filter.minPrice !== undefined || filter.maxPrice !== undefined) {
                    where.price = {};
                    if (filter.minPrice !== undefined)
                        where.price.gte = filter.minPrice;
                    if (filter.maxPrice !== undefined)
                        where.price.lte = filter.maxPrice;
                }
                if (filter.inStock !== undefined) {
                    where.stock = filter.inStock ? { gt: 0 } : { lte: 0 };
                }
                if (filter.isActive !== undefined) {
                    where.isActive = filter.isActive;
                }
            }
            const orderBy = sort
                ? { [sort.field]: sort.order.toLowerCase() }
                : { createdAt: 'desc' };
            const [products, total] = await Promise.all([
                context.prisma.product.findMany({
                    where,
                    skip,
                    take: pageSize,
                    orderBy,
                    include: {
                        category: true,
                        images: {
                            orderBy: [
                                { isMain: 'desc' },
                                { displayOrder: 'asc' },
                            ],
                        },
                    },
                }),
                context.prisma.product.count({ where }),
            ]);
            return {
                products,
                total,
                page,
                pageSize,
                totalPages: Math.ceil(total / pageSize),
            };
        },
        product: async (_, { id }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const product = await context.prisma.product.findUnique({
                where: { id },
                include: {
                    category: true,
                    images: {
                        orderBy: [
                            { isMain: 'desc' },
                            { displayOrder: 'asc' },
                        ],
                    },
                },
            });
            if (!product) {
                throw new graphql_1.GraphQLError('Product not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            return product;
        },
        productBySku: async (_, { sku }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const product = await context.prisma.product.findUnique({
                where: { sku },
                include: {
                    category: true,
                    images: {
                        orderBy: [
                            { isMain: 'desc' },
                            { displayOrder: 'asc' },
                        ],
                    },
                },
            });
            if (!product) {
                throw new graphql_1.GraphQLError('Product not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            return product;
        },
        lowStockProducts: async (_, { threshold = 10 }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            const products = await context.prisma.product.findMany({
                where: {
                    stock: { lte: threshold },
                    isActive: true,
                },
                include: {
                    category: true,
                    images: {
                        orderBy: [
                            { isMain: 'desc' },
                            { displayOrder: 'asc' },
                        ],
                    },
                },
                orderBy: {
                    stock: 'asc',
                },
            });
            return products;
        },
    },
    Mutation: {
        createProduct: async (_, { input }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            (0, auth_middleware_1.requireRole)(context, ['ADMIN', 'MANAGER']);
            const existingSku = await context.prisma.product.findUnique({
                where: { sku: input.sku },
            });
            if (existingSku) {
                throw new graphql_1.GraphQLError('SKU already exists', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            if (input.barcode) {
                const existingBarcode = await context.prisma.product.findUnique({
                    where: { barcode: input.barcode },
                });
                if (existingBarcode) {
                    throw new graphql_1.GraphQLError('Barcode already exists', {
                        extensions: { code: 'BAD_USER_INPUT' },
                    });
                }
            }
            const category = await context.prisma.category.findUnique({
                where: { id: input.categoryId },
            });
            if (!category) {
                throw new graphql_1.GraphQLError('Category not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            const { imageUrls, ...productData } = input;
            const product = await context.prisma.$transaction(async (tx) => {
                const newProduct = await tx.product.create({
                    data: productData,
                    include: {
                        category: true,
                    },
                });
                if (imageUrls && imageUrls.length > 0) {
                    await tx.productImage.createMany({
                        data: imageUrls.map((url, index) => ({
                            productId: newProduct.id,
                            imageUrl: url,
                            displayOrder: index,
                            isMain: index === 0,
                        })),
                    });
                }
                return tx.product.findUnique({
                    where: { id: newProduct.id },
                    include: {
                        category: true,
                        images: {
                            orderBy: [
                                { isMain: 'desc' },
                                { displayOrder: 'asc' },
                            ],
                        },
                    },
                });
            });
            return product;
        },
        updateProduct: async (_, { id, input }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            (0, auth_middleware_1.requireRole)(context, ['ADMIN', 'MANAGER']);
            const existingProduct = await context.prisma.product.findUnique({
                where: { id },
            });
            if (!existingProduct) {
                throw new graphql_1.GraphQLError('Product not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            if (input.sku && input.sku !== existingProduct.sku) {
                const existingSku = await context.prisma.product.findUnique({
                    where: { sku: input.sku },
                });
                if (existingSku) {
                    throw new graphql_1.GraphQLError('SKU already exists', {
                        extensions: { code: 'BAD_USER_INPUT' },
                    });
                }
            }
            if (input.barcode && input.barcode !== existingProduct.barcode) {
                const existingBarcode = await context.prisma.product.findUnique({
                    where: { barcode: input.barcode },
                });
                if (existingBarcode) {
                    throw new graphql_1.GraphQLError('Barcode already exists', {
                        extensions: { code: 'BAD_USER_INPUT' },
                    });
                }
            }
            const { imageUrls, mainImageIndex, ...productData } = input;
            const product = await context.prisma.$transaction(async (tx) => {
                await tx.product.update({
                    where: { id },
                    data: productData,
                });
                if (imageUrls && imageUrls.length > 0) {
                    await tx.productImage.deleteMany({
                        where: { productId: id },
                    });
                    const mainIndex = mainImageIndex !== undefined ? mainImageIndex : 0;
                    await tx.productImage.createMany({
                        data: imageUrls.map((url, index) => ({
                            productId: id,
                            imageUrl: url,
                            displayOrder: index,
                            isMain: index === mainIndex,
                        })),
                    });
                }
                return tx.product.findUnique({
                    where: { id },
                    include: {
                        category: true,
                        images: {
                            orderBy: [
                                { isMain: 'desc' },
                                { displayOrder: 'asc' },
                            ],
                        },
                    },
                });
            });
            return product;
        },
        deleteProduct: async (_, { id }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            (0, auth_middleware_1.requireRole)(context, ['ADMIN']);
            const existingProduct = await context.prisma.product.findUnique({
                where: { id },
            });
            if (!existingProduct) {
                throw new graphql_1.GraphQLError('Product not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            const ordersCount = await context.prisma.orderItem.count({
                where: { productId: id },
            });
            if (ordersCount > 0) {
                throw new graphql_1.GraphQLError('Cannot delete product that has been ordered', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            await context.prisma.product.delete({
                where: { id },
            });
            return true;
        },
        updateProductStock: async (_, { id, quantity }, context) => {
            (0, auth_middleware_1.requireAuth)(context);
            (0, auth_middleware_1.requireRole)(context, ['ADMIN', 'MANAGER', 'STAFF']);
            const product = await context.prisma.product.findUnique({
                where: { id },
            });
            if (!product) {
                throw new graphql_1.GraphQLError('Product not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            const newStock = product.stock + quantity;
            if (newStock < 0) {
                throw new graphql_1.GraphQLError('Insufficient stock', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            const updatedProduct = await context.prisma.product.update({
                where: { id },
                data: { stock: newStock },
                include: {
                    category: true,
                },
            });
            return updatedProduct;
        },
    },
    Product: {
        category: async (parent, _, context) => {
            return context.prisma.category.findUnique({
                where: { id: parent.categoryId },
            });
        },
        images: async (parent, _, context) => {
            if (parent.images && Array.isArray(parent.images))
                return parent.images;
            return context.prisma.productImage.findMany({
                where: { productId: parent.id },
                orderBy: [
                    { isMain: 'desc' },
                    { displayOrder: 'asc' },
                ],
            });
        },
        mainImage: async (parent, _, context) => {
            if (parent.images && Array.isArray(parent.images)) {
                const mainImg = parent.images.find((img) => img.isMain);
                return mainImg?.imageUrl || parent.images[0]?.imageUrl || null;
            }
            const mainImg = await context.prisma.productImage.findFirst({
                where: {
                    productId: parent.id,
                    isMain: true
                },
            });
            if (mainImg)
                return mainImg.imageUrl;
            const firstImg = await context.prisma.productImage.findFirst({
                where: { productId: parent.id },
                orderBy: { displayOrder: 'asc' }
            });
            return firstImg?.imageUrl || null;
        },
    },
};
//# sourceMappingURL=product.resolver.js.map