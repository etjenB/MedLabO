using MedLabO.Models.Requests.Termin;
using MedLabO.Models.SearchObjects;
using MedLabO.Models.Termin;
using MedLabO.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    public class TerminController : BaseCRUDController<Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>
    {
        ITerminService _terminService;
        public TerminController(ILogger<BaseController<Termin, TerminSearchObject>> logger, ITerminService service) : base(logger, service)
        {
            _terminService = service;
        }

        [HttpGet("GetTerminiOfTheDay")]
        public async Task<ICollection<TerminMinimal>> GetTerminiOfTheDay(DateTime request)
        {
            return await _terminService.GetTerminiOfTheDay(request);
        }

        [HttpPut("TerminOdobravanje")]
        [Authorize(Roles = "MedicinskoOsoblje")]
        public async Task TerminOdobravanje(TerminOdobravanjeRequest request)
        {
            await _terminService.TerminOdobravanje(request);
        }

        [HttpPut("TerminOtkazivanje")]
        [Authorize(Roles = "MedicinskoOsoblje")]
        public async Task TerminOtkazivanje(TerminOtkazivanjeRequest request)
        {
            await _terminService.TerminOtkazivanje(request);
        }

        [HttpPut("TerminDodavanjeRezultata")]
        [Authorize(Roles = "MedicinskoOsoblje")]
        public async Task TerminDodavanjeRezultata(TerminTestRezultatRequest request)
        {
            await _terminService.TerminDodavanjeRezultata(request);
        }

        [HttpPut("TerminDodavanjeZakljucka")]
        [Authorize(Roles = "MedicinskoOsoblje")]
        public async Task TerminDodavanjeZakljucka(TerminZakljucakRequest request)
        {
            await _terminService.TerminDodavanjeZakljucka(request);
        }
    }
}
