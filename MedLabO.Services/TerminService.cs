using AutoMapper;
using MedLabO.Models.Exceptions;
using MedLabO.Models.Requests.Termin;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public class TerminService : CRUDService<Models.Termin, Database.Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>, ITerminService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public TerminService(MedLabOContext db, IMapper mapper, IHttpContextAccessor httpContextAccessor) : base(db, mapper)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task TerminOdobravanje(TerminOdobravanjeRequest request)
        {
            var termin = await _db.Termini.FirstOrDefaultAsync(t => t.TerminID == request.TerminID);
            if (termin == null)
            {
                throw new EntityNotFoundException("Termin nije pronađen.");
            }

            try
            {
                string? currentUserId = _httpContextAccessor?.HttpContext?.User?.FindFirst(ClaimTypes.Name)?.Value;
                if (string.IsNullOrEmpty(currentUserId))
                {
                    throw new UserException("Korisnik nije pronađen.");
                }
                termin.MedicinskoOsobljeID = Guid.Parse(currentUserId);
                termin.Status = request.Status;
                termin.Odgovor = request.Odgovor;

                if (!request.Status)
                {
                    termin.isDeleted = true;
                }

                _db.Termini.Update(termin);
                await _db.SaveChangesAsync();
            }
            catch
            {
                throw new UserException("Usljed greške termin nije modifikovan.");
            }
        }

        public override async Task BeforeInsert(Database.Termin entity, TerminInsertRequest insert)
        {
            try
            {
                string? currentUserId = _httpContextAccessor?.HttpContext?.User?.FindFirst(ClaimTypes.Name)?.Value;
                if (string.IsNullOrEmpty(currentUserId))
                {
                    throw new UserException("User ID not found.");
                }
                entity.PacijentID = Guid.Parse(currentUserId);
            }
            catch
            {
                throw new UserException("Unable to insert Termin.");
            }

            foreach (var uslugaID in insert.Usluge)
            {
                var usluga = await _db.Usluge.FirstOrDefaultAsync(t => t.UslugaID.ToString() == uslugaID);
                if (usluga == null) throw new EntityNotFoundException("Usluga not found");
                entity.TerminUsluge.Add(usluga);
            }

            foreach (var testID in insert.Testovi)
            {
                var test = await _db.Testovi.FirstOrDefaultAsync(t => t.TestID.ToString() == testID);
                if (test == null) throw new EntityNotFoundException("Test not found");
                var terminTest = new TerminTest() { TestID = test.TestID, TerminID = entity.TerminID };
                entity.TerminTestovi.Add(terminTest);
            }
        }

        public override IQueryable<Termin> AddFilter(IQueryable<Termin> query, TerminSearchObject? search = null)
        {
            if (search?.Obavljen == true)
            {
                query = query.Where(t => t.Obavljen == true);
            }
            else
            {
                query = query.Where(t => t.Obavljen == false);
            }

            if (search?.Odobren == true)
            {
                query = query.Where(t => t.Status == true);
            }

            if (search?.NaCekanju == true)
            {
                query = query.Where(t => t.Status == null);
            }

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                query = query.Where(t => (t.Pacijent != null && t.Pacijent.Ime != null && t.Pacijent.Ime.StartsWith(search.FTS)) || (t.Pacijent != null && t.Pacijent.Prezime != null && t.Pacijent.Prezime.StartsWith(search.FTS)));
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Termin> AddInclude(IQueryable<Termin> query, TerminSearchObject? search = null)
        {

            if (search?.IncludeTerminTestovi == true)
            {
                query = query.Include("TerminTestovi");
            }

            if (search?.IncludeTerminUsluge == true)
            {
                query = query.Include("TerminUsluge");
            }

            if (search?.IncludeTerminTestoviRezultati == true)
            {
                query = query.Include("TerminTestovi.Rezultat");
            }

            if (search?.IncludeTerminTestoviTestovi == true)
            {
                query = query.Include("TerminTestovi.Test");
            }

            if (search?.IncludeTerminUslugeTestovi == true)
            {
                query = query.Include("TerminUsluge.UslugaTestovi");
            }

            if (search?.IncludeTerminPacijent == true)
            {
                query = query.Include("Pacijent");
            }

            if (search?.IncludeTerminPacijentSpol == true)
            {
                query = query.Include("Pacijent.Spol");
            }

            if (search?.IncludeTerminMedicinskoOsoblje == true)
            {
                query = query.Include("MedicinskoOsoblje");
            }

            if (search?.IncludeTerminRacun == true)
            {
                query = query.Include("Racun");
            }

            if (search?.IncludeTerminZakljucak == true)
            {
                query = query.Include("Zakljucak");
            }

            return base.AddInclude(query, search);
        }
    }
}
