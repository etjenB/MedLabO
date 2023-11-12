using MedLabO.Models;
using MedLabO.Models.Requests.Termin;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    public class TerminController : BaseCRUDController<Models.Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>
    {
        ITerminService _terminService;
        public TerminController(ILogger<BaseController<Termin, TerminSearchObject>> logger, ITerminService service) : base(logger, service)
        {
            _terminService = service;
        }

        [HttpPut("TerminOdobravanje")]
        public async Task TerminOdobravanje(TerminOdobravanjeRequest request)
        {
            await _terminService.TerminOdobravanje(request);
        }
    }
}
