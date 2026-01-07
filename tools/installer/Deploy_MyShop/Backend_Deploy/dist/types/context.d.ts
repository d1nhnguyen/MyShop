import { PrismaClient } from '@prisma/client';
export interface User {
    id: number;
    username: string;
    email: string;
    role: 'ADMIN' | 'MANAGER' | 'STAFF';
}
export interface Context {
    prisma: PrismaClient;
    user?: User;
}
//# sourceMappingURL=context.d.ts.map