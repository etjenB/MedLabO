using MedLabO.Models;
using MedLabO.Services;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UslugaController : ControllerBase
    {
        private readonly IUslugaService _uslugaService;
        private readonly ILogger<WeatherForecastController> _logger;

        public UslugaController(ILogger<WeatherForecastController> logger, IUslugaService uslugaService)
        {
            _logger = logger;
            _uslugaService = uslugaService;
        }

        [HttpGet()]
        public IEnumerable<Usluga> Get()
        {
            return _uslugaService.Get();
        }
    }
}