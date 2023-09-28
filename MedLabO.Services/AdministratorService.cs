using AutoMapper;
using MedLabO.Models;
using MedLabO.Models.Constants;
using MedLabO.Models.Exceptions;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Identity;
using Administrator = MedLabO.Services.Database.Administrator;

namespace MedLabO.Services
{
    public class AdministratorService : CRUDService<Models.Administrator, Database.Administrator, AdministratorSearchObject, AdministratorInsertRequest, AdministratorUpdateRequest>, IAdministratorService
    {
        private UserManager<ApplicationUser> _userManager;

        public AdministratorService(MedLabOContext db, IMapper mapper, UserManager<ApplicationUser> userManager) : base(db, mapper)
        {
            _userManager = userManager;
        }

        public override async Task BeforeInsert(Administrator entity, AdministratorInsertRequest insert)
        {
            try
            {
                var result = await _userManager.CreateAsync(entity, insert.Password);
                await _userManager.AddToRoleAsync(entity, RoleNames.Administrator);
            }
            catch
            {
                throw new UserException("Unable to insert Administrator.");
            }
        }
    }
}