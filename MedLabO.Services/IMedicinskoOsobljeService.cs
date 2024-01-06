using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;

namespace MedLabO.Services
{
    public interface IMedicinskoOsobljeService : ICRUDService<Models.MedicinskoOsoblje, MedicinskoOsobljeSearchObject, MedicinskoOsobljeRegistrationRequest, MedicinskoOsobljeUpdateRequest, Guid>
    {
        Task ChangePassword(ChangePasswordRequest request);
        Task<Models.MedicinskoOsoblje> GetByIdWithProperties(Guid id);
    }
}
