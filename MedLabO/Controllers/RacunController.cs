using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Storage;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

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
    }
}
