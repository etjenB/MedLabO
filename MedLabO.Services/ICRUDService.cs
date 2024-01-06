
namespace MedLabO.Services
{
    public interface ICRUDService<T, TSearch, TInsert, TUpdate, TKey> : IService<T, TSearch> where TSearch : class where TKey : struct
    {
        Task<T> Insert(TInsert insert);
        Task<T> Update(TKey id, TUpdate update);
    }
}
