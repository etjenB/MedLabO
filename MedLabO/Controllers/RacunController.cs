using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;


namespace MedLabO.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class RacunController : BaseController<Models.Racun, RacunSearchObject>
    {
        IRacunService _racunService;

        public RacunController(ILogger<BaseController<Models.Racun, RacunSearchObject>> logger, IRacunService service) : base(logger, service)
        {
            _racunService = service;
        }

        [HttpGet("GetRacunByTerminID/{terminID}")]
        public async Task<Models.Racun> GetRacunByTerminID(string terminID)
        {
            return await _racunService.GetRacunByTerminID(terminID);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<IActionResult> Delete(Guid id)
        {
            return base.Delete(id);
        }
    }
}
