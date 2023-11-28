using AutoMapper;
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
    public class TestService : CRUDService<Models.Test.Test, Database.Test, TestSearchObject, TestInsertRequest, TestUpdateRequest>, ITestService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public TestService(MedLabOContext db, IMapper mapper, IHttpContextAccessor httpContextAccessor) : base(db, mapper)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task<ICollection<Models.Test.TestBasicData>?> GetTestoviBasicData()
        {
            List<Database.Test> testovi = await _db.Testovi.ToListAsync();
            return _mapper.Map<List<Models.Test.TestBasicData>>(testovi);
        }

        public async Task<ICollection<Models.Test.TestWithoutTerminTestovi>?> GetTestoviByTerminId(Guid terminId)
        {
            var terminTestovi = _db.TerminTest.Where(tt => tt.TerminID == terminId);
            if (terminTestovi==null)throw new EntityNotFoundException("Termin nije pronađen.");
            List<Database.Test> testovi = new List<Database.Test>();
            foreach (var tt in terminTestovi)
            {
                testovi.Add(await _db.Testovi.FirstOrDefaultAsync(t => t.TestID == tt.TestID));
            }
            return _mapper.Map<List<Models.Test.TestWithoutTerminTestovi>>(testovi);
        }

        public async Task<ICollection<Models.Test.TestWithoutTerminTestovi>?> GetTestoviByUslugaId(Guid uslugaId)
        {
            var usluga = await _db.Usluge.Include(u => u.UslugaTestovi).FirstOrDefaultAsync(u => u.UslugaID == uslugaId);
            if (usluga == null) throw new EntityNotFoundException("Usluga nije pronađena.");
            List<Database.Test> uslugaTestovi = usluga.UslugaTestovi.ToList();
            return _mapper.Map<List<Models.Test.TestWithoutTerminTestovi>>(uslugaTestovi);
        }

        public async Task<ICollection<Models.Test.TestBasicData>?> GetTestoviBasicDataByUslugaId(Guid uslugaId)
        {
            var usluga = await _db.Usluge.Include(u => u.UslugaTestovi).FirstOrDefaultAsync(u => u.UslugaID == uslugaId);
            if (usluga == null) throw new EntityNotFoundException("Usluga nije pronađena.");
            List<Database.Test> uslugaTestovi = usluga.UslugaTestovi.ToList();
            return _mapper.Map<List<Models.Test.TestBasicData>>(uslugaTestovi);
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