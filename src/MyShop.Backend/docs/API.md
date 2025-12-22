# MyShop GraphQL API Documentation

## 🚀 GraphQL Endpoint

```
POST http://localhost:4000/graphql
```

## 🔑 Authentication

Most queries and mutations require authentication. Include JWT token in headers:

```http
Authorization: Bearer YOUR_JWT_TOKEN
```

---

## 📚 Table of Contents

1. [Authentication](#authentication)
2. [Users](#users)
3. [Categories](#categories)
4. [Products](#products)
5. [Customers](#customers)
6. [Discounts](#discounts)
7. [Orders](#orders)
8. [Dashboard & Reports](#dashboard--reports)
9. [Error Handling](#error-handling)

---

## 🔐 Authentication

### Login

Get JWT token for authentication.

**Mutation:**
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
      isActive
      createdAt
    }
  }
}
```

**Response:**
```json
{
  "data": {
    "login": {
      "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
      "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
      "user": {
        "id": 1,
        "username": "admin",
        "email": "admin@myshop.com",
        "role": "ADMIN",
        "isActive": true,
        "createdAt": "2024-01-01T00:00:00.000Z"
      }
    }
  }
}
```

### Register

Create a new user account.

**Mutation:**
```graphql
mutation Register {
  register(input: {
    username: "newuser"
    email: "user@example.com"
    password: "Password@123"
    role: STAFF
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

### Get Current User

Get authenticated user information.

**Query:**
```graphql
query Me {
  me {
    id
    username
    email
    role
    isActive
    createdAt
    updatedAt
  }
}
```

**Headers Required:**
```http
Authorization: Bearer YOUR_TOKEN
```

### Refresh Token

Get new access token using refresh token.

**Mutation:**
```graphql
mutation RefreshToken {
  refreshToken(refreshToken: "YOUR_REFRESH_TOKEN") {
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

---

## 👥 Users

**Permissions:** ADMIN, MANAGER

### Get All Users

```graphql
query GetUsers {
  users(
    pagination: { page: 1, pageSize: 20 }
    sort: { field: "createdAt", order: DESC }
  ) {
    users {
      id
      username
      email
      role
      isActive
      createdAt
      updatedAt
    }
    total
    page
    pageSize
    totalPages
  }
}
```

### Get Single User

```graphql
query GetUser {
  user(id: 1) {
    id
    username
    email
    role
    isActive
    createdAt
    updatedAt
  }
}
```

### Create User

**Permission:** ADMIN only

```graphql
mutation CreateUser {
  createUser(input: {
    username: "newstaff"
    email: "staff@myshop.com"
    password: "Staff@123456"
    role: STAFF
  }) {
    id
    username
    email
    role
  }
}
```

### Update User

**Permission:** ADMIN only

```graphql
mutation UpdateUser {
  updateUser(
    id: 2
    input: {
      email: "newemail@myshop.com"
      isActive: true
    }
  ) {
    id
    username
    email
    isActive
  }
}
```

### Delete User

**Permission:** ADMIN only

```graphql
mutation DeleteUser {
  deleteUser(id: 2)
}
```

---

## 📁 Categories

### Get All Categories

```graphql
query GetCategories {
  categories(
    pagination: { page: 1, pageSize: 20 }
    sort: { field: "name", order: ASC }
  ) {
    categories {
      id
      name
      description
      isActive
      productCount
      createdAt
      updatedAt
    }
    total
    page
    pageSize
    totalPages
  }
}
```

### Get Active Categories

Get only active categories (for dropdowns).

```graphql
query GetActiveCategories {
  activeCategories {
    id
    name
    description
  }
}
```

### Get Single Category

```graphql
query GetCategory {
  category(id: 1) {
    id
    name
    description
    isActive
    productCount
    products {
      id
      name
      price
      stock
    }
    createdAt
    updatedAt
  }
}
```

### Create Category

**Permission:** ADMIN, MANAGER

```graphql
mutation CreateCategory {
  createCategory(input: {
    name: "Electronics"
    description: "Electronic devices and accessories"
  }) {
    id
    name
    description
    isActive
    productCount
  }
}
```

### Update Category

**Permission:** ADMIN, MANAGER

```graphql
mutation UpdateCategory {
  updateCategory(
    id: 1
    input: {
      name: "Updated Electronics"
      isActive: true
    }
  ) {
    id
    name
    description
    isActive
  }
}
```

### Delete Category

**Permission:** ADMIN only

```graphql
mutation DeleteCategory {
  deleteCategory(id: 1)
}
```

---

## 🛍️ Products

### Get All Products

```graphql
query GetProducts {
  products(
    pagination: { page: 1, pageSize: 20 }
    sort: { field: "name", order: ASC }
    filter: {
      name: "laptop"
      categoryId: 1
      minPrice: 100
      maxPrice: 1000
      inStock: true
      isActive: true
    }
  ) {
    products {
      id
      name
      description
      sku
      barcode
      price
      costPrice
      stock
      minStock
      imageUrl
      categoryId
      category {
        id
        name
      }
      isActive
      popularity
      createdAt
      updatedAt
    }
    total
    page
    pageSize
    totalPages
  }
}
```

### Get Single Product

```graphql
query GetProduct {
  product(id: 1) {
    id
    name
    description
    sku
    barcode
    price
    costPrice
    stock
    minStock
    imageUrl
    category {
      id
      name
    }
    isActive
    popularity
    createdAt
    updatedAt
  }
}
```

### Get Product by SKU

```graphql
query GetProductBySku {
  productBySku(sku: "ELEC-001") {
    id
    name
    price
    stock
  }
}
```

### Get Low Stock Products

```graphql
query GetLowStockProducts {
  lowStockProducts(threshold: 10) {
    id
    name
    sku
    stock
    minStock
    category {
      name
    }
  }
}
```

### Create Product

**Permission:** ADMIN, MANAGER

```graphql
mutation CreateProduct {
  createProduct(input: {
    name: "Laptop HP Pavilion"
    description: "High-performance laptop"
    sku: "ELEC-001"
    barcode: "1234567890123"
    price: 799.99
    costPrice: 650.00
    stock: 15
    minStock: 5
    imageUrl: "https://example.com/image.jpg"
    categoryId: 1
  }) {
    id
    name
    sku
    price
    stock
  }
}
```

### Update Product

**Permission:** ADMIN, MANAGER

```graphql
mutation UpdateProduct {
  updateProduct(
    id: 1
    input: {
      price: 749.99
      stock: 20
      isActive: true
    }
  ) {
    id
    name
    price
    stock
  }
}
```

### Update Product Stock

**Permission:** All authenticated users

```graphql
mutation UpdateProductStock {
  updateProductStock(
    id: 1
    quantity: 10  # Positive to add, negative to subtract
  ) {
    id
    name
    stock
  }
}
```

### Delete Product

**Permission:** ADMIN only

```graphql
mutation DeleteProduct {
  deleteProduct(id: 1)
}
```

---

## 👤 Customers

### Get All Customers

```graphql
query GetCustomers {
  customers(
    pagination: { page: 1, pageSize: 20 }
    sort: { field: "name", order: ASC }
    filter: {
      name: "John"
      email: "john@"
      phone: "123"
      isMember: true
    }
  ) {
    customers {
      id
      name
      email
      phone
      address
      isMember
      memberSince
      totalSpent
      orderCount
      notes
      createdAt
      updatedAt
    }
    total
    page
    pageSize
    totalPages
  }
}
```

### Get Single Customer

```graphql
query GetCustomer {
  customer(id: 1) {
    id
    name
    email
    phone
    address
    isMember
    memberSince
    totalSpent
    orderCount
    notes
    orders {
      id
      orderNumber
      total
      status
      createdAt
    }
    createdAt
    updatedAt
  }
}
```

### Create Customer

```graphql
mutation CreateCustomer {
  createCustomer(input: {
    name: "John Doe"
    email: "john@example.com"
    phone: "+1234567890"
    address: "123 Main St, City"
    isMember: true
    notes: "VIP customer"
  }) {
    id
    name
    email
    phone
    isMember
    memberSince
  }
}
```

### Update Customer

```graphql
mutation UpdateCustomer {
  updateCustomer(
    id: 1
    input: {
      email: "newemail@example.com"
      isMember: true
      notes: "Updated notes"
    }
  ) {
    id
    name
    email
    isMember
  }
}
```

### Delete Customer

**Permission:** ADMIN, MANAGER

```graphql
mutation DeleteCustomer {
  deleteCustomer(id: 1)
}
```

---

## 🎟️ Discounts

### Get All Discounts

```graphql
query GetDiscounts {
  discounts(
    pagination: { page: 1, pageSize: 20 }
    sort: { field: "createdAt", order: DESC }
  ) {
    discounts {
      id
      code
      name
      description
      type
      value
      minPurchase
      maxDiscount
      buyQuantity
      getQuantity
      isActive
      startDate
      endDate
      usageLimit
      usageCount
      applicableToAll
      memberOnly
      wholesaleMinQty
      createdAt
      updatedAt
    }
    total
    page
    pageSize
    totalPages
  }
}
```

### Get Active Discounts

```graphql
query GetActiveDiscounts {
  activeDiscounts {
    id
    code
    name
    type
    value
    minPurchase
    memberOnly
  }
}
```

### Get Discount by Code

```graphql
query GetDiscountByCode {
  discountByCode(code: "SAVE10") {
    id
    code
    name
    type
    value
    minPurchase
    maxDiscount
    isActive
  }
}
```

### Create Discount

**Permission:** ADMIN, MANAGER

```graphql
mutation CreateDiscount {
  createDiscount(input: {
    code: "SAVE10"
    name: "10% Off"
    description: "Get 10% off your purchase"
    type: PERCENTAGE
    value: 10
    minPurchase: 50
    maxDiscount: 100
    isActive: true
    startDate: "2024-01-01"
    endDate: "2024-12-31"
    usageLimit: 1000
    memberOnly: false
  }) {
    id
    code
    name
    type
    value
  }
}
```

**Discount Types:**
- `PERCENTAGE` - Percentage discount (value: 10 = 10%)
- `FIXED_AMOUNT` - Fixed amount off (value: 50 = $50 off)
- `BUY_X_GET_Y` - Buy X get Y free (requires buyQuantity & getQuantity)
- `MEMBER_DISCOUNT` - Member-only discount
- `WHOLESALE_DISCOUNT` - Wholesale discount (requires wholesaleMinQty)

### Update Discount

**Permission:** ADMIN, MANAGER

```graphql
mutation UpdateDiscount {
  updateDiscount(
    id: 1
    input: {
      value: 15
      isActive: true
    }
  ) {
    id
    code
    value
    isActive
  }
}
```

### Delete Discount

**Permission:** ADMIN only

```graphql
mutation DeleteDiscount {
  deleteDiscount(id: 1)
}
```

---

## 📦 Orders

### Get All Orders

```graphql
query GetOrders {
  orders(
    pagination: { page: 1, pageSize: 20 }
    sort: { field: "createdAt", order: DESC }
    filter: {
      status: PENDING
      customerId: 1
      dateRange: {
        from: "2024-01-01"
        to: "2024-12-31"
      }
    }
  ) {
    orders {
      id
      orderNumber
      customer {
        id
        name
        email
      }
      createdBy {
        id
        username
      }
      status
      subtotal
      discount {
        id
        code
        name
      }
      discountAmount
      taxAmount
      total
      notes
      orderItems {
        id
        product {
          id
          name
          sku
        }
        quantity
        unitPrice
        subtotal
        discountAmount
        total
      }
      createdAt
      updatedAt
      completedAt
    }
    total
    page
    pageSize
    totalPages
  }
}
```

**Order Statuses:**
- `PENDING` - Order placed, awaiting processing
- `PROCESSING` - Order is being processed
- `COMPLETED` - Order completed
- `CANCELLED` - Order cancelled

### Get Single Order

```graphql
query GetOrder {
  order(id: 1) {
    id
    orderNumber
    customer {
      id
      name
      email
      phone
    }
    createdBy {
      id
      username
    }
    status
    subtotal
    discountAmount
    taxAmount
    total
    notes
    orderItems {
      id
      product {
        id
        name
        sku
        price
      }
      quantity
      unitPrice
      total
    }
    createdAt
    completedAt
  }
}
```

### Get Order by Order Number

```graphql
query GetOrderByNumber {
  orderByNumber(orderNumber: "ORD-1234567890-123") {
    id
    orderNumber
    total
    status
  }
}
```

### Create Order

```graphql
mutation CreateOrder {
  createOrder(input: {
    customerId: 1
    items: [
      {
        productId: 1
        quantity: 2
        unitPrice: 799.99
      }
      {
        productId: 2
        quantity: 1
        unitPrice: 29.99
      }
    ]
    discountId: 1
    taxAmount: 50.00
    notes: "Rush delivery"
  }) {
    id
    orderNumber
    customer {
      name
    }
    subtotal
    discountAmount
    taxAmount
    total
    status
    orderItems {
      product {
        name
      }
      quantity
      total
    }
  }
}
```

**Order Creation Notes:**
- Product stock is automatically updated
- Customer totalSpent is automatically updated
- Discount usage count is automatically incremented
- Order number is auto-generated

### Update Order

```graphql
mutation UpdateOrder {
  updateOrder(
    id: 1
    input: {
      status: PROCESSING
      notes: "Updated notes"
    }
  ) {
    id
    orderNumber
    status
    notes
  }
}
```

### Cancel Order

```graphql
mutation CancelOrder {
  cancelOrder(id: 1) {
    id
    orderNumber
    status
  }
}
```

**Cancel Order Notes:**
- Product stock is restored
- Customer totalSpent is reduced
- Discount usage count is decremented
- Cannot cancel completed orders

---

## 📊 Dashboard & Reports

### Dashboard Stats

Get overall dashboard statistics.

```graphql
query GetDashboardStats {
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

**Response:**
```json
{
  "data": {
    "dashboardStats": {
      "totalProducts": 150,
      "totalOrders": 523,
      "totalRevenue": 125000.50,
      "totalCustomers": 87,
      "lowStockProducts": 12,
      "pendingOrders": 5,
      "todayRevenue": 2500.00,
      "todayOrders": 8
    }
  }
}
```

### Sales Report

Get detailed sales report for a date range.

```graphql
query GetSalesReport {
  salesReport(dateRange: {
    from: "2024-01-01"
    to: "2024-12-31"
  }) {
    totalRevenue
    totalOrders
    averageOrderValue
    topProducts {
      product {
        id
        name
        sku
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

**Response:**
```json
{
  "data": {
    "salesReport": {
      "totalRevenue": 125000.50,
      "totalOrders": 523,
      "averageOrderValue": 239.04,
      "topProducts": [
        {
          "product": {
            "id": 1,
            "name": "Laptop HP Pavilion",
            "sku": "ELEC-001"
          },
          "quantity": 45,
          "revenue": 35999.55
        }
      ],
      "revenueByDate": [
        {
          "date": "2024-01-01",
          "revenue": 2500.00,
          "orders": 10
        }
      ]
    }
  }
}
```

---

## ⚠️ Error Handling

### Error Response Format

```json
{
  "errors": [
    {
      "message": "Not authenticated",
      "extensions": {
        "code": "UNAUTHENTICATED"
      }
    }
  ]
}
```

### Common Error Codes

| Code | Description |
|------|-------------|
| `UNAUTHENTICATED` | User not logged in |
| `FORBIDDEN` | Insufficient permissions |
| `NOT_FOUND` | Resource not found |
| `BAD_USER_INPUT` | Invalid input data |
| `INTERNAL_SERVER_ERROR` | Server error |

### Example Error Responses

**Not Authenticated:**
```json
{
  "errors": [
    {
      "message": "Not authenticated",
      "extensions": { "code": "UNAUTHENTICATED" }
    }
  ]
}
```

**Forbidden:**
```json
{
  "errors": [
    {
      "message": "Insufficient permissions",
      "extensions": { "code": "FORBIDDEN" }
    }
  ]
}
```

**Not Found:**
```json
{
  "errors": [
    {
      "message": "Product not found",
      "extensions": { "code": "NOT_FOUND" }
    }
  ]
}
```

**Bad Input:**
```json
{
  "errors": [
    {
      "message": "Username already exists",
      "extensions": { "code": "BAD_USER_INPUT" }
    }
  ]
}
```

---

## 🔗 Additional Resources

- **GraphQL Playground**: http://localhost:4000/graphql
- **Health Check**: http://localhost:4000/health
- **Prisma Studio**: Run `pnpm prisma:studio`

---

**Generated with ❤️ by MyShop Team**
