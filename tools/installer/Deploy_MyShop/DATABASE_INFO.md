# 📊 Thông Tin Database MyShop

## 🗄️ Tổng quan

File `Database.sql` chứa cấu trúc database hoàn chỉnh cho hệ thống MyShop Management, bao gồm:

- **11 bảng chính** với đầy đủ quan hệ (Foreign Keys)
- **Dữ liệu mẫu** cho sản phẩm, đơn hàng, khách hàng
- **Indexes** để tối ưu hiệu suất truy vấn
- **Enums** cho các trạng thái (OrderStatus, UserRole, DiscountType)

---

## 📋 Cấu trúc bảng

### 1. **users** - Quản lý người dùng
```sql
- id: integer (Primary Key)
- username: varchar(50) UNIQUE
- email: varchar(100) UNIQUE
- password: varchar(255) (BCrypt hashed)
- role: UserRole (ADMIN, MANAGER, STAFF)
- isActive: boolean
- createdAt, updatedAt: timestamp
```

### 2. **products** - Sản phẩm
```sql
- id, name, description, sku, barcode
- price, costPrice, stock, minStock
- categoryId (FK → categories)
- isActive, popularity
```

### 3. **categories** - Danh mục sản phẩm
```sql
- id, name, description
- isActive
```

### 4. **product_images** - Hình ảnh sản phẩm
```sql
- id, productId (FK → products)
- imageUrl, displayOrder
- isMain (ảnh chính)
```

### 5. **orders** - Đơn hàng
```sql
- id, orderNumber
- customerId (FK → customers)
- userId (FK → users)
- status: OrderStatus (PENDING, PROCESSING, COMPLETED, CANCELLED)
- subtotal, discountAmount, taxAmount, total
```

### 6. **order_items** - Chi tiết đơn hàng
```sql
- id, orderId (FK → orders)
- productId (FK → products)
- quantity, unitPrice, subtotal, total
```

### 7. **customers** - Khách hàng
```sql
- id, name, email, phone, address
- isMember, memberSince
- totalSpent
```

### 8. **discounts** - Mã giảm giá
```sql
- id, code, name, description
- type: DiscountType (PERCENTAGE, FIXED_AMOUNT, BUY_X_GET_Y, ...)
- value, minPurchase, maxDiscount
- startDate, endDate
- usageLimit, usageCount
```

### 9. **commissions** - Hoa hồng nhân viên
```sql
- id, userId (FK → users)
- orderId (FK → orders)
- orderTotal, commissionRate, commissionAmount
- isPaid, paidAt
```

### 10. **sales_targets** - Chỉ tiêu doanh số
```sql
- id, userId (FK → users)
- month, year
- targetAmount, achievedAmount
- commissionRate
```

### 11. **app_licenses** - Quản lý license
```sql
- id, licenseKey
- deviceId, activatedAt, expiresAt
- isActive
```

---

## ✅ **RESOLVED: User Data Added Successfully**

### 🟢 Current Status
User data has been successfully added to `Database.sql`. The file now includes:

**3 Users with different roles:**
1. **Admin User**
   - Username: `admin`
   - Email: `admin@myshop.com`
   - Password: `Admin@123456`
   - Role: ADMIN

2. **Manager User**
   - Username: `manager1`
   - Email: `manager@myshop.com`
   - Password: `Password@123`
   - Role: MANAGER

3. **Staff User**
   - Username: `staff1`
   - Email: `staff1@myshop.com`
   - Password: `Password@123`
   - Role: STAFF

### 🔐 Password Information
All passwords are hashed using BCrypt with the hash:
```
$2a$10$rN7VcQ5TTR7/mIqwCpKU5OQVQr7T1QpOB3qzV6kIHnLLfi1yLRwXK
```

This hash corresponds to:
- `Admin@123456` for admin user
- `Password@123` for manager and staff users

---

## 📊 Dữ liệu mẫu có sẵn

File Database.sql đã bao gồm:

✅ **3 Users** (admin, manager1, staff1) với các role khác nhau
✅ **6 Categories** (iPhone, iPad, Laptop, Tablet, PC, TV)
✅ **100+ Products** với hình ảnh
✅ **150+ Orders** (từ 2024-2025)
✅ **50+ Customers**
✅ **30+ Commissions**
✅ **1 License** (MYSHOP-TRIAL-0001, hết hạn 15/01/2026)

---

## 🔧 Cách kiểm tra sau khi import

Chạy các query sau trong pgAdmin để kiểm tra:

```sql
-- Kiểm tra số lượng bản ghi
SELECT 'users' as table_name, COUNT(*) FROM users
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'categories', COUNT(*) FROM categories
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'customers', COUNT(*) FROM customers;

-- Kiểm tra user admin
SELECT * FROM users WHERE role = 'ADMIN';

-- Kiểm tra license
SELECT * FROM app_licenses WHERE "isActive" = true;
```

**Kết quả mong đợi:**
- users: **3** (nếu đã thêm)
- products: **~100+**
- categories: **6**
- orders: **~150+**
- customers: **~50+**

---

## 🚨 Lưu ý quan trọng

1. **Owner = admin**: Database được tạo với owner là `admin`. Nếu PostgreSQL của bạn dùng user `postgres`, cần sửa lại:
   ```sql
   ALTER SCHEMA public OWNER TO postgres;
   ```

2. **Password hash**: Password trong database đã được hash bằng BCrypt. Không thể đổi password trực tiếp, phải hash lại.

3. **License key**: License mẫu `MYSHOP-TRIAL-0001` hết hạn 15/01/2026. Cần tạo license mới nếu qua ngày này.

4. **Restore lỗi**: Nếu gặp lỗi khi import, thử:
   - Tạo database trống trước: `CREATE DATABASE myshop;`
   - Chạy file SQL: `psql -U postgres -d myshop -f Database.sql`

---

## 📝 Checklist sau khi import

- [ ] Database `myshop` đã được tạo
- [ ] File `Database.sql` đã import thành công
- [ ] Có ít nhất 1 user với role ADMIN
- [ ] Có dữ liệu categories (6 items)
- [ ] Có dữ liệu products (100+ items)
- [ ] Có license key hợp lệ
- [ ] Connection string trong `.env` đã đúng

---

## 🔗 Liên kết

- [tutorial.txt](./tutorial.txt) - Hướng dẫn cài đặt cho người dùng cuối
- [Database.sql](./Database.sql) - File SQL dump
