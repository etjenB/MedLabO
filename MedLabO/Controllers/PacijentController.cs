using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    public class PacijentController : BaseCRUDController<Models.Pacijent.PacijentWithoutTermini, PacijentSearchObject, PacijentRegistrationRequest, PacijentUpdateRequest, Guid>
    {
        private IPacijentService _pacijentService;
        public PacijentController(ILogger<BaseController<Models.Pacijent.PacijentWithoutTermini, PacijentSearchObject>> logger, IPacijentService service) : base(logger, service)
        {
            _pacijentService = service;
        }

        [HttpPut("ChangePassword")]
        public async Task ChangePassword([FromBody]ChangePasswordRequest request)
        {
            await _pacijentService.ChangePassword(request);
        }
    }
}
