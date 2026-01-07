"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.resolvers = void 0;
const graphql_scalars_1 = require("graphql-scalars");
const graphql_1 = require("graphql");
const auth_resolver_1 = require("./auth.resolver");
const user_resolver_1 = require("./user.resolver");
const category_resolver_1 = require("./category.resolver");
const product_resolver_1 = require("./product.resolver");
const customer_resolver_1 = require("./customer.resolver");
const discount_resolver_1 = require("./discount.resolver");
const order_resolver_1 = require("./order.resolver");
const dashboard_resolver_1 = require("./dashboard.resolver");
const commission_resolver_1 = require("./commission.resolver");
const salesTarget_resolver_1 = require("./salesTarget.resolver");
const appLicense_resolver_1 = require("./appLicense.resolver");
const report_resolver_1 = require("./report.resolver");
const DecimalScalar = new graphql_1.GraphQLScalarType({
    name: 'Decimal',
    description: 'A Decimal number scalar',
    serialize(value) {
        return typeof value === 'object' && value !== null ? parseFloat(value.toString()) : parseFloat(value);
    },
    parseValue(value) {
        return parseFloat(value);
    },
    parseLiteral(ast) {
        if (ast.kind === graphql_1.Kind.FLOAT || ast.kind === graphql_1.Kind.INT) {
            return parseFloat(ast.value);
        }
        return null;
    },
});
exports.resolvers = {
    DateTime: graphql_scalars_1.DateTimeResolver,
    Decimal: DecimalScalar,
    Query: {
        ...auth_resolver_1.authResolvers.Query,
        ...user_resolver_1.userResolvers.Query,
        ...category_resolver_1.categoryResolvers.Query,
        ...product_resolver_1.productResolvers.Query,
        ...customer_resolver_1.customerResolvers.Query,
        ...discount_resolver_1.discountResolvers.Query,
        ...order_resolver_1.orderResolvers.Query,
        ...dashboard_resolver_1.dashboardResolvers.Query,
        ...report_resolver_1.reportResolvers.Query,
        ...commission_resolver_1.commissionResolvers.Query,
        ...salesTarget_resolver_1.salesTargetResolvers.Query,
        ...appLicense_resolver_1.appLicenseResolvers.Query,
    },
    Mutation: {
        ...auth_resolver_1.authResolvers.Mutation,
        ...user_resolver_1.userResolvers.Mutation,
        ...category_resolver_1.categoryResolvers.Mutation,
        ...product_resolver_1.productResolvers.Mutation,
        ...customer_resolver_1.customerResolvers.Mutation,
        ...discount_resolver_1.discountResolvers.Mutation,
        ...order_resolver_1.orderResolvers.Mutation,
        ...commission_resolver_1.commissionResolvers.Mutation,
        ...salesTarget_resolver_1.salesTargetResolvers.Mutation,
        ...appLicense_resolver_1.appLicenseResolvers.Mutation,
    },
    Category: category_resolver_1.categoryResolvers.Category,
    Product: product_resolver_1.productResolvers.Product,
    Customer: customer_resolver_1.customerResolvers.Customer,
    Order: order_resolver_1.orderResolvers.Order,
    OrderItem: order_resolver_1.orderResolvers.OrderItem,
    Commission: commission_resolver_1.commissionResolvers.Commission,
    SalesTarget: salesTarget_resolver_1.salesTargetResolvers.SalesTarget,
    AppLicense: appLicense_resolver_1.appLicenseResolvers.AppLicense,
};
//# sourceMappingURL=index.js.map