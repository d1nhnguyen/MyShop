using MyShop.Core.Models;
using System.Collections.Generic;

namespace MyShop.Core.Interfaces.Strategies
{
    public interface ISortStrategy
    {
        List<Product> Sort(IEnumerable<Product> products);
    }
}