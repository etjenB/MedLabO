using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;

namespace MedLabO.Services
{
    public interface IAdministratorService : ICRUDService<Models.Administrator, AdministratorSearchObject, AdministratorInsertRequest, AdministratorUpdateRequest>
    {
        //Task<IList<Models.Administrator>> Get();
        //Task<Models.Administrator> Insert(AdministratorInsertRequest administrator);

        //Task<Models.Administrator> Update(string Id, AdministratorUpdateRequest administrator);
    }
}