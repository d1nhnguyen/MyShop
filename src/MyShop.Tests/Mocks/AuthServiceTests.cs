using MyShop.Core.Models;
using MyShop.Core.Services;
using MyShop.Tests.Mocks;
using System.Threading.Tasks;
using Xunit;

namespace MyShop.Tests.UnitTests.Services
{
    public class AuthServiceTests
    {
        private readonly MockSessionManager _mockSessionManager;
        private readonly MockConfigService _mockConfigService;
        private readonly AuthService _authService;


        private readonly GraphQLService _dummyGraphQLService;

        public AuthServiceTests()
        {
            _mockSessionManager = new MockSessionManager();
            _mockConfigService = new MockConfigService();
            _dummyGraphQLService = new GraphQLService("http://localhost:5000/graphql");

            _authService = new AuthService(_dummyGraphQLService, _mockSessionManager, _mockConfigService);
        }

        [Fact]
        public async Task LogoutAsync_ShouldClearSession()
        {
            // Arrange
            _mockSessionManager.CurrentUser = new User { Username = "test" };
            _mockSessionManager.Token = "valid-token";

            // Act
            await _authService.LogoutAsync();

            // Assert
            Assert.Null(_mockSessionManager.CurrentUser);
            Assert.Null(_mockSessionManager.Token);
            Assert.False(_mockSessionManager.IsAuthenticated);
        }

        [Fact]
        public async Task IsAuthenticatedAsync_ShouldReturnTrue_WhenSessionExists()
        {
            // Arrange
            _mockSessionManager.CurrentUser = new User { Username = "test" };
            _mockSessionManager.Token = "valid-token";

            // Act
            var result = await _authService.IsAuthenticatedAsync();

            // Assert
            Assert.True(result);
        }

        [Fact]
        public async Task IsAuthenticatedAsync_ShouldReturnFalse_WhenSessionEmpty()
        {
            // Arrange
            _mockSessionManager.ClearSession();

            // Act
            var result = await _authService.IsAuthenticatedAsync();

            // Assert
            Assert.False(result);
        }

        [Fact]
        public void CurrentUser_ShouldReflectSessionManager()
        {
            // Arrange
            var user = new User { Id = 1, Username = "admin" };
            _mockSessionManager.CurrentUser = user;

            // Act
            var result = _authService.CurrentUser;

            // Assert
            Assert.NotNull(result);
            Assert.Equal("admin", result.Username);
        }


        [Fact]
        public async Task LoginAsync_WithEmptyCredentials_ShouldReturnNull()
        {
            // Act
            var result = await _authService.LoginAsync("", "", false);

            // Assert
            Assert.Null(result);
        }
    }
}