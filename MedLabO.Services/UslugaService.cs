using AutoMapper;
using MedLabO.Models.Exceptions;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace MedLabO.Services
{
    public class UslugaService : CRUDService<Models.Usluga.Usluga, Database.Usluga, UslugaSearchObject, UslugaInsertRequest, UslugaUpdateRequest>, IUslugaService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public UslugaService(MedLabOContext db, IMapper mapper, IHttpContextAccessor httpContextAccessor) : base(db, mapper)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task<ICollection<Models.Usluga.UslugaBasicData>?> GetUslugeBasicData()
        {
            List<Database.Usluga> usluge = await _db.Usluge.ToListAsync();
            return _mapper.Map<List<Models.Usluga.UslugaBasicData>>(usluge);
        }

        public async Task<ICollection<Models.Usluga.Usluga>?> GetUslugeByTerminId(Guid terminId)
        {
            var termin = await _db.Termini.Include(t=>t.TerminUsluge).FirstOrDefaultAsync(t => t.TerminID == terminId);
            if (termin == null) throw new EntityNotFoundException("Termin nije pronađen.");
            List<Database.Usluga> usluge = new List<Database.Usluga>();
            foreach (var tu in termin.TerminUsluge)
            {
                usluge.Add(await _db.Usluge.Include(u=>u.UslugaTestovi).FirstOrDefaultAsync(u => u.UslugaID == tu.UslugaID));
            }
            return _mapper.Map<List<Models.Usluga.Usluga>>(usluge);
        }

        public override async Task BeforeInsert(Database.Usluga entity, UslugaInsertRequest insert)
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
                throw new UserException("Unable to insert Usluga.");
            }

            foreach (var testID in insert.Testovi)
            {
                var test = await _db.Testovi.FirstOrDefaultAsync(t => t.TestID.ToString() == testID);
                if (test == null) throw new EntityNotFoundException("Test not found");
                entity.UslugaTestovi.Add(test);
            }
        }

        public override async Task BeforeUpdate(Database.Usluga entity, UslugaUpdateRequest insert)
        {
            try
            {
                entity.DTZadnjeModifikacije = DateTime.Now;

                string? currentUserId = _httpContextAccessor?.HttpContext?.User?.FindFirst(ClaimTypes.Name)?.Value;
                if (string.IsNullOrEmpty(currentUserId))
                {
                    throw new UserException("User ID not found.");
                }

                entity.AdministratorID = Guid.Parse(currentUserId);
            }
            catch
            {
                throw new UserException("Unable to update Usluga.");
            }

            var updatedEntity = await _db.Usluge.Include(u => u.UslugaTestovi).SingleOrDefaultAsync(u => u.UslugaID == entity.UslugaID);
            if (updatedEntity == null)
            {
                throw new EntityNotFoundException($"Usluga with ID {entity.UslugaID} not found.");
            }

            var currentTestIds = updatedEntity.UslugaTestovi?.Select(t => t.TestID.ToString()).ToList() ?? new List<string>();

            var testsToRemove = currentTestIds.Except(insert.Testovi ?? Enumerable.Empty<string>()).ToList();

            var testsToAdd = (insert.Testovi ?? Enumerable.Empty<string>()).Except(currentTestIds).ToList();

            foreach (var testId in testsToRemove)
            {
                var testToRemove = updatedEntity.UslugaTestovi?.First(t => t.TestID.ToString() == testId);
                if (testToRemove != null)
                {
                    updatedEntity.UslugaTestovi?.Remove(testToRemove);
                }
            }

            var testsEntitiesToAdd = await _db.Testovi.Where(t => testsToAdd.Contains(t.TestID.ToString())).ToListAsync();

            foreach (var test in testsEntitiesToAdd)
            {
                updatedEntity.UslugaTestovi?.Add(test);
            }
        }

        public override IQueryable<Database.Usluga> AddFilter(IQueryable<Database.Usluga> query, UslugaSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                query = query.Where(t => t.Naziv.StartsWith(search.Naziv));
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Database.Usluga> AddInclude(IQueryable<Database.Usluga> query, UslugaSearchObject? search = null)
        {
            if (search?.IncludeAdministrator == true)
            {
                query = query.Include("Administrator");
            }

            if (search?.IncludeTestovi == true)
            {
                query = query.Include("UslugaTestovi");
            }

            return base.AddInclude(query, search);
        }
    }
}
