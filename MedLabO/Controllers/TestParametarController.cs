using MedLabO.Models;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    public class TestParametarController : BaseController<TestParametar, SearchObject>
    {
        public TestParametarController(ILogger<BaseController<TestParametar, SearchObject>> logger, IService<TestParametar, SearchObject> service) : base(logger, service)
        {
        }
    }
}