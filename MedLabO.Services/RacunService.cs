using AutoMapper;
using MedLabO.Models.Exceptions;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.EntityFrameworkCore;

namespace MedLabO.Services
{
    public class RacunService : Service<Models.Racun, Database.Racun, RacunSearchObject>, IRacunService
    {
        public RacunService(MedLabOContext db, IMapper mapper) : base(db, mapper)
        {

        }

        public async Task<Models.Racun> GetRacunByTerminID(string terminID)
        {
            var racun = await _db.Racuni.FirstOrDefaultAsync(r => r.TerminID.ToString().ToUpper() == terminID.ToUpper());
            if (racun == null) throw new EntityNotFoundException("Racun nije pronađen.");
            return _mapper.Map<Models.Racun>(racun);
        }
    }
}
