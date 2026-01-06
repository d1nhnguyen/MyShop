using MyShop.Core.Interfaces.Services;
using MyShop.Core.Models;
using System.Text.Json;

namespace MyShop.Core.Services
{
    public class SessionManager : ISessionManager
    {
        private const string FileName = "session.json";
        private readonly GraphQLService _graphQLService;
        private SessionData _sessionData;

        public SessionManager(GraphQLService graphQLService)
        {
            _graphQLService = graphQLService;
            _sessionData = LocalStorageHelper.Load<SessionData>(FileName) ?? new SessionData();
            
            Token = _sessionData.Token;
            CurrentUser = _sessionData.User;
            
            if (IsAuthenticated)
            {
                _graphQLService.SetAuthToken(Token);
            }
        }

        public User? CurrentUser { get; set; }
        public string? Token { get; set; }
        public bool IsAuthenticated => !string.IsNullOrEmpty(Token);
        public bool IsSessionPersisted => !string.IsNullOrEmpty(_sessionData.Token);

        public void ClearSession()
        {
            Token = null;
            CurrentUser = null;
            _sessionData = new SessionData();
            LocalStorageHelper.Delete(FileName);
            _graphQLService.SetAuthToken(null);
        }

        public void SaveSession(string token, User user, bool rememberMe)
        {
            Token = token;
            CurrentUser = user;

            if (rememberMe)
            {
                _sessionData.Token = token;
                _sessionData.User = user;
                LocalStorageHelper.Save(FileName, _sessionData);
            }

            _graphQLService.SetAuthToken(token);
        }

        private class SessionData
        {
            public string? Token { get; set; }
            public User? User { get; set; }
        }
    }
}