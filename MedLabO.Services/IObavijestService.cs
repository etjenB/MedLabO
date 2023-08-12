using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;

namespace MedLabO.Services
{
    public interface IObavijestService : ICRUDService<Models.Obavijest, ObavijestSearchObject, ObavijestInsertRequest, ObavijestUpdateRequest>
    {
    }
}
