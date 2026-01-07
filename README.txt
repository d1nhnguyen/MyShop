MYSHOP - E-COMMERCE MANAGEMENT SYSTEM
=====================================

A modern desktop application for managing products, orders, customers, and generating business reports. Built with a Modern Fullstack Architecture using WinUI 3 (Frontend) and Node.js (Express) + GraphQL (Backend).

Tech Stack: .NET 8.0 | Node.js 18+ | PostgreSQL 15

--------------------------------------------------------------------------------

DEMO
====

Youtube Demo: https://www.youtube.com/watch?v=ABGB2nRtMBY

(Note: Animated GIF demos for Onboarding, Dashboard, Products, Orders, Customers, Discounts, Staff, and Reports are available in the visual documentation).

--------------------------------------------------------------------------------

LINKS
=====

GitHub Repository: https://github.com/d1nhnguyen/myshop
Installer Download (Google Drive): https://drive.google.com/file/d/146SID45XBGZGhykwJo6Zmsa7cqIpNorx/view?usp=sharing

Note: The installer package includes both the frontend application and backend server with database setup.

--------------------------------------------------------------------------------

INSTALLATION GUIDE (For End Users)
===================================

If you downloaded the installer from Google Drive, follow these steps:

1. System Requirements
   - Windows 10 (64-bit) or higher
   - PostgreSQL 15.x or higher
   - 500MB free disk space
   - Administrator privileges

2. Install PostgreSQL (if not already installed)
   - Download from: https://www.postgresql.org/download/windows/
   - During installation, set password: admin (remember this!)
   - Keep default port: 5432

3. Run the Installer
   - Double-click MyShop_Setup_v1.0.exe
   - Follow the installation wizard
   - Choose installation directory (default: C:\Program Files\MyShop Management)

4. Setup Database
   - Open pgAdmin 4
   - Create database named: myshop
   - Import Database.sql file (located in installation folder)
   - Run the SQL script

5. Configure Connection
   - Navigate to installation folder\Backend_Deploy
   - Open .env file with Notepad
   - Verify DATABASE_URL matches your PostgreSQL password:
     DATABASE_URL="postgresql://postgres:admin@localhost:5432/myshop"
   - If your password is different, update it in the connection string

6. Launch Application
   - Find "MyShop Management" on Desktop or Start Menu
   - Double-click to run
   - Login with default accounts:
     * ADMIN: username: admin, password: Admin@123456
     * STAFF: username: staff1, password: Password@123

For detailed installation instructions, see tutorial.txt in the installation folder.

--------------------------------------------------------------------------------

TABLE OF CONTENTS
=================
1. Demo
2. Features
3. Architecture
4. Prerequisites
5. Getting Started
6. Project Structure
7. Advanced Features
8. Testing
9. Troubleshooting
10. Team Resources
11. License

--------------------------------------------------------------------------------

FEATURES
========

### Core Functionality
- Product Management: Add, edit, delete products and categories with real-time inventory tracking
- Order Processing: Create, manage, and track orders with automatic commission calculation
- Customer Management: Comprehensive customer database with membership tiers (Member, Standard)
- Dashboard & Analytics: Real-time business insights with interactive charts and reports
- User Authentication: Secure JWT-based authentication with role-based access control
- Print System: Generate professional PDF invoices and reports

### Advanced Features
- Auto-Save: Automatic draft saving when creating orders to prevent data loss.
- Discount System: Flexible promotion management including member-exclusive deals.
- Commission System: Automatic sales commission calculation based on order completion.
- Trial Mode: 15-day full-feature trial period logic with hardware binding.
- Printing System: Generate clean, print-ready HTML invoices and reports.
- Database Backup: Support for database backup via PostgreSQL tools.
- Onboarding System: Interactive first-time user guidance.

### Role-Based Access Control (RBAC)
Two distinct user roles with different permissions:

1. ADMIN - Full System Access
   - Complete control over products, categories, and pricing (including purchase prices)
   - Add, edit, delete staff accounts
   - Access all orders and customer data
   - View comprehensive reports: profit margins, revenue, and staff performance
   - Manage discount campaigns
   - Separate onboarding experience

2. STAFF - Sales Focus
   - View products and prices (excluding purchase prices)
   - Create and manage own orders only
   - View personal commission for each order
   - Access own performance metrics only
   - Cannot create discounts or access other staff's data
   - Simplified onboarding experience

--------------------------------------------------------------------------------

ARCHITECTURE
============

### Technology Stack
- Frontend: WinUI 3, MVVM Pattern, .NET 8.0, GraphQL Client
- Backend: Node.js, Express.js, Apollo Server, TypeScript
- Database: PostgreSQL 15 (Dockerized)
- ORM: Prisma (TypeScript-first ORM)
- Security: JWT Authentication, BCrypt Password Hashing, Role-Based Access Control

### Design Patterns
- MVVM (Model-View-ViewModel): Clear separation between UI and business logic
- Repository Pattern: Centralized data access with GraphQLRepositoryBase
- Dependency Injection: Loose coupling and testability
- Strategy Pattern: Flexible sorting and discount calculation
- Factory Pattern: Dynamic report generation (Daily, Weekly, Monthly, Yearly)
- Command Pattern: Order operations (Create, Update, Cancel)

--------------------------------------------------------------------------------

PREREQUISITES
=============

Install these before starting:

1. Visual Studio 2022 (Latest)
   - Purpose: Frontend development (with .NET Desktop & WinUI 3 workloads)
2. .NET SDK (8.0+)
   - Purpose: .NET application development
3. Node.js (18+)
   - Purpose: Backend development
4. npm (9+)
   - Purpose: Package management (comes with Node.js)
5. Docker Desktop (Latest)
   - Purpose: PostgreSQL database container
6. Git (Latest)
   - Purpose: Version control

Visual Studio Workloads Required:
- .NET Desktop Development
- Windows Application Development (with WinUI 3)
- Windows 10 SDK (10.0.19041.0 or higher)

--------------------------------------------------------------------------------

GETTING STARTED
===============

1. Clone the Repository
-----------------------
git clone https://github.com/d1nhnguyen/myshop.git
cd myshop

2. Backend & Database Setup
---------------------------
# Navigate to backend folder
cd src/MyShop.Backend

# Start PostgreSQL database via Docker
docker-compose up -d

# Install dependencies
npm install

# Generate Prisma Client
npx prisma generate

# Seed the database (REQUIRED for first-time setup)
npm run seed

# Start development server
npm run dev

** Backend will run on: http://localhost:4000
** GraphQL Playground: http://localhost:4000/graphql

3. Frontend Setup
-----------------
1. Open "src/MyShop.sln" in Visual Studio 2022
2. Right-click solution -> Restore NuGet Packages
3. Set "MyShop.App" as Startup Project (right-click -> Set as Startup Project)
4. Build the solution: Build -> Build Solution (or Ctrl+Shift+B)
5. Run the application: Press F5 or click Debug -> Start Debugging

4. First Login
--------------
Use one of the pre-seeded accounts:

- Username: admin
  Password: Admin@123456
  Role: ADMIN (Full system access)

- Username: staff1
  Password: Password@123
  Role: STAFF (Sales representative)

Note: If the backend is not running on localhost:4000, click the Config button on the login screen to set a custom server URL.

--------------------------------------------------------------------------------

PROJECT STRUCTURE
=================

myshop/
├── src/
│   ├── MyShop.App/               # WinUI 3 Frontend Application
│   │   ├── Assets/               # Images, fonts, and static resources
│   │   ├── Controls/             # Reusable custom UI controls
│   │   ├── Converters/           # Data binding converters
│   │   ├── Helpers/              # UI utility classes
│   │   ├── Models/               # View-specific models
│   │   ├── Services/             # Frontend services (auth, config, etc.)
│   │   ├── ViewModels/           # MVVM ViewModels
│   │   └── Views/                # XAML UI screens
│   │
│   ├── MyShop.Core/              # Business Logic Layer
│   │   ├── Helpers/              # Utility classes and extensions
│   │   ├── Interfaces/           # Service and repository contracts
│   │   ├── Models/               # Domain models and entities
│   │   ├── Services/             # Business logic services
│   │   └── Strategies/           # Strategy implementations
│   │
│   ├── MyShop.Data/              # Data Access Layer
│   │   └── Repositories/         # GraphQL repository implementations
│   │
│   ├── MyShop.Backend/           # Node.js + Express + GraphQL Backend
│   │   ├── prisma/               # Database schema and migrations
│   │   ├── src/                  # TypeScript source code
│   │   ├── uploads/              # File upload storage
│   │   ├── docker-compose.yml    # PostgreSQL container configuration
│   │   └── package.json          # Node.js dependencies
│   │
│   └── MyShop.Tests/             # Unit and Integration Tests
│
├── tools/                        # Build scripts and development utilities
├── docs/                         # Additional documentation
├── RBAC.md                       # Role-Based Access Control documentation
├── TrialSystem.md                # Trial mode implementation details
├── feature-development.md        # Development workflow guide
└── README.md                     # This file

--------------------------------------------------------------------------------

ADVANCED FEATURES DETAILS
=========================

1. Auto-Save System: 
   Automatic data persistence for order creation, product management, and customer updates.

2. Advanced Search & Filtering: 
   Multi-criteria search for Products (Name, SKU, Stock), Orders (ID, Date, Status), and Customers.

3. Discount System: 
   Percentage-based, Fixed amount, Member-exclusive, and Time-bound campaigns.

4. Commission System: 
   Real-time per-order commission calculation and KPI-based bonuses.

5. Trial Mode System: 
   15-day full-feature trial with hardware binding and activation key system.

6. Database Backup & Restore: 
   Manual and scheduled backups with one-click restore functionality.

7. Onboarding System: 
   Interactive tutorials specific to user roles.

8. Printing & Reporting: 
   Generate PDF/XPS invoices, sales reports, and inventory valuations.

--------------------------------------------------------------------------------

TESTING
=======

To ensure the application logic works correctly, run the unit tests included in the solution.

Running Tests:
1. dotnet clean
2. dotnet build
3. dotnet test

Test Coverage:
- Unit tests for business logic (Services, Commands, Strategies)
- Integration tests for GraphQL repositories
- UI component tests for ViewModels

--------------------------------------------------------------------------------

TROUBLESHOOTING
===============

1. Port 5432 (PostgreSQL) already in use
   - Check usage: netstat -ano | findstr :5432
   - Stop local PostgreSQL service or change port in docker-compose.yml to "5433:5432".

2. Backend "npm install" fails
   - Ensure Node.js v18+ is installed.
   - Run: npm cache clean --force
   - Delete node_modules and package-lock.json, then run npm install again.

3. WinUI "Windows SDK" missing
   - Open Visual Studio Installer -> Modify -> Individual Components.
   - Install "Windows 10 SDK (10.0.19041.0)".

4. Database connection errors
   - Check if Docker container is UP (docker-compose ps).
   - Check logs (docker-compose logs postgres).
   - Verify connection string in .env file.

5. Frontend can't connect to backend
   - Click Config button on login screen.
   - Verify server URL (default: http://localhost:4000).

--------------------------------------------------------------------------------

TEAM RESOURCES
==============
- RBAC Implementation: RBAC.md
- Trial System: TrialSystem.md

--------------------------------------------------------------------------------

DEVELOPER RESOURCES (INSTALLER & LICENSE KEY)
==============================================

For Developers and Administrators:

1. Creating Installer Package
   - Full guide: tools/installer/HUONG_DAN_TAO_INSTALLER.md
   - This guide covers how to create a standalone .exe installer using Inno Setup
   - The installer includes both frontend app and backend server
   - No need for users to install Node.js or other dependencies

2. Generating License Keys
   - Tool location: tools/KeyGen/
   - Run KeyGen.exe to generate activation keys for the trial system
   - Usage:
     a. Enter Machine ID (get from app's trial dialog)
     b. Enter Prefix (e.g., MYSH-OP25-PRO) or use default
     c. Copy the generated license key
   - The key is hardware-bound and works only on the specific machine

Quick Start for Installer Creation:
   1. Install Inno Setup from https://jrsoftware.org/isdl.php
   2. Open tools/installer/MyShop_Installer.iss
   3. Click Build -> Compile
   4. Output: Output/MyShop_Setup_v1.0.exe

Quick Start for Key Generation:
   1. Navigate to tools/KeyGen/KeyGen/bin/Debug/net8.0/
   2. Run KeyGen.exe
   3. Follow the prompts to generate keys

--------------------------------------------------------------------------------

LICENSE
=======
This project is licensed under the MIT License.

ACKNOWLEDGMENTS
===============
- Built with WinUI 3
- Powered by Apollo GraphQL
- Database by PostgreSQL
- ORM by Prisma