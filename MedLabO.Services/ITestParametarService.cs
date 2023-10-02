using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;

namespace MedLabO.Services
{
    public interface ITestParametarService : ICRUDService<Models.TestParametar, TestParametarSearchObject, TestParametarInsertRequest, TestParametarUpdateRequest>
    {
    }
}
