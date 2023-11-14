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
    public class TestController : BaseCRUDController<Test, TestSearchObject, TestInsertRequest, TestUpdateRequest>
    {
        ITestService _testService;
        public TestController(ILogger<BaseController<Test, TestSearchObject>> logger, ITestService service) : base(logger, service)
        {
            _testService = service;
        }

        [HttpGet("GetTestoviByTerminId/{terminId}")]
        public async Task<ICollection<Models.Test.TestWithoutTerminTestovi>?> GetTestoviByTerminId(Guid terminId)
        {
            return await _testService.GetTestoviByTerminId(terminId);
        }
    }
}