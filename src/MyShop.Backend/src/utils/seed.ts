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
      prisma.customer.upsert({
        where: { email: 'customer2@example.com' },
        update: {},
        create: {
          name: 'Tran Thi B',
          email: 'customer2@example.com',
          phone: '0902345678',
          address: 'District 3, HCM City',
          isMember: false,
        },
      }),
      prisma.customer.upsert({
        where: { email: 'customer3@example.com' },
        update: {},
        create: {
          name: 'Le Van C',
          email: 'customer3@example.com',
          phone: '0903456789',
          address: 'District 7, HCM City',
          isMember: true,
          memberSince: new Date('2024-06-15'),
        },
      }),
    ]);
    console.log(`Created ${customers.length} customers\n`);

    console.log('Seeding discounts...');
    const discount = await prisma.discount.upsert({
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

    console.log('Seeding orders...');
    const orderData = [
      {
        orderNumber: 'ORD-2024-001',
        customerId: customers[0].id,
        userId: users[2].id, // staff1
        status: 'COMPLETED' as const,
        items: [
          { productId: products[0].id, quantity: 1, unitPrice: products[0].price },
          { productId: products[1].id, quantity: 1, unitPrice: products[1].price },
        ],
        discountId: discount.id,
        createdAt: new Date('2024-12-01T10:00:00Z'),
        completedAt: new Date('2024-12-01T11:00:00Z'),
      },
      {
        orderNumber: 'ORD-2024-002',
        customerId: customers[1].id,
        userId: users[2].id,
        status: 'COMPLETED' as const,
        items: [
          { productId: products[2].id, quantity: 1, unitPrice: products[2].price },
        ],
        discountId: null,
        createdAt: new Date('2024-12-05T14:30:00Z'),
        completedAt: new Date('2024-12-05T15:00:00Z'),
      },
      {
        orderNumber: 'ORD-2024-003',
        customerId: customers[2].id,
        userId: users[1].id, // manager1
        status: 'PROCESSING' as const,
        items: [
          { productId: products[3].id, quantity: 2, unitPrice: products[3].price },
        ],
        discountId: null,
        createdAt: new Date('2024-12-10T09:15:00Z'),
        completedAt: null,
      },
      {
        orderNumber: 'ORD-2024-004',
        customerId: customers[0].id,
        userId: users[2].id,
        status: 'PENDING' as const,
        items: [
          { productId: products[0].id, quantity: 2, unitPrice: products[0].price },
        ],
        discountId: null,
        createdAt: new Date('2024-12-15T16:45:00Z'),
        completedAt: null,
      },
      {
        orderNumber: 'ORD-2024-005',
        customerId: null,
        userId: users[2].id,
        status: 'COMPLETED' as const,
        items: [
          { productId: products[1].id, quantity: 1, unitPrice: products[1].price },
          { productId: products[3].id, quantity: 1, unitPrice: products[3].price },
        ],
        discountId: null,
        createdAt: new Date('2024-12-18T11:20:00Z'),
        completedAt: new Date('2024-12-18T12:00:00Z'),
      },
    ];

    for (const orderInfo of orderData) {
      // Calculate order totals
      const subtotal = orderInfo.items.reduce((sum, item) => {
        return sum + Number(item.unitPrice) * item.quantity;
      }, 0);

      let discountAmount = 0;
      if (orderInfo.discountId) {
        discountAmount = subtotal * 0.1; // 10% discount
      }

      const total = subtotal - discountAmount;

      // Check if order exists
      const existingOrder = await prisma.order.findUnique({
        where: { orderNumber: orderInfo.orderNumber },
      });

      if (!existingOrder) {
        await prisma.order.create({
          data: {
            orderNumber: orderInfo.orderNumber,
            customerId: orderInfo.customerId,
            userId: orderInfo.userId,
            status: orderInfo.status,
            subtotal: new Prisma.Decimal(subtotal),
            discountId: orderInfo.discountId,
            discountAmount: new Prisma.Decimal(discountAmount),
            taxAmount: new Prisma.Decimal(0),
            total: new Prisma.Decimal(total),
            createdAt: orderInfo.createdAt,
            completedAt: orderInfo.completedAt,
            orderItems: {
              create: orderInfo.items.map(item => {
                const itemSubtotal = Number(item.unitPrice) * item.quantity;
                return {
                  productId: item.productId,
                  quantity: item.quantity,
                  unitPrice: item.unitPrice,
                  subtotal: new Prisma.Decimal(itemSubtotal),
                  discountAmount: new Prisma.Decimal(0),
                  total: new Prisma.Decimal(itemSubtotal),
                };
              }),
            },
          },
        });
      }
    }
    console.log(`Created ${orderData.length} orders\n`);

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