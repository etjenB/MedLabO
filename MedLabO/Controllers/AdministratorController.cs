using MedLabO.Models;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AdministratorController : BaseCRUDController<Models.Administrator, AdministratorSearchObject, AdministratorInsertRequest, AdministratorUpdateRequest, Guid>
    {
        private readonly IAdministratorService _administratorService;
        public AdministratorController(ILogger<BaseController<Administrator, AdministratorSearchObject>> logger, IAdministratorService service) : base(logger, service)
        {
            _administratorService = service;
        }

        [HttpPut("ChangePassword")]
        [Authorize(Roles = "Administrator")]
        public async Task ChangePassword(ChangePasswordRequest request)
        {
            await _administratorService.ChangePassword(request);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Administrator> Insert([FromBody] AdministratorInsertRequest insert)
        {
            return base.Insert(insert);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<Administrator> Update(Guid id, [FromBody] AdministratorUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [Authorize(Roles = "Administrator")]
        public override Task<IActionResult> Delete(Guid id)
        {
            return base.Delete(id);
        }
    }
}