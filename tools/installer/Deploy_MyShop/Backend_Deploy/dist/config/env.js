"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.env = void 0;
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
exports.env = {
    PORT: process.env.PORT || 4000,
    NODE_ENV: process.env.NODE_ENV || 'development',
    DATABASE_URL: process.env.DATABASE_URL || '',
    JWT_SECRET: process.env.JWT_SECRET || 'your-secret-key',
    JWT_EXPIRES_IN: (process.env.JWT_EXPIRES_IN || '7d'),
    JWT_REFRESH_EXPIRES_IN: (process.env.JWT_REFRESH_EXPIRES_IN || '30d'),
    ADMIN_EMAIL: process.env.ADMIN_EMAIL || 'admin@myshop.com',
    ADMIN_PASSWORD: process.env.ADMIN_PASSWORD || 'Admin@123456',
    ADMIN_USERNAME: process.env.ADMIN_USERNAME || 'admin',
    CORS_ORIGIN: process.env.CORS_ORIGIN || 'http://localhost:3000',
    DEFAULT_PAGE_SIZE: parseInt(process.env.DEFAULT_PAGE_SIZE || '20', 10),
    MAX_PAGE_SIZE: parseInt(process.env.MAX_PAGE_SIZE || '100', 10),
};
//# sourceMappingURL=env.js.map