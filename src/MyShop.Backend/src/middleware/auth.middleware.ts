import { GraphQLError } from 'graphql';
import { Context, User } from '../types/context';

/**
 * Require user to be authenticated
 */
export function requireAuth(context: Context): void {
  if (!context.user) {
    throw new GraphQLError('Not authenticated', {
      extensions: { code: 'UNAUTHENTICATED' },
    });
  }
}

/**
 * Require user to have specific role(s)
 */
export function requireRole(context: Context, roles: string[]): void {
  if (!context.user) {
    throw new GraphQLError('Not authenticated', {
      extensions: { code: 'UNAUTHENTICATED' },
    });
  }

  if (!roles.includes(context.user.role)) {
    throw new GraphQLError('Insufficient permissions', {
      extensions: { code: 'FORBIDDEN' },
    });
  }
}

/**
 * Check if user is admin
 */
export function isAdmin(user?: User): boolean {
  return user?.role === 'ADMIN';
}

/**
 * Check if user is manager or admin
 */
export function isManagerOrAdmin(user?: User): boolean {
  return user?.role === 'ADMIN' || user?.role === 'MANAGER';
}
