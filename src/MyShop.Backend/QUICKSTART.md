# 🚀 MyShop Backend - Quick Start

## Prerequisites

- Node.js >= 18
- pnpm
- Docker & Docker Compose

## Setup Commands

```bash
# 0. Install pnpm
npm install -g pnpm
pnpm -v

# 1. Start PostgreSQL
docker-compose up -d

# 2. Install dependencies
pnpm install

# 3. Generate Prisma Client
pnpm prisma:generate

# 4. Run database migrations
pnpm prisma:migrate

# 5. Seed admin user
pnpm seed:admin

# 6. (Optional) Seed sample data
pnpm seed

# 7. Start development server
pnpm dev
```

## Server Running

- **GraphQL API:** http://localhost:4000/graphql
- **Health Check:** http://localhost:4000/health
- **PgAdmin:** http://localhost:5050

## Default Credentials

### Admin User
- **Username:** `admin`
- **Email:** `admin@myshop.com`
- **Password:** `Admin@123456`

### PgAdmin
- **Email:** `admin@myshop.com`
- **Password:** `admin123!`

### Database
- **Host:** `localhost`
- **Port:** `5432`
- **Database:** `myshop`
- **Username:** `admin`
- **Password:** `admin123!`

## Test API with Postman

### 1. Login
```
POST http://localhost:4000/graphql
```

**Body (JSON):**
```json
{
  "query": "mutation { login(input: { username: \"admin\", password: \"Admin@123456\" }) { token user { id username role } } }"
}
```

### 2. Get Products (with Auth)
**Headers:**
```
Authorization: Bearer YOUR_TOKEN_HERE
```

**Body (JSON):**
```json
{
  "query": "query { products(pagination: { page: 1, pageSize: 10 }) { products { id name price stock } total } }"
}
```

## Useful Commands

```bash
# Prisma Studio (Database GUI)
pnpm prisma:studio

# Stop Docker containers
docker-compose down

# View logs
docker-compose logs -f postgres

# Rebuild dependencies
rm -rf node_modules && pnpm install

# Reset database (⚠️ Deletes all data)
pnpm prisma migrate reset
```

## Troubleshooting

### Port 5432 already in use
```bash
# Stop local PostgreSQL
brew services stop postgresql  # macOS
sudo systemctl stop postgresql  # Linux
```

### Database connection error
```bash
docker-compose restart postgres
```

### Prisma Client error
```bash
pnpm prisma:generate
```

## Documentation

- **API Documentation:** `docs/API.md`
- **Full README:** `README.md`
- **GraphQL Schema:** `src/graphql/typeDefs/index.ts`

---

**Ready to code! 🎉**
