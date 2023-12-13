using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Models.Test;

namespace MedLabO.Services
{
    public interface ITestService : ICRUDService<Test, TestSearchObject, TestInsertRequest, TestUpdateRequest>
    {
        Task<ICollection<Models.Test.TestBasicData>?> GetTestoviBasicData();
        Task<ICollection<Models.Test.TestWithoutTerminTestovi>> GetTestoviByTerminId(Guid terminId);
        Task<ICollection<Models.Test.TestWithoutTerminTestovi>?> GetTestoviByUslugaId(int uslugaId);
        Task<ICollection<Models.Test.TestBasicData>?> GetTestoviBasicDataByUslugaId(int uslugaId);
        Task<ICollection<Models.Test.TestBasicData>?> GetMostPopularTests();
    }
}