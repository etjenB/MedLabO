using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    public class UslugaController : BaseCRUDController<Models.Usluga.Usluga, UslugaSearchObject, UslugaInsertRequest, UslugaUpdateRequest, int>
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

        [Authorize(Roles = "Administrator")]
        public override Task<Models.Usluga.Usluga> Insert([FromBody] UslugaInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Models.Usluga.Usluga> Update(int id, [FromBody] UslugaUpdateRequest update)
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