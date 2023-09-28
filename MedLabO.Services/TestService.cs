using AutoMapper;
using MedLabO.Models;
using MedLabO.Models.Exceptions;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace MedLabO.Services
{
    public class TestService : CRUDService<Models.Test, Database.Test, TestSearchObject, TestInsertRequest, TestUpdateRequest>, ITestService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public TestService(MedLabOContext db, IMapper mapper, IHttpContextAccessor httpContextAccessor) : base(db, mapper)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task<Models.Test> ChangeName(Guid Id, string newName)
        {
            var test = await _db.FindAsync<Database.Test>(Id);
            if (test == null)
            {
                throw new UserException("Test not found.");
            }

            test.Naziv = newName;
            await _db.SaveChangesAsync();
            return _mapper.Map<Models.Test>(test);
        }

        public override async Task BeforeInsert(Database.Test entity, TestInsertRequest insert)
        {
            try
            {
                entity.DTKreiranja = DateTime.Now;
                string? currentUserId = _httpContextAccessor?.HttpContext?.User?.FindFirst(ClaimTypes.Name)?.Value;
                if (string.IsNullOrEmpty(currentUserId))
                {
                    throw new UserException("User ID not found.");
                }
                entity.AdministratorID = Guid.Parse(currentUserId);
            }
            catch
            {
                throw new UserException("Unable to insert Test.");
            }
        }

        public override IQueryable<Database.Test> AddFilter(IQueryable<Database.Test> query, TestSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                query = query.Where(t => t.Naziv.StartsWith(search.Naziv));
            }

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                query = query.Where(t => t.Naziv.Contains(search.FTS));
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Database.Test> AddInclude(IQueryable<Database.Test> query, TestSearchObject? search = null)
        {
            if (search?.IncludeAdministrator == true)
            {
                query = query.Include("Administrator");
            }

            if (search?.IncludeTestParametar == true)
            {
                query = query.Include("TestParametar");
            }

            if (search?.IncludeRezultat == true)
            {
                query = query.Include("TerminTestovi.Rezultat");
            }

            return base.AddInclude(query, search);
        }
    }
}