using MedLabO.Models.SearchObjects;

namespace MedLabO.Services
{
    public interface IRacunService : IService<Models.Racun, RacunSearchObject>
    {
        Task<Models.Racun> GetRacunByTerminID(string terminID);
    }
}
