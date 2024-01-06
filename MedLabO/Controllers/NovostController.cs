using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Mvc;
using MedLabO.Models;
using Microsoft.AspNetCore.Authorization;

namespace MedLabO.Controllers
{
    [ApiController]
    public class NovostController : BaseCRUDController<Models.Novost, NovostSearchObject, NovostInsertRequest, NovostUpdateRequest, Guid>
    {
        public NovostController(ILogger<BaseController<Novost, NovostSearchObject>> logger, INovostService service) : base(logger, service)
        {
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Novost> Insert([FromBody] NovostInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Novost> Update(Guid id, [FromBody] NovostUpdateRequest update)
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