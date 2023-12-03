using AutoMapper;
using MedLabO.Models.Exceptions;
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
    public class ZakljucakService : Service<Models.Zakljucak, Database.Zakljucak, ZakljucakSearchObject>, IZakljucakService
    {
        public ZakljucakService(MedLabOContext db, IMapper mapper) : base(db, mapper)
        {

        }

        public async Task<Models.Zakljucak> GetZakljucakByTerminID(string terminID)
        {
            var zakljucak = await _db.Zakljucci.FirstOrDefaultAsync(z => z.TerminID.ToString().ToUpper() == terminID.ToUpper());
            if (zakljucak == null) throw new EntityNotFoundException("Zakljucak nije pronađen.");
            return _mapper.Map<Models.Zakljucak>(zakljucak);
        }
    }
}
