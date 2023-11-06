using MedLabO.Models;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AdministratorController : BaseCRUDController<Models.Administrator, AdministratorSearchObject, AdministratorInsertRequest, AdministratorUpdateRequest>
    {
        private readonly IAdministratorService _administratorService;
        public AdministratorController(ILogger<BaseController<Administrator, AdministratorSearchObject>> logger, IAdministratorService service) : base(logger, service)
        {
            _administratorService = service;
        }

        [HttpPut("ChangePassword")]
        public async Task ChangePassword(ChangePasswordRequest request)
        {
            await _administratorService.ChangePassword(request);
        }
    }
}