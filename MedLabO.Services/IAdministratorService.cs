using MedLabO.Models;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public interface IAdministratorService : IService<Models.Administrator, AdministratorSearchObject>
    {
        //Task<IList<Models.Administrator>> Get();
        Task<Models.Administrator> Insert(AdministratorInsertRequest administrator);
        Task<Models.Administrator> Update(string Id, AdministratorUpdateRequest administrator);
    }
}
