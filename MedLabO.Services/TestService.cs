using AutoMapper;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.EntityFrameworkCore;

namespace MedLabO.Services
{
    public class TestService : Service<Models.Test, Database.Test, TestSearchObject>, ITestService
    {
        public TestService(MedLabOContext db, IMapper mapper) : base(db, mapper)
        {
        }

        public override IQueryable<Test> AddFilter(IQueryable<Test> query, TestSearchObject? search = null)
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

        public override IQueryable<Test> AddInclude(IQueryable<Test> query, TestSearchObject? search = null)
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