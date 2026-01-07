"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const client_1 = require("@prisma/client");
const auth_1 = require("./auth");
const env_1 = require("../config/env");
const prisma = new client_1.PrismaClient();
async function seedAdmin() {
    try {
        console.log('🌱 Starting admin seeding...\n');
        const adminData = {
            username: env_1.env.ADMIN_USERNAME,
            email: env_1.env.ADMIN_EMAIL,
            password: env_1.env.ADMIN_PASSWORD,
            role: 'ADMIN',
        };
        console.log('📋 Admin details:');
        console.log(`   Username: ${adminData.username}`);
        console.log(`   Email: ${adminData.email}`);
        console.log(`   Role: ${adminData.role}\n`);
        const existingAdmin = await prisma.user.findFirst({
            where: {
                OR: [
                    { username: adminData.username },
                    { email: adminData.email },
                ],
            },
        });
        if (existingAdmin) {
            console.log('⚠️  Admin user already exists!');
            console.log(`   ID: ${existingAdmin.id}`);
            console.log(`   Username: ${existingAdmin.username}`);
            console.log(`   Email: ${existingAdmin.email}`);
            console.log(`   Role: ${existingAdmin.role}\n`);
            console.log('💡 To update admin password, delete the existing user first or use a different username/email.\n');
            return;
        }
        console.log('🔐 Hashing password...');
        const hashedPassword = await auth_1.AuthUtils.hashPassword(adminData.password);
        console.log('👤 Creating admin user...');
        const admin = await prisma.user.create({
            data: {
                username: adminData.username,
                email: adminData.email,
                password: hashedPassword,
                role: adminData.role,
                isActive: true,
            },
        });
        console.log('\n✅ Admin user created successfully!\n');
        console.log('📝 Login credentials:');
        console.log(`   Username: ${admin.username}`);
        console.log(`   Email: ${admin.email}`);
        console.log(`   Password: ${adminData.password}`);
        console.log(`   Role: ${admin.role}`);
        console.log(`\n🔒 Please change the password after first login!\n`);
    }
    catch (error) {
        console.error('❌ Error seeding admin:', error);
        process.exit(1);
    }
    finally {
        await prisma.$disconnect();
    }
}
seedAdmin();
//# sourceMappingURL=seedAdmin.js.map