using MedLabO.Models;
using MedLabO.Services;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AdministratorController : ControllerBase
    {
        private readonly IAdministratorService _service;
        private readonly ILogger<AdministratorController> _logger;

        public AdministratorController(ILogger<AdministratorController> logger, IAdministratorService service)
        {
            _logger = logger;
            _service = service;
        }

        [HttpGet()]
        public IEnumerable<Models.Administrator> Get()
        {
            return _service.Get();
        }
    }
}
