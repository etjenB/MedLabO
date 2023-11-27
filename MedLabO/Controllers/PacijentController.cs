using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;

namespace MedLabO.Controllers
{
    public class PacijentController : BaseCRUDController<Models.Pacijent.PacijentWithoutTermini, PacijentSearchObject, PacijentRegistrationRequest, PacijentUpdateRequest>
    {
        private IPacijentService _pacijentService;
        public PacijentController(ILogger<BaseController<Models.Pacijent.PacijentWithoutTermini, PacijentSearchObject>> logger, IPacijentService service) : base(logger, service)
        {
            _pacijentService = service;
        }
    }
}
