import { Context, User } from '../types/context';
export declare function requireAuth(context: Context): void;
export declare function requireRole(context: Context, roles: string[]): void;
export declare function isAdmin(user?: User): boolean;
export declare function isManagerOrAdmin(user?: User): boolean;
//# sourceMappingURL=auth.middleware.d.ts.map