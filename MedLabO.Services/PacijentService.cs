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
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public class PacijentService : CRUDService<Models.Pacijent.PacijentWithoutTermini, Database.Pacijent, PacijentSearchObject, PacijentRegistrationRequest, PacijentUpdateRequest>, IPacijentService
    {
        private UserManager<Database.ApplicationUser> _userManager;
        private MedLabOContext _dbContext;

        public PacijentService(MedLabOContext db, IMapper mapper, UserManager<Database.ApplicationUser> userManager) : base(db, mapper)
        {
            _userManager = userManager;
            _dbContext = db;
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
            catch
            {
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
            catch
            {
                throw new UserException("Unable to update Pacijent.");
            }
        }
    }
}
