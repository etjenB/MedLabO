using AutoMapper;
using MedLabO.Models.Requests;
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
    public class TerminService : CRUDService<Models.Termin, Database.Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>, ITerminService
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

            if (search?.IncludeTerminTestoviRezultati == true)
            {
                query = query.Include("TerminUsluge.UslugaTestovi");
            }

            return base.AddInclude(query, search);
        }
    }
}
