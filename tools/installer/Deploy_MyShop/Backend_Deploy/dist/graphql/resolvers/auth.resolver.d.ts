import { Context } from '../../types/context';
export declare const authResolvers: {
    Query: {
        me: (_: any, __: any, context: Context) => Promise<{
            id: number;
            username: string;
            email: string;
            password: string;
            role: import(".prisma/client").$Enums.UserRole;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
        }>;
    };
    Mutation: {
        login: (_: any, { input }: any, context: Context) => Promise<{
            token: string;
            refreshToken: string;
            user: {
                id: number;
                username: string;
                email: string;
                password: string;
                role: import(".prisma/client").$Enums.UserRole;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
            };
        }>;
        register: (_: any, { input }: any, context: Context) => Promise<{
            token: string;
            refreshToken: string;
            user: {
                id: number;
                username: string;
                email: string;
                password: string;
                role: import(".prisma/client").$Enums.UserRole;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
            };
        }>;
        refreshToken: (_: any, { refreshToken }: any, context: Context) => Promise<{
            token: string;
            refreshToken: string;
            user: {
                id: number;
                username: string;
                email: string;
                password: string;
                role: import(".prisma/client").$Enums.UserRole;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
            };
        }>;
    };
};
//# sourceMappingURL=auth.resolver.d.ts.map