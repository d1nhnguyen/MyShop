# 📦 Hướng Dẫn Tạo Bộ Cài MyShop

## 🎯 Mục tiêu
Tạo file installer `.exe` để người dùng cuối có thể cài đặt MyShop bằng 1 click, không cần cài Node.js hay các dependency khác.

---

## 📋 Yêu cầu trước khi bắt đầu

### 1. Cài đặt Inno Setup
- Tải về từ: https://jrsoftware.org/isdl.php
- Chọn phiên bản **Inno Setup 6.x** (Unicode)
- Cài đặt với cấu hình mặc định

### 2. Chuẩn bị thư mục Deploy_MyShop
Đảm bảo thư mục `Deploy_MyShop` có cấu trúc như sau:

```
Deploy_MyShop/
├── publish/                    # Frontend đã build (Release)
│   ├── MyShop.App.exe
│   ├── *.dll
│   └── ... (tất cả file từ publish folder)
│
├── Backend_Deploy/             # Backend portable
│   ├── backend-runtime.exe
│   ├── dist/
│   │   └── index.js
│   ├── node_modules/
│   ├── prisma/
│   └── .env
│
├── Database.sql                # File SQL để tạo database
└── tutorial.txt               # Hướng dẫn cho người dùng
```

---

## 🔧 Các bước tạo Installer

### Bước 1: Kiểm tra cấu trúc thư mục

Mở PowerShell và chạy:

```powershell
# Di chuyển vào thư mục project
cd "d:\Study\C#\MyShop"

# Kiểm tra các file cần thiết
Test-Path ".\Deploy_MyShop\publish\MyShop.App.exe"
Test-Path ".\Deploy_MyShop\Backend_Deploy\backend-runtime.exe"
Test-Path ".\Deploy_MyShop\Database.sql"
```

**Kết quả mong đợi:** Tất cả đều trả về `True`

### Bước 2: Mở Inno Setup Compiler

1. Mở **Inno Setup Compiler**
2. File → Open → Chọn file `MyShop_Installer.iss` trong thư mục project
3. Kiểm tra các đường dẫn trong script:

```ini
[Files]
; Frontend
Source: ".\Deploy_MyShop\publish\*"; DestDir: "{app}";

; Backend
Source: ".\Deploy_MyShop\Backend_Deploy\*"; DestDir: "{app}\Backend_Deploy";

; Database & Tutorial
Source: ".\Deploy_MyShop\Database.sql"; DestDir: "{app}";
Source: ".\Deploy_MyShop\tutorial.txt"; DestDir: "{app}";
```

### Bước 3: Compile Installer

1. Trong Inno Setup Compiler, nhấn **Build → Compile** (hoặc `Ctrl+F9`)
2. Chờ quá trình compile hoàn tất (khoảng 1-2 phút)
3. Kết quả sẽ được lưu tại: `.\Output\MyShop_Setup_v1.0.exe`

### Bước 4: Test Installer

1. Copy file `MyShop_Setup_v1.0.exe` sang máy khác (hoặc máy ảo)
2. Chạy installer
3. Làm theo hướng dẫn cài đặt
4. Kiểm tra:
   - ✅ App có chạy được không
   - ✅ Backend có tự động khởi động không (kiểm tra Task Manager)
   - ✅ Kết nối database có hoạt động không

---

## 🎨 Tùy chỉnh Installer (Nâng cao)

### Thay đổi Icon

Thêm icon tùy chỉnh cho installer:

```ini
[Setup]
SetupIconFile=.\path\to\your\icon.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
```

### Thêm License Agreement

```ini
[Setup]
LicenseFile=.\LICENSE.txt
```

### Thêm thông báo sau khi cài đặt

```ini
[Run]
Filename: "{app}\tutorial.txt"; Description: "Xem hướng dẫn"; Flags: postinstall shellexec skipifsilent
```

---

## ⚠️ Lưu ý quan trọng

### 1. Đường dẫn tương đối
- Script Inno Setup sử dụng đường dẫn **tương đối** từ vị trí file `.iss`
- Đảm bảo file `MyShop_Installer.iss` nằm ở thư mục gốc project (`d:\Study\C#\MyShop`)

### 2. Backend_Deploy phải đúng tên
- Code C# tìm kiếm thư mục `Backend_Deploy` (chính xác tên này)
- Nếu đổi tên, phải sửa lại trong `App.xaml.cs`:

```csharp
string backendDir = Path.Combine(appDir, "Backend_Deploy");
```

### 3. File .env trong Backend
- Đảm bảo file `.env` có cấu hình đúng cho production:

```env
DATABASE_URL="postgresql://user:password@localhost:5432/myshop"
JWT_SECRET="your-secret-key"
PORT=4000
```

### 4. Database phải được cài đặt trước
- Installer **KHÔNG** tự động cài PostgreSQL
- Người dùng phải:
  1. Cài PostgreSQL
  2. Chạy file `Database.sql`
  3. Cấu hình connection string trong `.env`

---

## 🐛 Troubleshooting

### Lỗi: "Cannot find file"
**Nguyên nhân:** Đường dẫn trong script không đúng

**Giải pháp:**
```powershell
# Kiểm tra đường dẫn tuyệt đối
Get-ChildItem ".\Deploy_MyShop\publish" -Recurse | Select-Object FullName
```

### Lỗi: Backend không chạy sau khi cài
**Nguyên nhân:** Thiếu file hoặc cấu hình sai

**Giải pháp:**
1. Kiểm tra thư mục cài đặt: `C:\Program Files\MyShop Management\Backend_Deploy`
2. Kiểm tra file `.env` có tồn tại không
3. Chạy thử `backend-runtime.exe` thủ công để xem lỗi

### Lỗi: App crash khi mở
**Nguyên nhân:** Thiếu DLL hoặc runtime

**Giải pháp:**
- Đảm bảo publish với cấu hình **Self-contained**
- Kiểm tra tất cả file DLL đã được copy vào thư mục publish

---

## 📊 Checklist trước khi nộp bài

- [ ] File `MyShop_Setup_v1.0.exe` đã được tạo thành công
- [ ] Test installer trên máy sạch (không có Visual Studio)
- [ ] App chạy được sau khi cài đặt
- [ ] Backend tự động khởi động khi mở app
- [ ] Backend tự động tắt khi đóng app
- [ ] File `Database.sql` và `tutorial.txt` có trong thư mục cài đặt
- [ ] Icon và thông tin app hiển thị đúng trong Control Panel

---

## 🚀 Nộp bài

Khi nộp bài, cung cấp:
1. File `MyShop_Setup_v1.0.exe`
2. File `Database.sql`
3. File `HUONG_DAN_CAI_DAT.md` (hướng dẫn cho giám khảo)
4. Source code (nếu yêu cầu)

**Lưu ý:** File installer thường có dung lượng lớn (200-500MB) do chứa .NET Runtime và tất cả dependencies.
