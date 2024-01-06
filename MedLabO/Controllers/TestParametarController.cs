using MedLabO.Models;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    public class TestParametarController : BaseCRUDController<Models.TestParametar, TestParametarSearchObject, TestParametarInsertRequest, TestParametarUpdateRequest, Guid>
    {
        public TestParametarController(ILogger<BaseController<TestParametar, TestParametarSearchObject>> logger, ITestParametarService service) : base(logger, service)
        {
        }

        [Authorize(Roles = "Administrator")]
        public override Task<TestParametar> Insert([FromBody] TestParametarInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<TestParametar> Update(Guid id, [FromBody] TestParametarUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<IActionResult> Delete(Guid id)
        {
            return base.Delete(id);
        }
    }
}