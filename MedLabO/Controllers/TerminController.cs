using MedLabO.Models;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    public class TerminController : BaseController<Models.Termin, TerminSearchObject>
    {
        public TerminController(ILogger<BaseController<Termin, TerminSearchObject>> logger, IService<Termin, TerminSearchObject> service) : base(logger, service)
        {
        }
    }
}
