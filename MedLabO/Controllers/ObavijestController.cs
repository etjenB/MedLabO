using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Mvc;
using MedLabO.Models;
using Microsoft.AspNetCore.Authorization;

namespace MedLabO.Controllers
{
    [ApiController]
    public class ObavijestController : BaseCRUDController<Models.Obavijest, ObavijestSearchObject, ObavijestInsertRequest, ObavijestUpdateRequest, Guid>
    {
        public ObavijestController(ILogger<BaseController<Obavijest, ObavijestSearchObject>> logger, IObavijestService service) : base(logger, service)
        {
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Obavijest> Insert([FromBody] ObavijestInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Obavijest> Update(Guid id, [FromBody] ObavijestUpdateRequest update)
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