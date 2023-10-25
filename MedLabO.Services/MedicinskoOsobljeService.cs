using AutoMapper;
using MedLabO.Models.Constants;
using MedLabO.Models.Exceptions;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public class MedicinskoOsobljeService : CRUDService<Models.MedicinskoOsoblje, Database.MedicinskoOsoblje, MedicinskoOsobljeSearchObject, MedicinskoOsobljeRegistrationRequest, MedicinskoOsobljeUpdateRequest>, IMedicinskoOsobljeService
    {
        private UserManager<Database.ApplicationUser> _userManager;

        public MedicinskoOsobljeService(MedLabOContext db, IMapper mapper, UserManager<Database.ApplicationUser> userManager) : base(db, mapper)
        {
            _userManager = userManager;
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
            catch
            {
                throw new UserException("Unable to register MedicinskoOsoblje.");
            }
        }

        public override async Task BeforeUpdate(Database.MedicinskoOsoblje entity, MedicinskoOsobljeUpdateRequest insert)
        {
            var existingUser = await _userManager.FindByNameAsync(insert.UserName);
            if (existingUser != null && existingUser.Id != insert.Id)
            {
                throw new UserException("Username is already taken.");
            }

            var existingUserByEmail = await _userManager.FindByEmailAsync(insert.Email);
            if (existingUserByEmail != null && existingUserByEmail.Id != insert.Id)
            {
                throw new UserException("Email is already in use.");
            }

            await _userManager.UpdateAsync(entity);
        }

        public override IQueryable<Database.MedicinskoOsoblje> AddFilter(IQueryable<Database.MedicinskoOsoblje> query, MedicinskoOsobljeSearchObject? search = null)
        {
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
