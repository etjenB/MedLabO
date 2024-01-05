using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
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
        public async Task ChangePassword(ChangePasswordRequest request)
        {
            await _medicinskoOsobljeService.ChangePassword(request);
        }

        [HttpGet("GetByIdWithProperties/{id}")]
        public async Task<IActionResult> GetByIdWithProperties(Guid id)
        {
            return Ok(await _medicinskoOsobljeService.GetByIdWithProperties(id));
        }
    }
}
