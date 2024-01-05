using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public interface IMedicinskoOsobljeService : ICRUDService<Models.MedicinskoOsoblje, MedicinskoOsobljeSearchObject, MedicinskoOsobljeRegistrationRequest, MedicinskoOsobljeUpdateRequest, Guid>
    {
        Task ChangePassword(ChangePasswordRequest request);
        Task<Models.MedicinskoOsoblje> GetByIdWithProperties(Guid id);
    }
}
