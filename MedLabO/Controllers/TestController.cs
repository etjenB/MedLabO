using MedLabO.Models;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    public class TestController : BaseController<Models.Test, TestSearchObject>
    {
        public TestController(ILogger<BaseController<Test, TestSearchObject>> logger, IService<Test, TestSearchObject> service) : base(logger, service)
        {
        }
    }
}
