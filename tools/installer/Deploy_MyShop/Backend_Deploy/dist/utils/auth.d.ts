import { User } from '../types/context';
export declare class AuthUtils {
    static hashPassword(password: string): Promise<string>;
    static comparePassword(password: string, hashedPassword: string): Promise<boolean>;
    static generateToken(user: User): string;
    static generateRefreshToken(user: User): string;
    static verifyToken(token: string): User;
    static extractToken(authHeader?: string): string | null;
}
//# sourceMappingURL=auth.d.ts.map