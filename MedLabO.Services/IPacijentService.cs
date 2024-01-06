using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;

namespace MedLabO.Services
{
    public interface IPacijentService : ICRUDService<Models.Pacijent.PacijentWithoutTermini, PacijentSearchObject, PacijentRegistrationRequest, PacijentUpdateRequest, Guid>
    {
        Task ChangePassword(ChangePasswordRequest request);
    }
}
