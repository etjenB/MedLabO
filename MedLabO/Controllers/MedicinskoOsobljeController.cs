using MedLabO.Models;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;

namespace MedLabO.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MedicinskoOsobljeController : BaseCRUDController<Models.MedicinskoOsoblje, MedicinskoOsobljeSearchObject, MedicinskoOsobljeRegistrationRequest, MedicinskoOsobljeUpdateRequest, Guid>
    {
        private IMedicinskoOsobljeService _medicinskoOsobljeService;
        public MedicinskoOsobljeController(ILogger<BaseController<Models.MedicinskoOsoblje, MedicinskoOsobljeSearchObject>> logger, IMedicinskoOsobljeService service) : base(logger, service)
        {
            _medicinskoOsobljeService = service;
        }

        [HttpPut("ChangePassword")]
        [Authorize(Roles = "Administrator,MedicinskoOsoblje")]
        public async Task ChangePassword(ChangePasswordRequest request)
        {
            await _medicinskoOsobljeService.ChangePassword(request);
        }

        [HttpGet("GetByIdWithProperties/{id}")]
        public async Task<IActionResult> GetByIdWithProperties(Guid id)
        {
            return Ok(await _medicinskoOsobljeService.GetByIdWithProperties(id));
        }

        [Authorize(Roles = "Administrator")]
        public override Task<MedicinskoOsoblje> Insert([FromBody] MedicinskoOsobljeRegistrationRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Administrator,MedicinskoOsoblje")]
        public override Task<MedicinskoOsoblje> Update(Guid id, [FromBody] MedicinskoOsobljeUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [Authorize(Roles = "Administrator,MedicinskoOsoblje")]
        public override Task<IActionResult> Delete(Guid id)
        {
            return base.Delete(id);
        }
    }
}
