using MyShop.Core.Interfaces.Services;
using System.Text.Json;

namespace MyShop.Core.Services
{
    public class ConfigService : IConfigService
    {
        private const string FileName = "config.json";
        private const string DefaultServerUrl = "http://localhost:4000/graphql";
        private const string DefaultDatabaseName = "myshop_db";
        
        private ConfigData _config;

        public ConfigService()
        {
            _config = LocalStorageHelper.Load<ConfigData>(FileName) ?? new ConfigData();
        }

        public string GetServerUrl() 
            => string.IsNullOrEmpty(_config.ServerUrl) ? DefaultServerUrl : _config.ServerUrl;

        public void SaveServerUrl(string url)
        {
            _config.ServerUrl = url;
            LocalStorageHelper.Save(FileName, _config);
        }

        public string GetDatabaseName() 
            => string.IsNullOrEmpty(_config.DatabaseName) ? DefaultDatabaseName : _config.DatabaseName;

        public void SaveDatabaseName(string dbName)
        {
            _config.DatabaseName = dbName;
            LocalStorageHelper.Save(FileName, _config);
        }

        public string? GetLastOpenedPage() => _config.LastOpenedPage;

        public void SaveLastOpenedPage(string pageTag)
        {
            _config.LastOpenedPage = pageTag;
            LocalStorageHelper.Save(FileName, _config);
        }

        private class ConfigData
        {
            public string? ServerUrl { get; set; }
            public string? DatabaseName { get; set; }
            public string? LastOpenedPage { get; set; }
        }
    }
}