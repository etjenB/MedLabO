using MedLabO.Models;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    public class TestParametarController : BaseCRUDController<Models.TestParametar, TestParametarSearchObject, TestParametarInsertRequest, TestParametarUpdateRequest>
    {
        public TestParametarController(ILogger<BaseController<TestParametar, TestParametarSearchObject>> logger, ITestParametarService service) : base(logger, service)
        {
        }
    }
}