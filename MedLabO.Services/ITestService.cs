using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Models.Test;

namespace MedLabO.Services
{
    public interface ITestService : ICRUDService<Test, TestSearchObject, TestInsertRequest, TestUpdateRequest>
    {
        Task<ICollection<Models.Test.TestBasicData>?> GetTestoviBasicData();
        Task<ICollection<Models.Test.TestWithoutTerminTestovi>> GetTestoviByTerminId(Guid terminId);
        Task<ICollection<Models.Test.TestWithoutTerminTestovi>?> GetTestoviByUslugaId(Guid uslugaId);
        Task<ICollection<Models.Test.TestBasicData>?> GetTestoviBasicDataByUslugaId(Guid uslugaId);
    }
}