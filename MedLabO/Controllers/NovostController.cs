using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Mvc;
using MedLabO.Models;

namespace MedLabO.Controllers
{
    [ApiController]
    public class NovostController : BaseCRUDController<Models.Novost, NovostSearchObject, NovostInsertRequest, NovostUpdateRequest, Guid>
    {
        public NovostController(ILogger<BaseController<Novost, NovostSearchObject>> logger, INovostService service) : base(logger, service)
        {
        }
    }
}