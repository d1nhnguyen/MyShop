# 🚀 MyShop Backend - Quick Setup Guide

## Prerequisites

- Node.js >= 18.x
- pnpm >= 8.x
- Docker & Docker Compose

## Step-by-Step Setup

### 1️⃣ Start PostgreSQL Database

```bash
# Start PostgreSQL and PgAdmin
docker-compose up -d

# Check if containers are running
docker-compose ps

# View logs
docker-compose logs -f postgres
```

**Database Details:**
- **Host:** localhost
- **Port:** 5432
- **Database:** myshop
- **Username:** admin
- **Password:** admin123!

**PgAdmin (Optional Database UI):**
- **URL:** http://localhost:5050
- **Email:** admin@myshop.com
- **Password:** admin123!

### 2️⃣ Install Dependencies

```bash
pnpm install
```

### 3️⃣ Setup Environment

The `.env` file is already configured with the correct database connection:

```env
DATABASE_URL="postgresql://admin:admin123!@localhost:5432/myshop?schema=public"
PORT=4000
NODE_ENV=development
JWT_SECRET=myshop-super-secret-jwt-key-2024-change-in-production
```

### 4️⃣ Initialize Database

```bash
# Generate Prisma client
pnpm prisma:generate

# Run database migrations
pnpm prisma:migrate

# You should see output like:
# ✔ Generated Prisma Client
# ✔ Database migration successful
```

### 5️⃣ Seed Database

**Create Admin User:**
```bash
pnpm seed:admin
```

You'll see:
```
🌱 Starting admin seeding...
✅ Admin user created successfully!

📝 Login credentials:
   Username: admin
   Email: admin@myshop.com
   Password: Admin@123456
   Role: ADMIN
```

**Optional - Seed Sample Data:**
```bash
pnpm seed
```

This creates:
- 3 users (admin, manager, staff)
- 5 categories
- 5 sample products
- 2 customers
- 2 discount codes

### 6️⃣ Start Development Server

```bash
pnpm dev
```

You should see:
```
🚀 Server is running!

   Environment: development
   Port: 4000
   GraphQL endpoint: http://localhost:4000/graphql
   Health check: http://localhost:4000/health
   Home page: http://localhost:4000/

📊 Ready to accept requests!
```

### 7️⃣ Test the API

**Open GraphQL Playground:**
```
http://localhost:4000/graphql
```

**Test Login:**
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

**Copy the token and add to HTTP Headers:**
```json
{
  "Authorization": "Bearer YOUR_TOKEN_HERE"
}
```

**Test Query:**
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

## 🛠️ Useful Commands

### Database Management

```bash
# Open Prisma Studio (Database GUI)
pnpm prisma:studio

# Reset database (WARNING: Deletes all data)
pnpm prisma migrate reset

# Create a new migration
pnpm prisma migrate dev --name your_migration_name
```

### Docker Commands

```bash
# Stop containers
docker-compose down

# Stop and remove volumes (deletes database data)
docker-compose down -v

# View container logs
docker-compose logs -f postgres

# Restart containers
docker-compose restart
```

### Development

```bash
# Run with hot reload
pnpm dev

# Build for production
pnpm build

# Run production build
pnpm start

# Lint code
pnpm lint

# Format code
pnpm format
```

## 🔍 Troubleshooting

### Port 5432 Already in Use

If you have another PostgreSQL instance running:

**Option 1:** Stop your local PostgreSQL
```bash
# macOS
brew services stop postgresql

# Linux
sudo systemctl stop postgresql
```

**Option 2:** Change the port in `docker-compose.yml`
```yaml
ports:
  - "5433:5432"  # Use 5433 instead
```

Then update `DATABASE_URL` in `.env`:
```env
DATABASE_URL="postgresql://admin:admin123!@localhost:5433/myshop?schema=public"
```

### Port 4000 Already in Use

Change `PORT` in `.env`:
```env
PORT=5000
```

### Database Connection Error

```bash
# Check if PostgreSQL is running
docker-compose ps

# Check PostgreSQL logs
docker-compose logs postgres

# Restart PostgreSQL
docker-compose restart postgres
```

### Prisma Client Not Generated

```bash
pnpm prisma:generate
```

## 📊 Database Access

### Using PgAdmin (Web UI)

1. Open http://localhost:5050
2. Login with:
   - Email: admin@myshop.com
   - Password: admin123!
3. Add server:
   - Name: MyShop
   - Host: postgres (or host.docker.internal on Mac/Windows)
   - Port: 5432
   - Database: myshop
   - Username: admin
   - Password: admin123!

### Using Prisma Studio

```bash
pnpm prisma:studio
```

Opens at http://localhost:5555

### Using psql

```bash
docker-compose exec postgres psql -U admin -d myshop
```

## 🎯 Next Steps

1. ✅ Database is running
2. ✅ Backend server is running
3. ✅ Admin user created
4. ✅ GraphQL API is accessible

**Now you can:**
- Connect your frontend application
- Test API endpoints
- Develop new features
- View data in Prisma Studio or PgAdmin

## 📚 Additional Resources

- [Prisma Documentation](https://www.prisma.io/docs)
- [GraphQL Documentation](https://graphql.org/learn/)
- [Apollo Server Documentation](https://www.apollographql.com/docs/apollo-server/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

---

**Happy Coding! 🎉**
