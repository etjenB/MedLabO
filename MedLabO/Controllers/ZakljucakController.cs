using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ZakljucakController : BaseController<Models.Zakljucak, ZakljucakSearchObject>
    {
        IZakljucakService _zakljucakService;

        public ZakljucakController(ILogger<BaseController<Models.Zakljucak, ZakljucakSearchObject>> logger, IZakljucakService service) : base(logger, service)
        {
            _zakljucakService = service;
        }

        [HttpGet("GetZakljucakByTerminID/{terminID}")]
        public async Task<Models.Zakljucak> GetZakljucakByTerminID(string terminID)
        {
            return await _zakljucakService.GetZakljucakByTerminID(terminID);
        }

        [Authorize(Roles = "Administrator,MedicinskoOsoblje")]
        public override Task<IActionResult> Delete(Guid id)
        {
            return base.Delete(id);
        }
    }
}
