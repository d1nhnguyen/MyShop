# 🔐 MyShop Security & Authorization Guide

This guide explains how to use the security infrastructure built for the MyShop project (WinUI 3 + GraphQL).

---

## 1. Authentication (Login)

The `AuthService` handles user sessions.
- **Login**: Use `AuthService.LoginAsync(username, password)`.
- **Session**: Tokens are managed automatically by `SessionManager` via `LocalSettings`.

### 🔑 Default Development Accounts

After running `npm run seed` in the backend, these accounts are available:

| Role | Username | Password |
|------|----------|----------|
| **ADMIN** | `admin` | `Admin@123456` |
| **STAFF** | `staff1` | `Password@123` |

---

## 2. Authorization (RBAC)

We use **Role-Based Access Control** with **two roles**: `ADMIN` and `STAFF`.

### 📋 Role Permissions Matrix

| Feature | ADMIN | STAFF |
|---------|-------|-------|
| **Products** |
| View Products | ✅ | ✅ |
| View Purchase Prices | ✅ | ❌ |
| Add/Edit/Delete Products | ✅ | ❌ |
| Manage Categories | ✅ | ❌ |
| **Orders** |
| Create Orders | ✅ | ✅ |
| View All Orders | ✅ | ❌ |
| View Own Orders | ✅ | ✅ |
| Cancel/Edit Orders | ✅ | ❌ |
| **Customers** |
| View Customers | ✅ | ✅ |
| Add/Edit/Delete Customers | ✅ | ❌ |
| **Discounts** |
| View Discounts | ✅ | ✅ |
| Create/Edit/Delete Discounts | ✅ | ❌ |
| **Users/Staff** |
| View All Staff | ✅ | ❌ |
| Add/Edit/Delete Staff | ✅ | ❌ |
| **Reports** |
| View Own Commission | ✅ | ✅ |
| View Profit Margins | ✅ | ❌ |
| View All Staff Performance | ✅ | ❌ |
| View Revenue Reports | ✅ | ❌ |
| **Dashboard** |
| View Dashboard | ✅ | ✅ (Limited) |

---

## 3. Implementation

### A. UI-Level (XAML)

Use the `RoleToVisibilityConverter` to hide/show elements based on user role.

```xml
<!-- In App.xaml, the converter is registered as "RoleToVisibilityConverter" -->

<!-- Only ADMIN can see this -->
<Button Content="Manage Users"
        Visibility="{x:Bind ViewModel.CurrentUser.Role, Mode=OneWay, 
                    Converter={StaticResource RoleToVisibilityConverter}, 
                    ConverterParameter='ADMIN'}" />

<!-- Both ADMIN and STAFF can see this -->
<Button Content="Create Order"
        Visibility="{x:Bind ViewModel.CurrentUser.Role, Mode=OneWay, 
                    Converter={StaticResource RoleToVisibilityConverter}, 
                    ConverterParameter='ADMIN,STAFF'}" />
```

### B. Logic-Level (C#)

Inject `IAuthorizationService` into your ViewModels.

#### Available Authorization Methods:

```csharp
// Product Management
bool CanManageProducts()      // ADMIN only
bool CanViewProducts()         // ADMIN, STAFF

// User Management
bool CanManageUsers()          // ADMIN only

// Order Management
bool CanViewAllOrders()        // ADMIN only
bool CanCreateOrders()         // ADMIN, STAFF

// Customer Management
bool CanManageCustomers()      // ADMIN only
bool CanViewCustomers()        // ADMIN, STAFF

// Discount Management
bool CanManageDiscounts()      // ADMIN only

// Reports
bool CanViewReports()          // ADMIN only
bool CanViewOwnCommission()    // ADMIN, STAFF
```

#### Example Usage:

```csharp
public class ProductViewModel : ViewModelBase 
{
    private readonly IAuthorizationService _authService;

    public ProductViewModel(IAuthorizationService authService) 
    {
        _authService = authService;
        
        // Command with role-based CanExecute
        DeleteProductCommand = new RelayCommand(
            execute: _ => DeleteProduct(),
            canExecute: _ => _authService.CanManageProducts() // Only ADMIN
        );
        
        // Conditional logic based on role
        if (_authService.CanManageProducts()) 
        {
            // Show purchase price for ADMIN
            ShowPurchasePrice = true;
        }
    }
}
```

### C. Backend-Level (GraphQL)

All requests must include the JWT in the `Authorization` header. The `GraphQLService` handles this automatically.

Backend resolvers are protected by `@Roles()` decorators:

```typescript
// In backend resolver (TypeScript)
@Mutation(() => Product)
@Roles('ADMIN')  // Only ADMIN can execute this mutation
async createProduct(
  @Args('input') input: CreateProductInput,
  @Context() context: any
): Promise<Product> {
  // Implementation
}

@Query(() => [Order])
@Roles('ADMIN', 'STAFF')  // Both roles can execute
async getMyOrders(@Context() context: any): Promise<Order[]> {
  const userId = context.req.user.id;
  // Return orders for current user
}
```

---

## 4. Global Resources

Common converters available in `App.xaml`:

- **`BoolToVisibilityConverter`**: Convert `bool` to `Visibility`.
- **`InvertedBoolToVisibilityConverter`**: Convert `bool` to `Visibility` (inverted).
- **`RoleToVisibilityConverter`**: Convert `UserRole` to `Visibility` based on allowed roles.

---

## 5. Security Best Practices

### ✅ Do's:
- Always use `IAuthorizationService` for permission checks
- Implement both UI-level and logic-level authorization
- Verify permissions on the backend (never trust frontend)
- Use role-based visibility for sensitive UI elements
- Log authorization failures for security auditing

### ❌ Don'ts:
- Don't rely solely on UI hiding for security
- Don't hardcode role checks (use `IAuthorizationService`)
- Don't expose sensitive data to unauthorized roles
- Don't bypass backend authorization checks

---

## 6. Troubleshooting

### Issue: Button visible but disabled
**Cause**: `CanExecute` returns false but `Visibility` is not bound to role.

**Solution**: Add `RoleToVisibilityConverter` to hide the button completely.

### Issue: Unauthorized access error
**Cause**: JWT token expired or user doesn't have required role.

**Solution**: 
1. Check if user is logged in
2. Verify user role matches required permissions
3. Re-login if token expired

### Issue: Backend returns 403 Forbidden
**Cause**: Backend `@Roles()` decorator blocks the request.

**Solution**: Ensure the logged-in user has the required role for that operation.

---

## 7. Testing Authorization

```csharp
// Example: Test ADMIN permissions
[Fact]
public void Admin_CanManageProducts()
{
    var authService = new AuthorizationService();
    authService.SetCurrentUser(new User { Role = UserRole.ADMIN });
    
    Assert.True(authService.CanManageProducts());
}

// Example: Test STAFF restrictions
[Fact]
public void Staff_CannotManageProducts()
{
    var authService = new AuthorizationService();
    authService.SetCurrentUser(new User { Role = UserRole.STAFF });
    
    Assert.False(authService.CanManageProducts());
}
```