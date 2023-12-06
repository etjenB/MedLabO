using AutoMapper;
using iText.Kernel.Pdf;
using iText.Layout.Element;
using MedLabO.Models.Exceptions;
using MedLabO.Models.Requests.Termin;
using MedLabO.Models.SearchObjects;
using MedLabO.Models.Termin;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using iText.Layout;

namespace MedLabO.Services
{
    public class TerminService : CRUDService<Models.Termin.Termin, Database.Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>, ITerminService
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public TerminService(MedLabOContext db, IMapper mapper, IHttpContextAccessor httpContextAccessor) : base(db, mapper)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task<ICollection<TerminMinimal>> GetTerminiOfTheDay(DateTime day)
        {
            List<Database.Termin> termini = await _db.Termini.Where(t => t.DTTermina.Date == day.Date && t.isDeleted == false).ToListAsync();
            return _mapper.Map<List<TerminMinimal>>(termini);
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

        public async Task TerminOtkazivanje(TerminOtkazivanjeRequest request)
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
                termin.Status = false;
                termin.RazlogOtkazivanja = request.RazlogOtkazivanja;
                termin.isDeleted = true;

                _db.Termini.Update(termin);
                await _db.SaveChangesAsync();
            }
            catch
            {
                throw new UserException("Usljed greške termin nije otkazan.");
            }
        }

        public async Task TerminDodavanjeRezultata(TerminTestRezultatRequest request)
        {
            using (var transaction = await _db.Database.BeginTransactionAsync())
            {
                try
                {
                    if (request == null || request.TestIDs == null || request.Rezultati == null)
                    {
                        throw new UserException("Dodavanje rezultata nije moguće.");
                    }

                    var termin = await _db.Termini.FirstOrDefaultAsync(t => t.TerminID == request.TerminID);

                    if (termin == null)
                    {
                        throw new EntityNotFoundException("Termin ne postoji.");
                    }

                    var counter = 0;
                    foreach (var testID in request.TestIDs)
                    {
                        var terminTest = await _db.TerminTest.FirstOrDefaultAsync(tt => tt.TestID.ToString() == testID && tt.TerminID == request.TerminID);
                        var test = await _db.Testovi.Include(t => t.TestParametar).FirstOrDefaultAsync(t => t.TestID.ToString() == testID);
                        if (test == null) throw new EntityNotFoundException("Test ne postoji.");
                        if (test.TestParametar == null) throw new UserException("Test parametar za dati test ne postoji.");

                        var rezultat = request.Rezultati[counter];
                        rezultat.DTRezultata = DateTime.Now;
                        if (rezultat.RezFlo != null &&
                            test.TestParametar.MinVrijednost != null &&
                            rezultat.RezFlo < test.TestParametar.MinVrijednost)
                        {
                            rezultat.RazlikaOdNormalne = rezultat.RezFlo - test.TestParametar.MinVrijednost;
                            rezultat.Obiljezen = true;
                        }
                        else if (rezultat.RezFlo != null &&
                            test.TestParametar.MaxVrijednost != null &&
                            rezultat.RezFlo > test.TestParametar.MaxVrijednost)
                        {
                            rezultat.RazlikaOdNormalne = rezultat.RezFlo - test.TestParametar.MaxVrijednost;
                            rezultat.Obiljezen = true;
                        }

                        if (terminTest != null)
                        {
                            terminTest.Rezultat = _mapper.Map<Database.Rezultat>(rezultat);
                        }
                        else
                        {
                            await _db.TerminTest.AddAsync(new TerminTest() { TerminID = request.TerminID, TestID = Guid.Parse(testID), Rezultat = _mapper.Map<Database.Rezultat>(rezultat) });
                        }
                        termin.RezultatDodan = true;
                        await _db.SaveChangesAsync();
                        counter++;
                    }

                    await StorePdfInDatabase(request.TerminID);

                    await transaction.CommitAsync();
                }
                catch
                {
                    await transaction.RollbackAsync();
                    throw new UserException("Rezultati nisu dodani zbog greške.");
                }
            }
        }

        public async Task TerminDodavanjeZakljucka(TerminZakljucakRequest request)
        {
            if (request == null)
            {
                throw new UserException("Dodavanje zaključka nije moguće.");
            }

            var termin = await _db.Termini.FirstOrDefaultAsync(t => t.TerminID == request.TerminID);
            if (termin == null) throw new EntityNotFoundException("Termin nije pronađen.");
            try
            {
                var zakljucak = await _db.Zakljucci.AddAsync(new Zakljucak { TerminID = request.TerminID, Opis = request.Opis, Detaljno = request.Detaljno });
                termin.Zakljucak = zakljucak.Entity;
                termin.ZakljucakDodan = true;
                _db.Termini.Update(termin);
                await _db.SaveChangesAsync();
            }
            catch (Exception e)
            {
                throw new UserException(e.Message);
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
                entity.Placeno = true;
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

        public override async Task AfterInsert(Database.Termin entity, TerminInsertRequest insert)
        {
            decimal ukupnaCijena = 0;

            foreach (var uslugaID in insert.Usluge)
            {
                var usluga = await _db.Usluge.FirstOrDefaultAsync(t => t.UslugaID.ToString() == uslugaID);
                if (usluga == null) throw new EntityNotFoundException("Usluga not found");
                ukupnaCijena += usluga.Cijena;
            }

            foreach (var testID in insert.Testovi)
            {
                var test = await _db.Testovi.FirstOrDefaultAsync(t => t.TestID.ToString() == testID);
                if (test == null) throw new EntityNotFoundException("Test not found");
                var terminTest = new TerminTest() { TestID = test.TestID, TerminID = entity.TerminID };
                ukupnaCijena += test.Cijena;
            }

            try
            {
                var racun = new Racun() { Cijena = ukupnaCijena, Placeno = true, TerminID = entity.TerminID };
                await _db.Racuni.AddAsync(racun);

                entity.Racun = racun;

                await _db.SaveChangesAsync();
            }
            catch (Exception e)
            {

                throw new UserException(e.Message);
            }
        }

        public override IQueryable<Database.Termin> AddFilter(IQueryable<Database.Termin> query, TerminSearchObject? search = null)
        {
            if (search?.Obavljen == true)
            {
                query = query.Where(t => t.Obavljen == true);
            }
            else
            {
                query = query.Where(t => t.Obavljen == false);
            }

            if (search?.Finaliziran == true)
            {
                query = query.Where(t => t.ZakljucakDodan != false && t.Placeno != false && t.RezultatDodan != false);
            }

            if (search?.UObradi == true)
            {
                query = query.Where(t => t.ZakljucakDodan == false || t.Placeno == false || t.RezultatDodan == false);
            }

            if (search?.Odobren == true)
            {
                query = query.Where(t => t.Status == true);
            }

            if (search?.NaCekanju == true)
            {
                query = query.Where(t => t.Status == null);
            }

            if (search?.Obrisan == true)
            {
                query = query.Where(t => t.isDeleted == true);
            }

            if (search?.TerminiInFuture == true)
            {
                query = query.Where(t => t.DTTermina.Date > DateTime.Now.Date);
            }

            if (search?.TerminiToday == true)
            {
                query = query.Where(t => t.DTTermina.Date == DateTime.Now.Date);
            }

            if (search?.TerminiBefore == true)
            {
                query = query.Where(t => t.DTTermina.Date < DateTime.Now.Date);
            }

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                query = query.Where(t => (t.Pacijent != null && t.Pacijent.Ime != null && t.Pacijent.Ime.StartsWith(search.FTS)) || (t.Pacijent != null && t.Pacijent.Prezime != null && t.Pacijent.Prezime.StartsWith(search.FTS)));
            }

            if (!string.IsNullOrWhiteSpace(search?.PacijentId))
            {
                query = query.Where(t => (t.Pacijent != null && t.Pacijent.Id.ToString() == search.PacijentId.ToUpper()));
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Database.Termin> AddInclude(IQueryable<Database.Termin> query, TerminSearchObject? search = null)
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

            if (search?.IncludeTerminMedicinskoOsobljeZvanje == true)
            {
                query = query.Include("MedicinskoOsoblje.Zvanje");
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

        public override IQueryable<Database.Termin> ApplyOrdering(IQueryable<Database.Termin> query, TerminSearchObject? search = null)
        {
            if (search?.OrderByDTTermina == true)
            {
                query = query.OrderBy(t => t.DTTermina);
            }

            return base.AddFilter(query, search);
        }

        #region Private
        private async Task<byte[]> GeneratePdf(Guid terminId)
        {
            var termin = await _db.Termini
                .Include(t => t.TerminTestovi)
                .ThenInclude(tt => tt.Test)
                .ThenInclude(t => t.TestParametar)
                .Include(t => t.TerminTestovi)
                .ThenInclude(tt => tt.Rezultat)
                .FirstOrDefaultAsync(t => t.TerminID == terminId);

            if (termin == null)
            {
                throw new EntityNotFoundException("Termin not found.");
            }

            try
            {
                using (var memoryStream = new MemoryStream())
                {
                    using (var pdfWriter = new PdfWriter(memoryStream))
                    {
                        using (var pdfDocument = new PdfDocument(pdfWriter))
                        {
                            var document = new Document(pdfDocument);

                            document.Add(new Paragraph($"MedLabO Rezultati termina {termin.DTTermina:dd.MM.yyyy. HH:mm}")
                                .SetFontSize(14));

                            Table table = new Table(3, true);

                            table.AddCell(new Cell().Add(new Paragraph("Naziv testa")));
                            table.AddCell(new Cell().Add(new Paragraph("Rezultat")));
                            table.AddCell(new Cell().Add(new Paragraph("Referentne vrijednosti")));

                            foreach (var terminTest in termin.TerminTestovi)
                            {
                                var test = terminTest.Test;
                                var rezultat = terminTest.Rezultat;
                                var testParametar = test.TestParametar;

                                string resultValue = rezultat.RezFlo.HasValue ? rezultat.RezFlo.Value.ToString() :
                                                     rezultat.RezStr ?? string.Empty;
                                if (rezultat.Obiljezen)
                                {
                                    resultValue += "*";
                                }

                                string referenceValue = testParametar.MinVrijednost.HasValue && testParametar.MaxVrijednost.HasValue ?
                                                        $"{testParametar.MinVrijednost} - {testParametar.MaxVrijednost} {testParametar.Jedinica}" :
                                                        $"{testParametar.NormalnaVrijednost} {testParametar.Jedinica}";

                                table.AddCell(new Cell().Add(new Paragraph(test.Naziv)));
                                table.AddCell(new Cell().Add(new Paragraph(resultValue)));
                                table.AddCell(new Cell().Add(new Paragraph(referenceValue)));
                            }

                            document.Add(table);
                            document.Close();
                        }
                    }

                    return memoryStream.ToArray();
                }
            }
            catch
            {
                throw new UserException("Greška pri kreiranju dokumenta.");
            }
            
        }

        private async Task StorePdfInDatabase(Guid terminId)
        {
            var pdfData = await GeneratePdf(terminId);
            var termin = await _db.Termini.FirstOrDefaultAsync(t => t.TerminID == terminId);

            if (termin != null)
            {
                termin.RezultatTerminaPDF = pdfData;
                await _db.SaveChangesAsync();
            }
        }
        #endregion
    }
}
