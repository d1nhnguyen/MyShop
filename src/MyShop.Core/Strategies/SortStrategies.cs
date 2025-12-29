using MyShop.Core.Interfaces.Strategies;
using MyShop.Core.Models;
using System.Collections.Generic;
using System.Linq;

namespace MyShop.Core.Strategies
{
    public class PriceAscSortStrategy : ISortStrategy
    {
        public List<Product> Sort(IEnumerable<Product> products)
        {
            return products.OrderBy(p => p.Price).ToList();
        }
    }

    public class PriceDescSortStrategy : ISortStrategy
    {
        public List<Product> Sort(IEnumerable<Product> products)
        {
            return products.OrderByDescending(p => p.Price).ToList();
        }
    }

    public class NameAscSortStrategy : ISortStrategy
    {
        public List<Product> Sort(IEnumerable<Product> products)
        {
            return products.OrderBy(p => p.Name).ToList();
        }
    }

    public class StockDescSortStrategy : ISortStrategy
    {
        public List<Product> Sort(IEnumerable<Product> products)
        {
            return products.OrderByDescending(p => p.Stock).ToList();
        }
    }
}