import express from 'express';
import cors from 'cors';
import { ApolloServer } from '@apollo/server';
import { expressMiddleware } from '@apollo/server/express4';
import { makeExecutableSchema } from '@graphql-tools/schema';
import { typeDefs } from './graphql/typeDefs';
import { resolvers } from './graphql/resolvers';
import { env } from './config/env';
import prisma from './config/database';
import { AuthUtils } from './utils/auth';
import { Context } from './types/context';
import fs from 'fs';
import path from 'path';

async function startServer() {
  // Create Express app
  const app = express();

  // Middleware
  app.use(cors({
    origin: env.CORS_ORIGIN,
    credentials: true,
  }));

  // Increase limit to 50mb to handle Base64 images
  app.use(express.json({ limit: '50mb' }));

  // Create uploads directory if it doesn't exist
  const uploadDir = path.join(__dirname, '../uploads');
  if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir, { recursive: true });
  }

  // Serve uploaded files statically
  app.use('/uploads', express.static(uploadDir));

  // Upload Endpoint
  app.post('/api/upload', (req, res) => {
    try {
      const { image, fileName } = req.body;

      if (!image || !fileName) {
        return res.status(400).json({ error: 'Missing image or fileName' });
      }

      // Remove header if present (e.g., "data:image/png;base64,")
      const base64Data = image.replace(/^data:image\/\w+;base64,/, "");
      const buffer = Buffer.from(base64Data, 'base64');

      // Create unique filename
      const uniqueName = `${Date.now()}-${fileName}`;
      const filePath = path.join(uploadDir, uniqueName);

      // Write file
      fs.writeFileSync(filePath, buffer);

      // Construct public URL
      const protocol = req.protocol;
      const host = req.get('host');
      const fileUrl = `${protocol}://${host}/uploads/${uniqueName}`;

      // FIXED: Added return here
      return res.json({ url: fileUrl });
    } catch (error) {
      console.error('Upload error:', error);
      // FIXED: Added return here
      return res.status(500).json({ error: 'Upload failed' });
    }
  });

  // Health check endpoint
  app.get('/health', (_, res) => {
    res.json({
      status: 'ok',
      timestamp: new Date().toISOString(),
      environment: env.NODE_ENV,
    });
  });

  // Create GraphQL schema
  const schema = makeExecutableSchema({
    typeDefs,
    resolvers,
  });

  // Create Apollo Server
  const server = new ApolloServer<Context>({
    schema,
    formatError: (formattedError) => {
      console.error('GraphQL Error:', formattedError);
      return formattedError;
    },
  });

  // Start Apollo Server
  await server.start();

  // Apply Apollo middleware to Express
  app.use(
    '/graphql',
    expressMiddleware(server, {
      context: async ({ req }): Promise<Context> => {
        const token = AuthUtils.extractToken(req.headers.authorization);
        let user = undefined;

        if (token) {
          try {
            user = AuthUtils.verifyToken(token);
          } catch (error) {
            console.log('Invalid token:', error);
          }
        }

        return {
          prisma,
          user,
        };
      },
    })
  );

  // GraphQL Playground
  if (env.NODE_ENV === 'development') {
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

  // Error handling middleware
  app.use((err: any, _: express.Request, res: express.Response, __: express.NextFunction) => {
    console.error('Server Error:', err);
    res.status(500).json({
      error: 'Internal Server Error',
      message: env.NODE_ENV === 'development' ? err.message : 'Something went wrong',
    });
  });

  // Start server
  const PORT = env.PORT;
  app.listen(PORT, () => {
    console.log(`\n🚀 Server is running on port ${PORT}`);
    console.log(`   Uploads: http://localhost:${PORT}/uploads`);
  });

  process.on('SIGINT', async () => {
    await prisma.$disconnect();
    process.exit(0);
  });
}

startServer().catch((error) => {
  console.error('Failed to start server:', error);
  process.exit(1);
});