# 📦 MyShop Database Setup - Tóm tắt cho Người dùng Cuối

## 🎯 Tình huống: Bạn đã giải nén file .exe và chạy được app

Nếu bạn đã:
- ✅ Giải nén file installer/output
- ✅ Chạy được ứng dụng MyShop
- ❌ Nhưng CHƯA có database

## 🚀 Giải pháp: 2 Cách Setup Database

### ⚡ CÁCH 1: TỰ ĐỘNG (Khuyến nghị - Dễ nhất!)

1. **Cài PostgreSQL** (nếu chưa có):
   - Tải từ: https://www.postgresql.org/download/windows/
   - Cài đặt với mật khẩu: `admin`
   - Port: `5432`

2. **Chạy script tự động**:
   ```
   Chuột phải vào: SETUP_DATABASE.bat
   → Chọn "Run as Administrator"
   → Làm theo hướng dẫn
   ```

3. **Hoàn tất!** 🎉

---

### 📖 CÁCH 2: THỦ CÔNG (Chi tiết hơn)

Xem file: `tutorial.txt` để được hướng dẫn từng bước chi tiết.

---

## 📁 Các File Quan Trọng

| File | Mô tả |
|------|-------|
| `SETUP_DATABASE.bat` | Script tự động setup database |
| `QUICK_START.txt` | Hướng dẫn nhanh |
| `tutorial.txt` | Hướng dẫn chi tiết đầy đủ |
| `Database.sql` | File dữ liệu database (152 products, 3 users) |
| `Backend_Deploy/.env` | File cấu hình kết nối |

---

## 🔑 Tài Khoản Đăng Nhập

Sau khi setup database xong, đăng nhập với:

### Admin (Toàn quyền)
- **Username**: `admin`
- **Password**: `Admin@123456`

### Manager (Quản lý)
- **Username**: `manager1`
- **Password**: `Password@123`

### Staff (Nhân viên)
- **Username**: `staff1`
- **Password**: `Password@123`

---

## 🎫 License Key

License key mẫu (dùng thử 15 ngày):
```
MYSHOP-TRIAL-0001
```

Hiệu lực đến: **15/01/2026**

---

## ❓ Xử Lý Sự Cố

### Lỗi: "Không kết nối được database"
✅ **Giải pháp**:
1. Kiểm tra PostgreSQL đã chạy chưa (Task Manager → tìm `postgres.exe`)
2. Kiểm tra mật khẩu trong file `Backend_Deploy/.env`
3. Chạy lại `SETUP_DATABASE.bat`

### Lỗi: "Backend không khởi động"
✅ **Giải pháp**:
1. Kiểm tra file `Backend_Deploy/backend-runtime.exe` có tồn tại
2. Kiểm tra file `Backend_Deploy/.env` có đúng cấu hình
3. Chạy app với quyền Administrator

### Lỗi: "Không tìm thấy PostgreSQL"
✅ **Giải pháp**:
1. Cài đặt PostgreSQL từ link trên
2. Chạy lại `SETUP_DATABASE.bat`

---

## 📊 Dữ Liệu Có Sẵn

Database đã được seed với:
- ✅ **152 products** (iPhone, iPad, Laptop, Tablet, PC, TV)
- ✅ **3 users** (admin, manager1, staff1)
- ✅ **22 customers**
- ✅ **100 orders** (dữ liệu mẫu)
- ✅ **6 categories**
- ✅ **5 discount codes**

---

## 🎯 Checklist Hoàn Thành

- [ ] PostgreSQL đã được cài đặt
- [ ] Chạy `SETUP_DATABASE.bat` thành công
- [ ] Thấy thông báo "CÀI ĐẶT THÀNH CÔNG! ✓"
- [ ] Mở được ứng dụng MyShop
- [ ] Đăng nhập thành công với tài khoản admin
- [ ] Kích hoạt license key

---

## 📞 Hỗ Trợ

Nếu vẫn gặp vấn đề:
1. Xem file `tutorial.txt` để được hướng dẫn chi tiết
2. Kiểm tra file log tại: `%LOCALAPPDATA%\MyShop\startup.log`
3. Liên hệ bộ phận hỗ trợ

---

**Chúc bạn sử dụng MyShop Management hiệu quả! 🎉**
