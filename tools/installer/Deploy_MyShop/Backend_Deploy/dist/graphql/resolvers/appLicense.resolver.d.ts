import { Context } from '../../types/context';
export interface ActivateLicenseInput {
    licenseKey: string;
}
export declare const appLicenseResolvers: {
    Query: {
        validateLicense: (_: any, { licenseKey }: {
            licenseKey: string;
        }, { prisma }: Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            licenseKey: string;
            deviceId: string | null;
            activatedAt: Date;
            expiresAt: Date;
        }>;
        checkTrialStatus: (_: any, __: any, { prisma }: Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            licenseKey: string;
            deviceId: string | null;
            activatedAt: Date;
            expiresAt: Date;
        } | null>;
    };
    Mutation: {
        activateTrial: (_: any, _input: any, { prisma, user }: Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            licenseKey: string;
            deviceId: string | null;
            activatedAt: Date;
            expiresAt: Date;
        }>;
        activateLicense: (_: any, { input }: {
            input: ActivateLicenseInput;
        }, { prisma, user }: Context) => Promise<{
            id: number;
            isActive: boolean;
            createdAt: Date;
            licenseKey: string;
            deviceId: string | null;
            activatedAt: Date;
            expiresAt: Date;
        }>;
        deactivateLicense: (_: any, { licenseKey }: {
            licenseKey: string;
        }, { prisma, user }: Context) => Promise<boolean>;
    };
    AppLicense: {
        isExpired: (parent: any) => boolean;
        daysRemaining: (parent: any) => number;
    };
};
//# sourceMappingURL=appLicense.resolver.d.ts.map