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
        public TestController(ILogger<BaseController<Test, TestSearchObject>> logger, ITestService service) : base(logger, service)
        {
        }
    }
}