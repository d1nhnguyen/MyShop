import { PrismaClient, Prisma } from '@prisma/client';
import { AuthUtils } from './auth';

const prisma = new PrismaClient();

async function seed() {
  try {
    console.log('Starting database seeding...\n');

    console.log('Seeding users...');
    const hashedPassword = await AuthUtils.hashPassword('Password@123');

    const users = await Promise.all([
      prisma.user.upsert({
        where: { username: 'admin' },
        update: {},
        create: {
          username: 'admin',
          email: 'admin@myshop.com',
          password: await AuthUtils.hashPassword('Admin@123456'),
          role: 'ADMIN',
        },
      }),
      prisma.user.upsert({
        where: { username: 'manager1' },
        update: {},
        create: {
          username: 'manager1',
          email: 'manager@myshop.com',
          password: hashedPassword,
          role: 'MANAGER',
        },
      }),
      prisma.user.upsert({
        where: { username: 'staff1' },
        update: {},
        create: {
          username: 'staff1',
          email: 'staff1@myshop.com',
          password: hashedPassword,
          role: 'STAFF',
        },
      }),
    ]);
    console.log(`Created ${users.length} users\n`);

    console.log('Seeding categories...');
    const categories = await Promise.all([
      prisma.category.upsert({
        where: { name: 'iPhone' },
        update: {},
        create: { name: 'iPhone', description: 'Apple Smartphones' },
      }),
      prisma.category.upsert({
        where: { name: 'iPad' },
        update: {},
        create: { name: 'iPad', description: 'Apple Tablets' },
      }),
      prisma.category.upsert({
        where: { name: 'Laptop' },
        update: {},
        create: { name: 'Laptop', description: 'Portable computers' },
      }),
      prisma.category.upsert({
        where: { name: 'Tablet' },
        update: {},
        create: { name: 'Tablet', description: 'Android and other tablets' },
      }),
      prisma.category.upsert({
        where: { name: 'PC' },
        update: {},
        create: { name: 'PC', description: 'Desktop computers' },
      }),
      prisma.category.upsert({
        where: { name: 'TV' },
        update: {},
        create: { name: 'TV', description: 'Smart Televisions' },
      }),
    ]);
    console.log(`Created ${categories.length} categories\n`);

    console.log('Seeding products...');
    const productData = [
      {
        name: 'iPhone 15 Pro',
        sku: 'IPH-15P',
        barcode: '194253701234',
        price: new Prisma.Decimal(999.00),
        costPrice: new Prisma.Decimal(750),
        stock: 25,
        minStock: 5,
        categoryId: categories[0].id,
        description: 'Titanium design, A17 Pro chip',
      },
      {
        name: 'iPad Pro M2',
        sku: 'IPD-M2',
        barcode: '194253705678',
        price: new Prisma.Decimal(799.00),
        costPrice: new Prisma.Decimal(600),
        stock: 15,
        minStock: 3,
        categoryId: categories[1].id,
        description: '11-inch Liquid Retina display',
      },
      {
        name: 'MacBook Air M3',
        sku: 'MAC-M3',
        barcode: '194253709012',
        price: new Prisma.Decimal(1099.00),
        costPrice: new Prisma.Decimal(850),
        stock: 10,
        minStock: 2,
        categoryId: categories[2].id,
        description: 'Midnight, 13-inch display',
      },
      {
        name: 'Samsung 4K Smart TV',
        sku: 'SAM-4K',
        barcode: '880609012345',
        price: new Prisma.Decimal(549.99),
        costPrice: new Prisma.Decimal(400),
        stock: 8,
        minStock: 2,
        categoryId: categories[5].id,
        description: '55-inch Crystal UHD 4K',
      }
    ];

    const products = [];
    for (const product of productData) {
      const created = await prisma.product.upsert({
        where: { sku: product.sku },
        update: {},
        create: product,
      });
      products.push(created);
    }
    console.log(`Created ${products.length} products\n`);

    console.log('Seeding customers...');
    const customers = await Promise.all([
      prisma.customer.upsert({
        where: { email: 'customer1@example.com' },
        update: {},
        create: {
          name: 'Nguyen Van A',
          email: 'customer1@example.com',
          phone: '0901234567',
          address: 'District 1, HCM City',
          isMember: true,
          memberSince: new Date('2024-01-01'),
        },
      }),
    ]);
    console.log(`Created ${customers.length} customers\n`);

    console.log('Seeding discounts...');
    await prisma.discount.upsert({
      where: { code: 'NEWYEAR' },
      update: {},
      create: {
        code: 'NEWYEAR',
        name: 'New Year Sale',
        description: '10% discount on all items',
        type: 'PERCENTAGE',
        value: new Prisma.Decimal(10),
        applicableToAll: true,
      },
    });
    console.log(`Created discounts\n`);

    console.log('Seeding license keys...');
    await prisma.appLicense.upsert({
      where: { licenseKey: 'MYSHOP-TRIAL-0001' },
      update: {},
      create: {
        licenseKey: 'MYSHOP-TRIAL-0001',
        activatedAt: new Date(),
        expiresAt: new Date(new Date().getTime() + 15 * 24 * 60 * 60 * 1000),
        isActive: true,
      },
    });

    console.log('Database seeding completed successfully!');
  } catch (error) {
    console.error('Error seeding database:', error);
    process.exit(1);
  } finally {
    await prisma.$disconnect();
  }
}

seed();