using AutoMapper;
using MedLabO.Models.Constants;
using MedLabO.Models.Exceptions;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public class PacijentService : CRUDService<Models.Pacijent.PacijentWithoutTermini, Database.Pacijent, PacijentSearchObject, PacijentRegistrationRequest, PacijentUpdateRequest, Guid>, IPacijentService
    {
        private readonly ILogger<PacijentService> _logger;
        private UserManager<Database.ApplicationUser> _userManager;
        private MedLabOContext _dbContext;

        public PacijentService(MedLabOContext db, IMapper mapper, UserManager<Database.ApplicationUser> userManager, ILogger<PacijentService> logger) : base(db, mapper, logger)
        {
            _userManager = userManager;
            _dbContext = db;
            _logger = logger;
        }

        public async Task ChangePassword(ChangePasswordRequest request)
        {
            var user = await _userManager.FindByIdAsync(request.UserId.ToString());
            if (user == null)
            {
                throw new EntityNotFoundException("Korisnik nije pronađen.");
            }

            var result = await _userManager.ChangePasswordAsync(user, request.OldPassword, request.NewPassword);
            if (!result.Succeeded)
            {
                throw new UserException("Lozinka nije tačna.");
            }
        }

        public override async Task BeforeInsert(Pacijent entity, PacijentRegistrationRequest insert)
        {
            var existingUser = await _userManager.FindByNameAsync(entity.UserName);
            if (existingUser != null)
            {
                throw new UserException("Korisnicko ime vec postoji.");
            }

            var existingUserByEmail = await _userManager.FindByEmailAsync(entity.Email);
            if (existingUserByEmail != null)
            {
                throw new UserException("E-mail se vec koristi od strane drugog korisnika.");
            }

            try
            {
                await _userManager.CreateAsync(entity, insert.Password);
                await _userManager.AddToRoleAsync(entity, RoleNames.Pacijent);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error occurred while inserting Pacijent.");
                throw new UserException("Unable to register Pacijent.");
            }
        }

        public override async Task BeforeUpdate(Database.Pacijent entity, PacijentUpdateRequest insert)
        {
            var existingUser = await _userManager.FindByNameAsync(insert.UserName);
            if (existingUser != null && existingUser.Id != insert.Id)
            {
                throw new UserException("Korisnicko ime vec postoji.");
            }

            var existingUserByEmail = await _userManager.FindByEmailAsync(insert.Email);
            if (existingUserByEmail != null && existingUserByEmail.Id != insert.Id)
            {
                throw new UserException("E-mail se vec koristi od strane drugog korisnika.");
            }

            try
            {
                await _userManager.UpdateAsync(entity);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error occurred while updating Pacijent.");
                throw new UserException("Unable to update Pacijent.");
            }
        }

        public override IQueryable<Database.Pacijent> AddFilter(IQueryable<Database.Pacijent> query, PacijentSearchObject? search = null)
        {
            if (search?.IncludeSoftDeleted == false)
            {
                query = query.Where(t => !t.isDeleted);
            }

            if (!string.IsNullOrWhiteSpace(search?.ImePrezime))
            {
                query = query.Where(t => t.Ime.StartsWith(search.ImePrezime) || t.Prezime.StartsWith(search.ImePrezime));
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Database.Pacijent> AddInclude(IQueryable<Database.Pacijent> query, PacijentSearchObject? search = null)
        {
            if (search?.IncludeSpol == true)
            {
                query = query.Include("Spol");
            }

            return base.AddInclude(query, search);
        }
    }
}
