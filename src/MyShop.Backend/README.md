# MyShop Backend - GraphQL API

A comprehensive backend server for MyShop e-commerce application built with Node.js, Express, GraphQL, Prisma, and PostgreSQL.

## 🚀 Features

- **GraphQL API** - Modern API with Apollo Server
- **Type-Safe** - Full TypeScript support with Prisma
- **Authentication** - JWT-based authentication & authorization
- **Role-Based Access Control** - Admin, Manager, and Staff roles
- **Complete E-commerce Features**:
  - User Management
  - Product & Category Management
  - Customer Management
  - Order Management
  - Discount & Promotion System
  - Dashboard & Analytics
  - Sales Reports

## 📋 Prerequisites

- Node.js >= 18.x
- pnpm >= 8.x
- PostgreSQL >= 15.x
- Docker & Docker Compose (for PostgreSQL)

## 🛠️ Installation

### 1. Install Dependencies

```bash
pnpm install
```

### 2. Setup Database

Start PostgreSQL with Docker Compose (from project root):

```bash
docker-compose up -d
```

### 3. Configure Environment

Copy `.env.example` to `.env` and update if needed:

```bash
cp .env.example .env
```

Default configuration:
```env
DATABASE_URL="postgresql://admin:admin123!@localhost:5432/myshop?schema=public"
PORT=4000
NODE_ENV=development
JWT_SECRET=myshop-super-secret-jwt-key-2024-change-in-production
```

### 4. Run Prisma Migrations

```bash
pnpm prisma:generate
pnpm prisma:migrate
```

### 5. Seed Database

Create admin user:
```bash
pnpm seed:admin
```

Seed sample data (optional):
```bash
pnpm seed
```

## 🏃 Running the Server

### Development Mode
```bash
pnpm dev
```

### Production Mode
```bash
pnpm build
pnpm start
```

The server will start at: `http://localhost:4000`

- **GraphQL Playground**: `http://localhost:4000/graphql`
- **Health Check**: `http://localhost:4000/health`

## 🔐 Default Admin Credentials

After running `pnpm seed:admin`:

- **Username**: `admin`
- **Email**: `admin@myshop.com`
- **Password**: `Admin@123456`

⚠️ **Important**: Change the password after first login!

## 📚 API Documentation

### Authentication

#### Login
```graphql
mutation Login {
  login(input: {
    username: "admin"
    password: "Admin@123456"
  }) {
    token
    refreshToken
    user {
      id
      username
      email
      role
    }
  }
}
```

#### Get Current User
```graphql
query Me {
  me {
    id
    username
    email
    role
  }
}
```

### Products

#### Get Products
```graphql
query GetProducts {
  products(
    pagination: { page: 1, pageSize: 20 }
    sort: { field: "name", order: ASC }
    filter: { categoryId: 1, inStock: true }
  ) {
    products {
      id
      name
      sku
      price
      stock
      category {
        name
      }
    }
    total
    totalPages
  }
}
```

#### Create Product
```graphql
mutation CreateProduct {
  createProduct(input: {
    name: "New Product"
    sku: "PROD-001"
    price: 99.99
    stock: 100
    categoryId: 1
  }) {
    id
    name
    sku
  }
}
```

### Orders

#### Create Order
```graphql
mutation CreateOrder {
  createOrder(input: {
    customerId: 1
    items: [
      { productId: 1, quantity: 2, unitPrice: 99.99 }
    ]
    discountId: 1
    taxAmount: 5.00
  }) {
    id
    orderNumber
    total
    status
  }
}
```

### Dashboard

#### Get Dashboard Stats
```graphql
query DashboardStats {
  dashboardStats {
    totalProducts
    totalOrders
    totalRevenue
    totalCustomers
    lowStockProducts
    pendingOrders
    todayRevenue
    todayOrders
  }
}
```

#### Sales Report
```graphql
query SalesReport {
  salesReport(dateRange: {
    from: "2024-01-01"
    to: "2024-12-31"
  }) {
    totalRevenue
    totalOrders
    averageOrderValue
    topProducts {
      product {
        name
      }
      quantity
      revenue
    }
    revenueByDate {
      date
      revenue
      orders
    }
  }
}
```

## 🗂️ Project Structure

```
src/
├── config/              # Configuration files
│   ├── database.ts      # Prisma client
│   └── env.ts           # Environment variables
├── graphql/             # GraphQL layer
│   ├── resolvers/       # GraphQL resolvers
│   │   ├── auth.resolver.ts
│   │   ├── user.resolver.ts
│   │   ├── product.resolver.ts
│   │   ├── order.resolver.ts
│   │   ├── customer.resolver.ts
│   │   ├── discount.resolver.ts
│   │   ├── category.resolver.ts
│   │   ├── dashboard.resolver.ts
│   │   └── index.ts
│   └── typeDefs/        # GraphQL type definitions
│       └── index.ts
├── middleware/          # Express middleware
│   └── auth.middleware.ts
├── services/            # Business logic services
├── types/               # TypeScript types
│   └── context.ts
├── utils/               # Utility functions
│   ├── auth.ts          # Auth helpers
│   ├── seed.ts          # Database seeder
│   └── seedAdmin.ts     # Admin seeder
└── index.ts             # Server entry point

prisma/
└── schema.prisma        # Prisma schema
```

## 🎯 Available Scripts

- `pnpm dev` - Start development server with hot reload
- `pnpm build` - Build for production
- `pnpm start` - Start production server
- `pnpm prisma:generate` - Generate Prisma client
- `pnpm prisma:migrate` - Run database migrations
- `pnpm prisma:studio` - Open Prisma Studio
- `pnpm seed` - Seed database with sample data
- `pnpm seed:admin` - Create admin user
- `pnpm lint` - Run ESLint
- `pnpm format` - Format code with Prettier

## 🔑 User Roles & Permissions

### ADMIN
- Full access to all features
- Can manage users, products, orders, customers, discounts
- Can view all reports and analytics
- Can delete any resource

### MANAGER
- Can manage products, categories
- Can manage orders and customers
- Can create/update discounts
- Can view reports
- Cannot manage users

### STAFF
- Can view products and orders
- Can create orders
- Can update order status
- Can view customer information
- Limited access to management features

## 🛡️ Security Features

- **JWT Authentication** - Secure token-based authentication
- **Password Hashing** - Bcrypt for password security
- **Role-Based Access Control** - Granular permission system
- **Input Validation** - Comprehensive input validation
- **SQL Injection Prevention** - Prisma ORM protection
- **CORS** - Configurable CORS settings

## 🧪 Testing the API

You can use the GraphQL Playground or tools like:
- Apollo Studio
- Postman
- Insomnia
- GraphQL Playground

### Example: Test Login

1. Open `http://localhost:4000/graphql`
2. Run the login mutation:
```graphql
mutation {
  login(input: {
    username: "admin"
    password: "Admin@123456"
  }) {
    token
    user {
      username
      role
    }
  }
}
```
3. Copy the token from response
4. Add to HTTP headers:
```json
{
  "Authorization": "Bearer YOUR_TOKEN_HERE"
}
```

## 📊 Database Schema

See `prisma/schema.prisma` for complete database schema.

**Main Models:**
- User - System users (admin, manager, staff)
- Category - Product categories
- Product - Products for sale
- Customer - Store customers
- Discount - Discount codes and promotions
- Order - Customer orders
- OrderItem - Items in orders

## 🔄 GraphQL Schema

The complete GraphQL schema includes:
- **Queries**: 20+ query operations
- **Mutations**: 25+ mutation operations
- **Types**: Complete type definitions for all models
- **Enums**: UserRole, OrderStatus, DiscountType
- **Input Types**: Comprehensive input types for all operations

## 🐛 Troubleshooting

### Database Connection Error
```bash
# Check if PostgreSQL is running
docker-compose ps

# Restart PostgreSQL
docker-compose restart postgres
```

### Prisma Migration Issues
```bash
# Reset database (WARNING: This will delete all data)
pnpm prisma migrate reset

# Then run migrations again
pnpm prisma:migrate
```

### Port Already in Use
```bash
# Change PORT in .env file
PORT=5000
```

## 📝 Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `DATABASE_URL` | PostgreSQL connection string | `postgresql://admin:admin123!@localhost:5432/myshop` |
| `PORT` | Server port | `4000` |
| `NODE_ENV` | Environment | `development` |
| `JWT_SECRET` | JWT secret key | (change in production) |
| `JWT_EXPIRES_IN` | JWT expiration | `7d` |
| `ADMIN_EMAIL` | Admin email | `admin@myshop.com` |
| `ADMIN_PASSWORD` | Admin password | `Admin@123456` |
| `CORS_ORIGIN` | CORS allowed origin | `http://localhost:3000` |

## 🤝 Contributing

This backend is part of the MyShop team project. See team work division document for module ownership.

## 📄 License

MIT License - see LICENSE file for details

## 👥 Team

- **Person 1**: Infrastructure & Authentication
- **Person 2**: Products Management
- **Person 3**: Orders Management
- **Person 4**: Dashboard & Reports
- **Person 5**: Customers & Discounts

## 🆘 Support

For issues and questions:
1. Check the troubleshooting section
2. Review the GraphQL schema documentation
3. Contact your team lead (Person 1)

---

**Built with ❤️ by the MyShop Team**
