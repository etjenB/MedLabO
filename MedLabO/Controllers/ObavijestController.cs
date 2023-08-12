using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Mvc;
using MedLabO.Models;

namespace MedLabO.Controllers
{
    [ApiController]
    public class ObavijestController : BaseCRUDController<Models.Obavijest, ObavijestSearchObject, ObavijestInsertRequest, ObavijestUpdateRequest>
    {
        public ObavijestController(ILogger<BaseController<Obavijest, ObavijestSearchObject>> logger, IObavijestService service) : base(logger, service)
        {
        }
    }
}