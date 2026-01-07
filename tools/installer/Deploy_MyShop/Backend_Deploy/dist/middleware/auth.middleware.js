"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.requireAuth = requireAuth;
exports.requireRole = requireRole;
exports.isAdmin = isAdmin;
exports.isManagerOrAdmin = isManagerOrAdmin;
const graphql_1 = require("graphql");
function requireAuth(context) {
    if (!context.user) {
        throw new graphql_1.GraphQLError('Not authenticated', {
            extensions: { code: 'UNAUTHENTICATED' },
        });
    }
}
function requireRole(context, roles) {
    if (!context.user) {
        throw new graphql_1.GraphQLError('Not authenticated', {
            extensions: { code: 'UNAUTHENTICATED' },
        });
    }
    if (!roles.includes(context.user.role)) {
        throw new graphql_1.GraphQLError('Insufficient permissions', {
            extensions: { code: 'FORBIDDEN' },
        });
    }
}
function isAdmin(user) {
    return user?.role === 'ADMIN';
}
function isManagerOrAdmin(user) {
    return user?.role === 'ADMIN' || user?.role === 'MANAGER';
}
//# sourceMappingURL=auth.middleware.js.map