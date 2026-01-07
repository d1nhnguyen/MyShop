"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const server_1 = require("@apollo/server");
const express4_1 = require("@apollo/server/express4");
const schema_1 = require("@graphql-tools/schema");
const typeDefs_1 = require("./graphql/typeDefs");
const resolvers_1 = require("./graphql/resolvers");
const env_1 = require("./config/env");
const database_1 = __importDefault(require("./config/database"));
const auth_1 = require("./utils/auth");
const fs_1 = __importDefault(require("fs"));
const path_1 = __importDefault(require("path"));
const multer_1 = __importDefault(require("multer"));
async function startServer() {
    const app = (0, express_1.default)();
    app.use((0, cors_1.default)({
        origin: env_1.env.CORS_ORIGIN,
        credentials: true,
    }));
    app.use(express_1.default.json({ limit: '50mb' }));
    const uploadDir = path_1.default.join(__dirname, '../uploads');
    const productUploadDir = path_1.default.join(uploadDir, 'products');
    if (!fs_1.default.existsSync(uploadDir)) {
        fs_1.default.mkdirSync(uploadDir, { recursive: true });
    }
    if (!fs_1.default.existsSync(productUploadDir)) {
        fs_1.default.mkdirSync(productUploadDir, { recursive: true });
    }
    app.use('/uploads', express_1.default.static(uploadDir));
    const storage = multer_1.default.diskStorage({
        destination: (_req, _file, cb) => {
            cb(null, productUploadDir);
        },
        filename: (_req, file, cb) => {
            const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
            const ext = path_1.default.extname(file.originalname);
            cb(null, `product-${uniqueSuffix}${ext}`);
        }
    });
    const upload = (0, multer_1.default)({
        storage: storage,
        limits: { fileSize: 10 * 1024 * 1024 },
        fileFilter: (_req, file, cb) => {
            const allowedTypes = /jpeg|jpg|png|gif/;
            const mimetype = allowedTypes.test(file.mimetype);
            const extname = allowedTypes.test(path_1.default.extname(file.originalname).toLowerCase());
            if (mimetype && extname) {
                return cb(null, true);
            }
            cb(new Error('Only image files are allowed!'));
        }
    });
    app.post('/api/upload/product-image', upload.single('file'), (req, res) => {
        try {
            if (!req.file) {
                return res.status(400).json({ error: 'No file uploaded' });
            }
            const protocol = req.protocol;
            const host = req.get('host');
            const imageUrl = `${protocol}://${host}/uploads/products/${req.file.filename}`;
            return res.json({ imageUrl });
        }
        catch (error) {
            console.error('Upload error:', error);
            return res.status(500).json({ error: 'Upload failed' });
        }
    });
    app.post('/api/upload', (req, res) => {
        try {
            const { image, fileName } = req.body;
            if (!image || !fileName) {
                return res.status(400).json({ error: 'Missing image or fileName' });
            }
            const base64Data = image.replace(/^data:image\/\w+;base64,/, "");
            const buffer = Buffer.from(base64Data, 'base64');
            const uniqueName = `${Date.now()}-${fileName}`;
            const filePath = path_1.default.join(uploadDir, uniqueName);
            fs_1.default.writeFileSync(filePath, buffer);
            const protocol = req.protocol;
            const host = req.get('host');
            const fileUrl = `${protocol}://${host}/uploads/${uniqueName}`;
            return res.json({ url: fileUrl });
        }
        catch (error) {
            console.error('Upload error:', error);
            return res.status(500).json({ error: 'Upload failed' });
        }
    });
    app.get('/health', (_, res) => {
        res.json({
            status: 'ok',
            timestamp: new Date().toISOString(),
            environment: env_1.env.NODE_ENV,
        });
    });
    const schema = (0, schema_1.makeExecutableSchema)({
        typeDefs: typeDefs_1.typeDefs,
        resolvers: resolvers_1.resolvers,
    });
    const server = new server_1.ApolloServer({
        schema,
        formatError: (formattedError) => {
            console.error('GraphQL Error:', formattedError);
            return formattedError;
        },
    });
    await server.start();
    console.log('Syncing product popularity...');
    try {
        await database_1.default.product.updateMany({
            data: { popularity: 0 }
        });
        const stats = await database_1.default.orderItem.groupBy({
            by: ['productId'],
            _sum: {
                quantity: true
            },
            where: {
                order: {
                    status: 'COMPLETED'
                }
            }
        });
        await Promise.all(stats.map(stat => database_1.default.product.update({
            where: { id: stat.productId },
            data: { popularity: stat._sum.quantity || 0 }
        })));
        console.log(`Synced popularity for ${stats.length} products`);
    }
    catch (error) {
        console.error('Failed to sync popularity:', error);
    }
    app.use('/graphql', (0, express4_1.expressMiddleware)(server, {
        context: async ({ req }) => {
            const token = auth_1.AuthUtils.extractToken(req.headers.authorization);
            let user = undefined;
            if (token) {
                try {
                    user = auth_1.AuthUtils.verifyToken(token);
                }
                catch (error) {
                    console.log('Invalid token:', error);
                }
            }
            return {
                prisma: database_1.default,
                user,
            };
        },
    }));
    if (env_1.env.NODE_ENV === 'development') {
        app.get('/', (_, res) => {
            res.send(`
        <!DOCTYPE html>
        <html>
        <head>
          <title>MyShop GraphQL API</title>
          <style>
             /* Styles omitted for brevity, same as before */
          </style>
        </head>
        <body>
          <h1>MyShop GraphQL API Running</h1>
        </body>
        </html>
      `);
        });
    }
    app.use((err, _, res, __) => {
        console.error('Server Error:', err);
        res.status(500).json({
            error: 'Internal Server Error',
            message: env_1.env.NODE_ENV === 'development' ? err.message : 'Something went wrong',
        });
    });
    const PORT = env_1.env.PORT;
    app.listen(PORT, () => {
        console.log(`\n🚀 Server is running on port ${PORT}`);
        console.log(`   Uploads: http://localhost:${PORT}/uploads`);
    });
    process.on('SIGINT', async () => {
        await database_1.default.$disconnect();
        process.exit(0);
    });
}
startServer().catch((error) => {
    console.error('Failed to start server:', error);
    process.exit(1);
});
//# sourceMappingURL=index.js.map