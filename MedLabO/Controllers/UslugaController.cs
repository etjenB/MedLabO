using MedLabO.Models;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    public class UslugaController : BaseCRUDController<Models.Usluga, UslugaSearchObject, UslugaInsertRequest, UslugaUpdateRequest>
    {
        private IUslugaService _uslugaService;
        public UslugaController(ILogger<BaseController<Models.Usluga, UslugaSearchObject>> logger, IUslugaService service) : base(logger, service)
        {
            _uslugaService = service;
        }

        [HttpGet("GetUslugeByTerminId/{terminId}")]
        public async Task<ICollection<Models.Usluga>?> GetUslugeByTerminId(Guid terminId)
        {
            return await _uslugaService.GetUslugeByTerminId(terminId);
        }
    }
}