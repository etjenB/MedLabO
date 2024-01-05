using AutoMapper;
using MedLabO.Models.Constants;
using MedLabO.Models.Exceptions;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Logging;
using Administrator = MedLabO.Services.Database.Administrator;

namespace MedLabO.Services
{
    public class AdministratorService : CRUDService<Models.Administrator, Database.Administrator, AdministratorSearchObject, AdministratorInsertRequest, AdministratorUpdateRequest, Guid>, IAdministratorService
    {
        private readonly ILogger<AdministratorService> _logger;
        private UserManager<Database.ApplicationUser> _userManager;

        public AdministratorService(MedLabOContext db, IMapper mapper, ILogger<AdministratorService> logger, UserManager<Database.ApplicationUser> userManager) : base(db, mapper, logger)
        {
            _logger = logger;
            _userManager = userManager;
        }

        public async Task ChangePassword(ChangePasswordRequest request)
        {
            var user = await _userManager.FindByIdAsync(request.UserId.ToString());
            if (user == null)
            {
                _logger.LogWarning(new EntityNotFoundException(), $"User with ID {request.UserId} was not found.");
                throw new EntityNotFoundException("Korisnik nije pronađen.");
            }

            var token = await _userManager.GeneratePasswordResetTokenAsync(user);

            var result = await _userManager.ResetPasswordAsync(user, token, request.NewPassword);
            if (!result.Succeeded)
            {
                _logger.LogError(new UserException("Error while changing password for administrator."), $"Error happened while trying to change password for user with ID {request.UserId}.");
                throw new UserException("Lozinka nije promjenjena.");
            }
        }

        public override IQueryable<Database.Administrator> AddFilter(IQueryable<Database.Administrator> query, AdministratorSearchObject? search = null)
        {
            if (search?.GetContacts == true)
            {
                query = query.Where(a => a.IsKontakt == true);
            }

            return base.AddFilter(query, search);
        }

        public override async Task BeforeInsert(Administrator entity, AdministratorInsertRequest insert)
        {
            try
            {
                var result = await _userManager.CreateAsync(entity, insert.Password);
                await _userManager.AddToRoleAsync(entity, RoleNames.Administrator);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error occurred while inserting Administrator.");
                throw new UserException("Unable to insert Administrator.");
            }
        }
    }
}