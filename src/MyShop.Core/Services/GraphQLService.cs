using GraphQL.Client.Http;
using GraphQL.Client.Serializer.SystemTextJson;
using System;
using System.Net.Http.Headers;

namespace MyShop.Core.Services
{
    public class GraphQLService
    {
        private readonly GraphQLHttpClient _client;

        public GraphQLService(string endpoint)
        {
            _client = new GraphQLHttpClient(new GraphQLHttpClientOptions
            {
                EndPoint = new Uri(endpoint)
            }, new SystemTextJsonSerializer());
        }

        public GraphQLHttpClient Client => _client;

        public void SetAuthToken(string? token)
        {
            if (string.IsNullOrEmpty(token))
            {
                _client.HttpClient.DefaultRequestHeaders.Authorization = null;
            }
            else
            {
                _client.HttpClient.DefaultRequestHeaders.Authorization =
                    new AuthenticationHeaderValue("Bearer", token);
            }
        }
    }
}