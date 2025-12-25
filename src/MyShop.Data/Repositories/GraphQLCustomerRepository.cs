using GraphQL;
using MyShop.Core.Interfaces.Repositories;
using MyShop.Core.Models;
using MyShop.Core.Services;
using MyShop.Data.Repositories.Base;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MyShop.Data.Repositories
{
    public class GraphQLCustomerRepository : GraphQLRepositoryBase<Customer>, ICustomerRepository
    {
        public GraphQLCustomerRepository(GraphQLService graphQLService)
            : base(graphQLService, "customer")
        {
        }

        public override async Task<Customer?> GetByIdAsync(int id)
        {
            var request = new GraphQLRequest
            {
                Query = @"
                    query GetCustomer($id: Int!) {
                        customer(id: $id) {
                            id
                            name
                            email
                            phone
                            address
                            createdAt
                            updatedAt
                        }
                    }",
                Variables = new { id }
            };

            var response = await _graphQLService.Client.SendQueryAsync<CustomerResponse>(request);
            return response.Data?.Customer;
        }

        public override async Task<List<Customer>> GetAllAsync()
        {
            var request = new GraphQLRequest
            {
                Query = @"
                    query GetCustomers {
                        customers(pagination: { pageSize: 100 }) {
                            customers {
                                id
                                name
                                email
                                phone
                                address
                                createdAt
                            }
                        }
                    }"
            };

            var response = await _graphQLService.Client.SendQueryAsync<CustomersResponse>(request);

            if (response.Errors != null && response.Errors.Any())
            {
                throw new Exception($"GraphQL Error: {response.Errors[0].Message}");
            }

            return response.Data?.Customers?.Customers ?? new List<Customer>();
        }

        public async Task<Customer?> GetByEmailAsync(string email)
        {
            var request = new GraphQLRequest
            {
                Query = @"
                    query GetCustomerByEmail($email: String!) {
                        customerByEmail(email: $email) {
                            id
                            name
                            email
                            phone
                            address
                            createdAt
                        }
                    }",
                Variables = new { email }
            };

            var response = await _graphQLService.Client.SendQueryAsync<CustomerResponse>(request);
            return response.Data?.Customer;
        }

        public async Task<Customer?> GetByPhoneAsync(string phone)
        {
            var request = new GraphQLRequest
            {
                Query = @"
                    query GetCustomerByPhone($phone: String!) {
                        customerByPhone(phone: $phone) {
                            id
                            name
                            email
                            phone
                            address
                            createdAt
                        }
                    }",
                Variables = new { phone }
            };

            var response = await _graphQLService.Client.SendQueryAsync<CustomerResponse>(request);
            return response.Data?.Customer;
        }

        public async Task<List<Customer>> SearchAsync(string keyword)
        {
            var request = new GraphQLRequest
            {
                Query = @"
                    query SearchCustomers($keyword: String!) {
                        searchCustomers(keyword: $keyword) {
                            id
                            name
                            email
                            phone
                            address
                        }
                    }",
                Variables = new { keyword }
            };

            var response = await _graphQLService.Client.SendQueryAsync<SearchCustomersResponse>(request);
            return response.Data?.SearchCustomers ?? new List<Customer>();
        }

        public override async Task<Customer> AddAsync(Customer entity)
        {
            var request = new GraphQLRequest
            {
                Query = @"
                    mutation CreateCustomer($input: CustomerInput!) {
                        createCustomer(input: $input) {
                            id
                            name
                            email
                            phone
                            address
                            createdAt
                        }
                    }",
                Variables = new
                {
                    input = new
                    {
                        name = entity.Name,
                        email = entity.Email,
                        phone = entity.Phone,
                        address = entity.Address
                    }
                }
            };

            var response = await _graphQLService.Client.SendMutationAsync<CreateCustomerResponse>(request);
            return response.Data?.CreateCustomer ?? throw new Exception("Failed to create customer");
        }

        public override async Task UpdateAsync(Customer entity)
        {
            var request = new GraphQLRequest
            {
                Query = @"
                    mutation UpdateCustomer($id: Int!, $input: CustomerInput!) {
                        updateCustomer(id: $id, input: $input) {
                            id
                        }
                    }",
                Variables = new
                {
                    id = entity.Id,
                    input = new
                    {
                        name = entity.Name,
                        email = entity.Email,
                        phone = entity.Phone,
                        address = entity.Address
                    }
                }
            };

            await _graphQLService.Client.SendMutationAsync<UpdateCustomerResponse>(request);
        }

        public override async Task DeleteAsync(int id)
        {
            var request = new GraphQLRequest
            {
                Query = @"
                    mutation DeleteCustomer($id: Int!) {
                        deleteCustomer(id: $id)
                    }",
                Variables = new { id }
            };

            await _graphQLService.Client.SendMutationAsync<DeleteResponse>(request);
        }

        public override async Task<int> CountAsync()
        {
            var request = new GraphQLRequest
            {
                Query = @"
                    query GetCustomersTotal {
                        customers {
                            total
                        }
                    }"
            };

            var response = await _graphQLService.Client.SendQueryAsync<CustomersResponse>(request);
            return response.Data?.Customers?.Total ?? 0;
        }

        // Response types
        private class CustomerResponse
        {
            public Customer? Customer { get; set; }
        }

        private class CustomersResponse
        {
            public CustomersData? Customers { get; set; }
        }

        private class CustomersData
        {
            public List<Customer> Customers { get; set; } = new();
            public int Total { get; set; }
        }

        private class SearchCustomersResponse
        {
            public List<Customer> SearchCustomers { get; set; } = new();
        }

        private class CreateCustomerResponse
        {
            public Customer? CreateCustomer { get; set; }
        }

        private class UpdateCustomerResponse
        {
            public Customer? UpdateCustomer { get; set; }
        }

        private class DeleteResponse
        {
            public bool DeleteCustomer { get; set; }
        }
    }
}
