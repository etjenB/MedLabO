using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MedicinskoOsobljeController : BaseCRUDController<Models.MedicinskoOsoblje, MedicinskoOsobljeSearchObject, MedicinskoOsobljeRegistrationRequest, MedicinskoOsobljeUpdateRequest>
    {
        public MedicinskoOsobljeController(ILogger<BaseController<Models.MedicinskoOsoblje, MedicinskoOsobljeSearchObject>> logger, IMedicinskoOsobljeService service) : base(logger, service)
        {
        }
    }
}
