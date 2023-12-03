using MedLabO.Models.SearchObjects;

namespace MedLabO.Services
{
    public interface IZakljucakService : IService<Models.Zakljucak, ZakljucakSearchObject>
    {
        Task<Models.Zakljucak> GetZakljucakByTerminID(string terminID);
    }
}
