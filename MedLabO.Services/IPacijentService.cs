using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public interface IPacijentService : ICRUDService<Models.Pacijent.PacijentWithoutTermini, PacijentSearchObject, PacijentRegistrationRequest, PacijentUpdateRequest, Guid>
    {
        Task ChangePassword(ChangePasswordRequest request);
    }
}
