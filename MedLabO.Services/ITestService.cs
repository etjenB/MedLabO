using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;

namespace MedLabO.Services
{
    public interface ITestService : ICRUDService<Models.Test, TestSearchObject, TestInsertRequest, TestUpdateRequest>
    {
    }
}