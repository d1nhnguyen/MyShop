"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthUtils = void 0;
const bcryptjs_1 = __importDefault(require("bcryptjs"));
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const env_1 = require("../config/env");
const SALT_ROUNDS = 10;
class AuthUtils {
    static async hashPassword(password) {
        return bcryptjs_1.default.hash(password, SALT_ROUNDS);
    }
    static async comparePassword(password, hashedPassword) {
        return bcryptjs_1.default.compare(password, hashedPassword);
    }
    static generateToken(user) {
        const payload = {
            id: user.id,
            username: user.username,
            email: user.email,
            role: user.role,
        };
        return jsonwebtoken_1.default.sign(payload, env_1.env.JWT_SECRET, {
            expiresIn: env_1.env.JWT_EXPIRES_IN
        });
    }
    static generateRefreshToken(user) {
        const payload = {
            id: user.id,
            username: user.username,
        };
        return jsonwebtoken_1.default.sign(payload, env_1.env.JWT_SECRET, {
            expiresIn: env_1.env.JWT_REFRESH_EXPIRES_IN
        });
    }
    static verifyToken(token) {
        try {
            const decoded = jsonwebtoken_1.default.verify(token, env_1.env.JWT_SECRET);
            return decoded;
        }
        catch (error) {
            throw new Error('Invalid or expired token');
        }
    }
    static extractToken(authHeader) {
        if (!authHeader)
            return null;
        const parts = authHeader.split(' ');
        if (parts.length !== 2 || parts[0] !== 'Bearer') {
            return null;
        }
        return parts[1];
    }
}
exports.AuthUtils = AuthUtils;
//# sourceMappingURL=auth.js.map