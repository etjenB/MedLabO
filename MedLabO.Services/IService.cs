using MedLabO.Models;

namespace MedLabO.Services
{
    public interface IService<T, TSearch> where TSearch : class
    {
        Task<PagedResult<T>> Get(TSearch search = null);
        Task<T> GetById(Guid id);
        Task Delete(Guid id);
    }
}