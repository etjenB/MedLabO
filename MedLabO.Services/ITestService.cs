using MedLabO.Models;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;

namespace MedLabO.Services
{
    public interface ITestService : ICRUDService<Models.Test, TestSearchObject, TestInsertRequest, TestUpdateRequest>
    {
        public Task<Test> ChangeName(Guid Id, string newName);
    }
}