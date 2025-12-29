using MyShop.Core.Interfaces.Services;
using MyShop.Core.Models;

namespace MyShop.Tests.Mocks
{
    public class MockSessionManager : ISessionManager
    {
        public User? CurrentUser { get; set; }
        public string? Token { get; set; }

        // Derived property logic for testing
        public bool IsAuthenticated => !string.IsNullOrEmpty(Token) && CurrentUser != null;

        public void ClearSession()
        {
            CurrentUser = null;
            Token = null;
        }

        public void SaveSession(string token, User user, bool rememberMe)
        {
            Token = token;
            CurrentUser = user;
        }
    }
}