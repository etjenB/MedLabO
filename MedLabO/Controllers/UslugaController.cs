using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    public class UslugaController : BaseCRUDController<Models.Usluga.Usluga, UslugaSearchObject, UslugaInsertRequest, UslugaUpdateRequest>
    {
        private IUslugaService _uslugaService;
        public UslugaController(ILogger<BaseController<Models.Usluga.Usluga, UslugaSearchObject>> logger, IUslugaService service) : base(logger, service)
        {
            _uslugaService = service;
        }

        [HttpGet("GetUslugeBasicData")]
        public async Task<ICollection<Models.Usluga.UslugaBasicData>?> GetUslugeBasicData()
        {
            return await _uslugaService.GetUslugeBasicData();
        }

        [HttpGet("GetUslugeByTerminId/{terminId}")]
        public async Task<ICollection<Models.Usluga.Usluga>?> GetUslugeByTerminId(Guid terminId)
        {
            return await _uslugaService.GetUslugeByTerminId(terminId);
        }

        [HttpGet("GetPacijentLastChosenUsluga")]
        public async Task<int?> GetPacijentLastChosenUsluga()
        {
            return await _uslugaService.GetPacijentLastChosenUsluga();
        }

        [HttpGet("GetMostPopularUslugas")]
        public async Task<ICollection<Models.Usluga.UslugaBasicData>?> GetMostPopularUslugas()
        {
            return await _uslugaService.GetMostPopularUslugas();
        }

        [HttpGet("Recommend/{uslugaId}")]
        public async Task<ICollection<Models.Usluga.Usluga>> Recommend(int uslugaId)
        {
            return await _uslugaService.Recommend(uslugaId);
        }
    }
}