# 📦 MyShop Installer

Thư mục này chứa tất cả các file cần thiết để tạo bộ cài đặt MyShop.

## 📁 Cấu trúc thư mục

```
tools/installer/
├── MyShop_Installer.iss          # Script Inno Setup
├── HUONG_DAN_TAO_INSTALLER.md    # Hướng dẫn chi tiết
├── Deploy_MyShop/                # Thư mục chứa file để đóng gói
│   ├── publish/                  # Frontend (MyShop.App.exe + DLLs)
│   ├── Backend_Deploy/           # Backend portable
│   ├── Database.sql              # File SQL dump
│   ├── tutorial.txt              # Hướng dẫn cho người dùng cuối
│   └── DATABASE_INFO.md          # Thông tin chi tiết về database
└── Output/                       # Thư mục chứa file installer sau khi build
    └── MyShop_Setup_v1.0.exe     # File installer (sau khi compile)
```

## 🚀 Cách sử dụng

### Bước 1: Chuẩn bị file

Đảm bảo thư mục `Deploy_MyShop` có đầy đủ:
- `publish/` - Frontend đã build (Release)
- `Backend_Deploy/` - Backend portable với backend-runtime.exe
- `Database.sql` - File SQL dump
- `tutorial.txt` - Hướng dẫn người dùng

### Bước 2: Compile Installer

1. Mở **Inno Setup Compiler**
2. File → Open → Chọn `MyShop_Installer.iss`
3. Build → Compile (hoặc Ctrl+F9)
4. File installer sẽ được tạo tại: `Output/MyShop_Setup_v1.0.exe`

### Bước 3: Test

1. Copy file `MyShop_Setup_v1.0.exe` sang máy khác
2. Chạy installer
3. Kiểm tra app có hoạt động đúng không

## 📚 Tài liệu

- **[HUONG_DAN_TAO_INSTALLER.md](./HUONG_DAN_TAO_INSTALLER.md)** - Hướng dẫn chi tiết từng bước
- **[Deploy_MyShop/DATABASE_INFO.md](./Deploy_MyShop/DATABASE_INFO.md)** - Thông tin về database
- **[Deploy_MyShop/tutorial.txt](./Deploy_MyShop/tutorial.txt)** - Hướng dẫn cho người dùng cuối

## ⚙️ Cấu hình

File `MyShop_Installer.iss` sử dụng đường dẫn tương đối:
- Frontend: `.\Deploy_MyShop\publish\*`
- Backend: `.\Deploy_MyShop\Backend_Deploy\*`
- Database: `.\Deploy_MyShop\Database.sql`
- Tutorial: `.\Deploy_MyShop\tutorial.txt`

**Lưu ý:** Tất cả đường dẫn đều tương đối từ vị trí file `.iss`

## 🔧 Yêu cầu

- **Inno Setup 6.x** - [Download](https://jrsoftware.org/isdl.php)
- **Deploy_MyShop** đã được chuẩn bị đầy đủ
- **PostgreSQL** (cho người dùng cuối)

## 📝 Checklist trước khi build

- [ ] Frontend đã build ở chế độ Release
- [ ] Backend_Deploy có đầy đủ file (backend-runtime.exe, dist/, node_modules/, .env)
- [ ] Database.sql có dữ liệu users (admin, manager1, staff1)
- [ ] tutorial.txt có thông tin đăng nhập chính xác
- [ ] File .iss có đường dẫn đúng

## 🎯 Kết quả

Sau khi compile thành công, bạn sẽ có:
- File installer: `Output/MyShop_Setup_v1.0.exe` (~200-500MB)
- Người dùng chỉ cần chạy file này để cài đặt MyShop
- Tất cả dependencies đã được đóng gói sẵn (trừ PostgreSQL)
