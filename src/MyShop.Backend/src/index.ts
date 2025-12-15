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

async function startServer() {
  // Create Express app
  const app = express();

  // Middleware
  app.use(cors({
    origin: env.CORS_ORIGIN,
    credentials: true,
  }));

  app.use(express.json());

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
        // Extract and verify JWT token
        const token = AuthUtils.extractToken(req.headers.authorization);
        let user = undefined;

        if (token) {
          try {
            user = AuthUtils.verifyToken(token);
          } catch (error) {
            // Token is invalid, but we don't throw error here
            // Let the resolver handle authentication
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

  // GraphQL Playground for development
  if (env.NODE_ENV === 'development') {
    app.get('/', (_, res) => {
      res.send(`
        <!DOCTYPE html>
        <html>
        <head>
          <title>MyShop GraphQL API</title>
          <style>
            body {
              font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
              max-width: 800px;
              margin: 50px auto;
              padding: 20px;
              background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
              color: white;
            }
            .container {
              background: rgba(255, 255, 255, 0.1);
              backdrop-filter: blur(10px);
              padding: 40px;
              border-radius: 20px;
              box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            }
            h1 { margin-top: 0; }
            a {
              display: inline-block;
              margin: 10px 10px 10px 0;
              padding: 12px 24px;
              background: white;
              color: #667eea;
              text-decoration: none;
              border-radius: 8px;
              font-weight: bold;
              transition: transform 0.2s;
            }
            a:hover {
              transform: translateY(-2px);
              box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            }
            .info {
              margin: 20px 0;
              padding: 15px;
              background: rgba(255, 255, 255, 0.1);
              border-radius: 8px;
            }
            code {
              background: rgba(0, 0, 0, 0.2);
              padding: 2px 6px;
              border-radius: 4px;
              font-family: 'Courier New', monospace;
            }
          </style>
        </head>
        <body>
          <div class="container">
            <h1>🛍️ MyShop GraphQL API</h1>
            <div class="info">
              <p><strong>Environment:</strong> ${env.NODE_ENV}</p>
              <p><strong>GraphQL Endpoint:</strong> <code>/graphql</code></p>
              <p><strong>Health Check:</strong> <code>/health</code></p>
            </div>
            <div>
              <a href="/graphql" target="_blank">🚀 Open GraphQL Playground</a>
              <a href="/health" target="_blank">❤️ Health Check</a>
            </div>
            <div class="info" style="margin-top: 30px;">
              <h3>🔐 Default Admin Credentials:</h3>
              <p><strong>Username:</strong> <code>admin</code></p>
              <p><strong>Email:</strong> <code>admin@myshop.com</code></p>
              <p><strong>Password:</strong> <code>Admin@123456</code></p>
              <p style="margin-top: 10px;"><em>Run <code>pnpm seed:admin</code> to create admin user if not exists</em></p>
            </div>
          </div>
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
    console.log('\n🚀 Server is running!\n');
    console.log(`   Environment: ${env.NODE_ENV}`);
    console.log(`   Port: ${PORT}`);
    console.log(`   GraphQL endpoint: http://localhost:${PORT}/graphql`);
    console.log(`   Health check: http://localhost:${PORT}/health`);
    if (env.NODE_ENV === 'development') {
      console.log(`   Home page: http://localhost:${PORT}/\n`);
    }
    console.log('📊 Ready to accept requests!\n');
  });

  // Graceful shutdown
  process.on('SIGINT', async () => {
    console.log('\n🛑 Shutting down gracefully...');
    await prisma.$disconnect();
    process.exit(0);
  });

  process.on('SIGTERM', async () => {
    console.log('\n🛑 Shutting down gracefully...');
    await prisma.$disconnect();
    process.exit(0);
  });
}

// Start the server
startServer().catch((error) => {
  console.error('Failed to start server:', error);
  process.exit(1);
});
