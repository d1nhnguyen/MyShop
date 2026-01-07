import { Context } from '../../types/context';
export declare const userResolvers: {
    Query: {
        users: (_: any, { pagination, sort }: any, context: Context) => Promise<{
            users: {
                id: number;
                username: string;
                email: string;
                password: string;
                role: import(".prisma/client").$Enums.UserRole;
                isActive: boolean;
                createdAt: Date;
                updatedAt: Date;
            }[];
            total: number;
            page: any;
            pageSize: number;
            totalPages: number;
        }>;
        user: (_: any, { id }: any, context: Context) => Promise<{
            id: number;
            username: string;
            email: string;
            password: string;
            role: import(".prisma/client").$Enums.UserRole;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
        }>;
        userByUsername: (_: any, { username }: any, context: Context) => Promise<{
            id: number;
            username: string;
            email: string;
            password: string;
            role: import(".prisma/client").$Enums.UserRole;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
        } | null>;
    };
    Mutation: {
        createUser: (_: any, { input }: any, context: Context) => Promise<{
            id: number;
            username: string;
            email: string;
            password: string;
            role: import(".prisma/client").$Enums.UserRole;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
        }>;
        updateUser: (_: any, { id, input }: any, context: Context) => Promise<{
            id: number;
            username: string;
            email: string;
            password: string;
            role: import(".prisma/client").$Enums.UserRole;
            isActive: boolean;
            createdAt: Date;
            updatedAt: Date;
        }>;
        deleteUser: (_: any, { id }: any, context: Context) => Promise<boolean>;
    };
};
//# sourceMappingURL=user.resolver.d.ts.map