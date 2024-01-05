using AutoMapper;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;

namespace MedLabO.Services
{
    public class TestParametarService : CRUDService<Models.TestParametar, Database.TestParametar, TestParametarSearchObject, TestParametarInsertRequest, TestParametarUpdateRequest, Guid>, ITestParametarService
    {
        public TestParametarService(MedLabOContext db, IMapper mapper) : base(db, mapper)
        {
        }
    }
}
