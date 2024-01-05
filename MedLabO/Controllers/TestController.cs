using MedLabO.Models.Constants;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Models.Test;
using MedLabO.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    public class TestController : BaseCRUDController<Test, TestSearchObject, TestInsertRequest, TestUpdateRequest, Guid>
    {
        ITestService _testService;
        public TestController(ILogger<BaseController<Test, TestSearchObject>> logger, ITestService service) : base(logger, service)
        {
            _testService = service;
        }

        [HttpGet("GetTestoviBasicData")]
        public async Task<ICollection<Models.Test.TestBasicData>?> GetTestoviBasicData()
        {
            return await _testService.GetTestoviBasicData();
        }

        [HttpGet("GetTestoviByTerminId/{terminId}")]
        public async Task<ICollection<Models.Test.TestWithoutTerminTestovi>?> GetTestoviByTerminId(Guid terminId)
        {
            return await _testService.GetTestoviByTerminId(terminId);
        }

        [HttpGet("GetTestoviByUslugaId/{uslugaId}")]
        public async Task<ICollection<Models.Test.TestWithoutTerminTestovi>?> GetTestoviByUslugaId(int uslugaId)
        {
            return await _testService.GetTestoviByUslugaId(uslugaId);
        }

        [HttpGet("GetTestoviBasicDataByUslugaId/{uslugaId}")]
        public async Task<ICollection<Models.Test.TestBasicData>?> GetTestoviBasicDataByUslugaId(int uslugaId)
        {
            return await _testService.GetTestoviBasicDataByUslugaId(uslugaId);
        }

        [HttpGet("GetMostPopularTests")]
        public async Task<ICollection<Models.Test.TestBasicData>?> GetMostPopularTests()
        {
            return await _testService.GetMostPopularTests();
        }
    }
}