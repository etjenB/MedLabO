using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;

namespace MedLabO.Services
{
    public interface INovostService : ICRUDService<Models.Novost, NovostSearchObject, NovostInsertRequest, NovostUpdateRequest, Guid>
    {
    }
}
