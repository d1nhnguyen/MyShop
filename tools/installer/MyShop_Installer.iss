; ========================================
; Script tạo bộ cài cho MyShop
; ========================================
#define MyAppName "MyShop Management"
#define MyAppVersion "1.0"
#define MyAppPublisher "Sinh Vien IT"
#define MyAppExeName "MyShop.App.exe"

[Setup]
AppId={{A1B2C3D4-E5F6-7890-ABCD-1234567890AB}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
OutputDir=.\Output
OutputBaseFilename=MyShop_Setup_v1.0
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin
;SetupIconFile=.\Deploy_MyShop\publish\WindowsAppRuntime.png
UninstallDisplayIcon={app}\{#MyAppExeName}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; 1. COPY FRONTEND: Lấy tất cả trong folder publish (Frontend đã build), ném thẳng vào thư mục cài đặt {app}
Source: ".\Deploy_MyShop\publish\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

; 2. COPY BACKEND: Lấy folder Backend_Deploy, ném vào thư mục con {app}\Backend_Deploy
; 👉 QUAN TRỌNG: DestDir phải có thêm \Backend_Deploy để khớp với code C#
Source: ".\Deploy_MyShop\Backend_Deploy\*"; DestDir: "{app}\Backend_Deploy"; Flags: ignoreversion recursesubdirs createallsubdirs

; 3. COPY FILE DATABASE & HƯỚNG DẪN
Source: ".\Deploy_MyShop\Database.sql"; DestDir: "{app}"; Flags: ignoreversion
Source: ".\Deploy_MyShop\tutorial.txt"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
; Mở file hướng dẫn cài DB ngay sau khi cài xong
Filename: "{app}\tutorial.txt"; Description: "Xem hướng dẫn cài đặt Database"; Flags: postinstall shellexec skipifsilent
; Chạy App
Filename: "{app}\{#MyAppExeName}"; Description: "Chạy ứng dụng MyShop"; Flags: nowait postinstall skipifsilent

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    // Có thể thêm logic tự động cài đặt database ở đây nếu cần
  end;
end;
