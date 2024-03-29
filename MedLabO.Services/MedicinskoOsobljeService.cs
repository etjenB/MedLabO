﻿using AutoMapper;
using MedLabO.Models.Constants;
using MedLabO.Models.Exceptions;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace MedLabO.Services
{
    public class MedicinskoOsobljeService : CRUDService<Models.MedicinskoOsoblje, Database.MedicinskoOsoblje, MedicinskoOsobljeSearchObject, MedicinskoOsobljeRegistrationRequest, MedicinskoOsobljeUpdateRequest, Guid>, IMedicinskoOsobljeService
    {
        private readonly ILogger<MedicinskoOsobljeService> _logger;
        private UserManager<Database.ApplicationUser> _userManager;
        private MedLabOContext _dbContext;

        public MedicinskoOsobljeService(MedLabOContext db, IMapper mapper, UserManager<Database.ApplicationUser> userManager, ILogger<MedicinskoOsobljeService> logger) : base(db, mapper, logger)
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

        public virtual async Task<Models.MedicinskoOsoblje> GetByIdWithProperties(Guid id)
        {
            var entity = await _db.Set<Database.MedicinskoOsoblje>().FindAsync(id);
            if (entity is null) throw new EntityNotFoundException();
            entity.Zvanje = await _db.Zvanja.FirstOrDefaultAsync(z => entity.ZvanjeID == z.ZvanjeID);
            entity.Spol = await _db.Spolovi.FirstOrDefaultAsync(s => entity.SpolID == s.SpolID);
            return _mapper.Map<Models.MedicinskoOsoblje>(entity);
        }

        public override async Task BeforeInsert(MedicinskoOsoblje entity, MedicinskoOsobljeRegistrationRequest insert)
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
                await _userManager.AddToRoleAsync(entity, RoleNames.MedicinskoOsoblje);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error occurred while inserting MedicinskoOsoblje.");
                throw new UserException("Unable to register MedicinskoOsoblje.");
            }
        }

        public override async Task BeforeUpdate(Database.MedicinskoOsoblje entity, MedicinskoOsobljeUpdateRequest insert)
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
                _logger.LogError(ex, "Error occurred while updating MedicinskoOsoblje.");
                throw new UserException("Unable to update MedicinskoOsoblje.");
            }
        }

        public override IQueryable<Database.MedicinskoOsoblje> AddFilter(IQueryable<Database.MedicinskoOsoblje> query, MedicinskoOsobljeSearchObject? search = null)
        {
            if (search?.IncludeSoftDeleted==false)
            {
                query = query.Where(t => !t.isDeleted);
            }

            if (!string.IsNullOrWhiteSpace(search?.ImePrezime))
            {
                query = query.Where(t => t.Ime.StartsWith(search.ImePrezime) || t.Prezime.StartsWith(search.ImePrezime));
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Database.MedicinskoOsoblje> AddInclude(IQueryable<Database.MedicinskoOsoblje> query, MedicinskoOsobljeSearchObject? search = null)
        {
            if (search?.IncludeSpol == true)
            {
                query = query.Include("Spol");
            }

            if (search?.IncludeZvanje == true)
            {
                query = query.Include("Zvanje");
            }

            return base.AddInclude(query, search);
        }
    }
}
