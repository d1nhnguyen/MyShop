using MyShop.Core.Models;
using System.Threading.Tasks;

namespace MyShop.Core.Interfaces.Services
{
    public interface IAuthService
    {
        Task<User?> LoginAsync(string username, string password, bool rememberMe);
        Task LogoutAsync();
        Task<bool> IsAuthenticatedAsync();
        User? CurrentUser { get; }
    }
}