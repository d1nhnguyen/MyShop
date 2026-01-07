"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.appLicenseResolvers = void 0;
const crypto_1 = require("crypto");
function generateLicenseKey() {
    const part1 = (0, crypto_1.randomBytes)(2).toString('hex').toUpperCase();
    const part2 = (0, crypto_1.randomBytes)(2).toString('hex').toUpperCase();
    const part3 = (0, crypto_1.randomBytes)(2).toString('hex').toUpperCase();
    return `MYSHOP-${part1}-${part2}-${part3}`;
}
exports.appLicenseResolvers = {
    Query: {
        validateLicense: async (_, { licenseKey }, { prisma }) => {
            const license = await prisma.appLicense.findUnique({
                where: { licenseKey },
            });
            if (!license) {
                throw new Error('Invalid license key');
            }
            return license;
        },
        checkTrialStatus: async (_, __, { prisma }) => {
            const license = await prisma.appLicense.findFirst({
                where: { isActive: true },
                orderBy: { activatedAt: 'desc' },
            });
            return license;
            return license;
        },
    },
    Mutation: {
        activateTrial: async (_, _input, { prisma, user }) => {
            if (!user || user.role !== 'ADMIN') {
                throw new Error('Only admin can activate trial');
            }
            const existing = await prisma.appLicense.findFirst({
                where: { isActive: true },
            });
            if (existing) {
                throw new Error('Trial already activated. Use license key to extend.');
            }
            const now = new Date();
            const expiresAt = new Date(now.getTime() + 15 * 24 * 60 * 60 * 1000);
            const license = await prisma.appLicense.create({
                data: {
                    licenseKey: generateLicenseKey(),
                    activatedAt: now,
                    expiresAt,
                    isActive: true,
                },
            });
            return license;
        },
        activateLicense: async (_, { input }, { prisma, user }) => {
            if (!user || user.role !== 'ADMIN') {
                throw new Error('Only admin can activate license');
            }
            const license = await prisma.appLicense.findUnique({
                where: { licenseKey: input.licenseKey },
            });
            if (!license) {
                throw new Error('Invalid license key');
            }
            const now = new Date();
            const expiresAt = new Date(now.getTime() + 365 * 24 * 60 * 60 * 1000);
            const updatedLicense = await prisma.appLicense.update({
                where: { licenseKey: input.licenseKey },
                data: {
                    expiresAt,
                    isActive: true,
                },
            });
            return updatedLicense;
        },
        deactivateLicense: async (_, { licenseKey }, { prisma, user }) => {
            if (!user || user.role !== 'ADMIN') {
                throw new Error('Only admin can deactivate license');
            }
            await prisma.appLicense.update({
                where: { licenseKey },
                data: { isActive: false },
            });
            return true;
        },
    },
    AppLicense: {
        isExpired: (parent) => {
            return new Date() > new Date(parent.expiresAt);
        },
        daysRemaining: (parent) => {
            const now = new Date();
            const expires = new Date(parent.expiresAt);
            const diff = expires.getTime() - now.getTime();
            const days = Math.ceil(diff / (1000 * 60 * 60 * 24));
            return days > 0 ? days : 0;
        },
    },
};
//# sourceMappingURL=appLicense.resolver.js.map