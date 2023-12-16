using AutoMapper;
using MedLabO.Models.Exceptions;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Models.Usluga;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using RabbitMQ.Client;
using System.Security.Claims;
using System.Text;
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

        public async Task<int?> GetPacijentLastChosenUsluga()
        {
            var userId = _httpContextAccessor?.HttpContext?.User?.FindFirst(ClaimTypes.Name)?.Value;
            if (string.IsNullOrEmpty(userId))
            {
                throw new UserException("User ID not found.");
            }
            foreach (var t in _db.Termini.Where(t=>t.PacijentID.ToString() == userId && t.DTTermina > DateTime.Now).OrderBy(t => t.DTTermina).Include(t=>t.TerminUsluge))
            {
                if (t.TerminUsluge!=null && t.TerminUsluge.Count > 0)
                {
                    return t.TerminUsluge.First().UslugaID;
                }
            }
            return null;
        }

        public async Task<ICollection<Models.Usluga.UslugaBasicData>?> GetMostPopularUslugas()
        {
            var popularUslugas = await _db.Termini
                              .SelectMany(t => t.TerminUsluge)
                              .GroupBy(u => u.UslugaID)
                              .Select(group => new
                              {
                                  Usluga = group.FirstOrDefault(),
                                  Count = group.Count()
                              })
                              .OrderByDescending(x => x.Count)
                              .ToListAsync();

            var result = popularUslugas.Select(x =>
            {
                var mapped = _mapper.Map<UslugaBasicData>(x.Usluga);
                mapped.OccurrenceCount = x.Count;
                return mapped;
            }).ToList();

            return result;
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

            if (search?.IncludeTestovi == true)
            {
                query = query.Include("UslugaTestovi");
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

        static MLContext mlContext = null;
        static object isLocked = new object();
        static ITransformer model = null;

        public async Task<List<Models.Usluga.Usluga>> Recommend(int? uslugaId)
        {
            lock (isLocked)
            {
                if (mlContext == null)
                {
                    mlContext = new MLContext();
                    var tmpData = _db.Termini.Include(t => t.TerminUsluge).ToList();

                    var data = new List<ProductEntry>();

                    foreach (var t in tmpData)
                    {
                        if (t.TerminUsluge.Count > 1)
                        {
                            var distinctItemId = t.TerminUsluge.Select(tu => tu.UslugaID).ToList();

                            distinctItemId.ForEach(u =>
                            {
                                var relatedItems = t.TerminUsluge.Where(ou => ou.UslugaID != u);

                                foreach (var ri in relatedItems)
                                {
                                    data.Add(new ProductEntry() { ProductID = (uint)u, CoPurchaseProductID = (uint)ri.UslugaID});
                                }
                            });
                        }
                    }

                    var traindata = mlContext.Data.LoadFromEnumerable(data);

                    MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                    options.MatrixColumnIndexColumnName = nameof(ProductEntry.ProductID);
                    options.MatrixRowIndexColumnName = nameof(ProductEntry.CoPurchaseProductID);
                    options.LabelColumnName = "Label";
                    options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                    options.Alpha = 0.01;
                    options.Lambda = 0.025;

                    options.NumberOfIterations = 100;
                    options.C = 0.00001;

                    var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                    model = est.Fit(traindata);
                }
            }

            var usluge = _db.Usluge.Where(u => u.UslugaID != uslugaId);

            var predictionResult = new List<Tuple<Database.Usluga, float>>();

            foreach (var u in usluge)
            {
                var predictionengine = mlContext.Model.CreatePredictionEngine<ProductEntry, Copurchase_prediction>(model);
                var prediction = predictionengine.Predict(new ProductEntry() { ProductID = (uint)uslugaId, CoPurchaseProductID = (uint)u.UslugaID });

                predictionResult.Add(new Tuple<Database.Usluga, float>(u, prediction.Score));
            }

            var finalResult = predictionResult.OrderByDescending(u=>u.Item2).Take(3).Select(u=>u.Item1).ToList();

            return _mapper.Map<List<Models.Usluga.Usluga>>(finalResult);
        }
    }
}

public class Copurchase_prediction
{
    public float Score { get; set; }
}

public class ProductEntry
{
    [KeyType(count: 20)]
    public uint ProductID { get; set; }
    [KeyType(count: 20)]
    public uint CoPurchaseProductID { get; set; }

    public float Label { get; set; }
}