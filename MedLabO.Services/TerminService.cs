using AutoMapper;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public class TerminService : Service<Models.Termin, Database.Termin, TerminSearchObject>, ITerminService
    {
        public TerminService(MedLabOContext db, IMapper mapper) : base(db, mapper)
        {
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

            return base.AddFilter(query, search);
        }

        public override IQueryable<Termin> AddInclude(IQueryable<Termin> query, TerminSearchObject? search = null)
        {

            if (search?.IncludeRezultat == true)
            {
                query = query.Include("TestTerminRezultati.Rezultat");
            }

            return base.AddInclude(query, search);
        }
    }
}
