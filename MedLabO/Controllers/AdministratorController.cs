using MedLabO.Models;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;

//using MedLabO.Services.Database;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AdministratorController : BaseCRUDController<Models.Administrator, AdministratorSearchObject, AdministratorInsertRequest, AdministratorUpdateRequest>
    {
        //private readonly IAdministratorService _service;
        //private readonly ILogger<AdministratorController> _logger;

        public AdministratorController(ILogger<BaseController<Administrator, AdministratorSearchObject>> logger, IAdministratorService service) : base(logger, service)
        {
        }

        //[HttpGet]
        //public async Task<IEnumerable<Models.Administrator>> Get()
        //{
        //    return await _service.Get();
        //}

        //[HttpPost]
        //public Task<Models.Administrator> Insert(AdministratorInsertRequest administrator)
        //{
        //    return (_service as IAdministratorService).Insert(administrator);
        //}

        //[HttpPut("{Id}")]
        //public Task<Models.Administrator> Update(string Id, AdministratorUpdateRequest administrator)
        //{
        //    return (_service as IAdministratorService).Update(Id, administrator);
        //}
    }
}