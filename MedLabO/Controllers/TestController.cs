using MedLabO.Models;
using MedLabO.Models.Constants;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    public class TestController : BaseCRUDController<Models.Test, TestSearchObject, TestInsertRequest, TestUpdateRequest>
    {
        public TestController(ILogger<BaseController<Test, TestSearchObject>> logger, ITestService service) : base(logger, service)
        {
        }

        [HttpPut("{Id}/ChangeName")]
        [Authorize(Roles = RoleNames.Administrator + "," + RoleNames.MedicinskoOsoblje)]
        public virtual async Task<Test> ChangeName(Guid Id, [FromBody] string newName)
        {
            return await (_service as ITestService).ChangeName(Id, newName);
        }
    }
}