"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.authResolvers = void 0;
const graphql_1 = require("graphql");
const auth_1 = require("../../utils/auth");
exports.authResolvers = {
    Query: {
        me: async (_, __, context) => {
            if (!context.user) {
                throw new graphql_1.GraphQLError('Not authenticated', {
                    extensions: { code: 'UNAUTHENTICATED' },
                });
            }
            const user = await context.prisma.user.findUnique({
                where: { id: context.user.id },
            });
            if (!user) {
                throw new graphql_1.GraphQLError('User not found', {
                    extensions: { code: 'NOT_FOUND' },
                });
            }
            return user;
        },
    },
    Mutation: {
        login: async (_, { input }, context) => {
            const { username, password } = input;
            const user = await context.prisma.user.findUnique({
                where: { username },
            });
            if (!user) {
                throw new graphql_1.GraphQLError('Invalid credentials', {
                    extensions: { code: 'UNAUTHORIZED' },
                });
            }
            if (!user.isActive) {
                throw new graphql_1.GraphQLError('Account is inactive', {
                    extensions: { code: 'FORBIDDEN' },
                });
            }
            const isValid = await auth_1.AuthUtils.comparePassword(password, user.password);
            if (!isValid) {
                throw new graphql_1.GraphQLError('Invalid credentials', {
                    extensions: { code: 'UNAUTHORIZED' },
                });
            }
            const userPayload = {
                id: user.id,
                username: user.username,
                email: user.email,
                role: user.role,
            };
            const token = auth_1.AuthUtils.generateToken(userPayload);
            const refreshToken = auth_1.AuthUtils.generateRefreshToken(userPayload);
            return {
                token,
                refreshToken,
                user,
            };
        },
        register: async (_, { input }, context) => {
            const { username, email, password, role } = input;
            const existingUser = await context.prisma.user.findUnique({
                where: { username },
            });
            if (existingUser) {
                throw new graphql_1.GraphQLError('Username already exists', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            const existingEmail = await context.prisma.user.findUnique({
                where: { email },
            });
            if (existingEmail) {
                throw new graphql_1.GraphQLError('Email already exists', {
                    extensions: { code: 'BAD_USER_INPUT' },
                });
            }
            const hashedPassword = await auth_1.AuthUtils.hashPassword(password);
            const user = await context.prisma.user.create({
                data: {
                    username,
                    email,
                    password: hashedPassword,
                    role: role || 'STAFF',
                },
            });
            const userPayload = {
                id: user.id,
                username: user.username,
                email: user.email,
                role: user.role,
            };
            const token = auth_1.AuthUtils.generateToken(userPayload);
            const refreshToken = auth_1.AuthUtils.generateRefreshToken(userPayload);
            return {
                token,
                refreshToken,
                user,
            };
        },
        refreshToken: async (_, { refreshToken }, context) => {
            try {
                const decoded = auth_1.AuthUtils.verifyToken(refreshToken);
                const user = await context.prisma.user.findUnique({
                    where: { id: decoded.id },
                });
                if (!user || !user.isActive) {
                    throw new graphql_1.GraphQLError('Invalid refresh token', {
                        extensions: { code: 'UNAUTHORIZED' },
                    });
                }
                const userPayload = {
                    id: user.id,
                    username: user.username,
                    email: user.email,
                    role: user.role,
                };
                const newToken = auth_1.AuthUtils.generateToken(userPayload);
                const newRefreshToken = auth_1.AuthUtils.generateRefreshToken(userPayload);
                return {
                    token: newToken,
                    refreshToken: newRefreshToken,
                    user,
                };
            }
            catch (error) {
                throw new graphql_1.GraphQLError('Invalid or expired refresh token', {
                    extensions: { code: 'UNAUTHORIZED' },
                });
            }
        },
    },
};
//# sourceMappingURL=auth.resolver.js.map