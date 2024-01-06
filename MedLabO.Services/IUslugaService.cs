using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;

namespace MedLabO.Services
{
    public interface IUslugaService : ICRUDService<Models.Usluga.Usluga, UslugaSearchObject, UslugaInsertRequest, UslugaUpdateRequest, int>
    {
        Task<ICollection<Models.Usluga.UslugaBasicData>?> GetUslugeBasicData();
        Task<ICollection<Models.Usluga.Usluga>?> GetUslugeByTerminId(Guid terminId);
        Task<int?> GetPacijentLastChosenUsluga();
        Task<ICollection<Models.Usluga.UslugaBasicData>?> GetMostPopularUslugas();
        Task<List<Models.Usluga.Usluga>> Recommend(int? uslugaId);
    }
}
