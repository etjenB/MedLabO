using MedLabO.Models;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    public class TerminController : BaseCRUDController<Models.Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>
    {
        public TerminController(ILogger<BaseController<Termin, TerminSearchObject>> logger, ITerminService service) : base(logger, service)
        {
        }
    }
}
