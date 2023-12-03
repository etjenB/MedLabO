using MedLabO.Models.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public interface IRacunService : IService<Models.Racun, RacunSearchObject>
    {
        Task<Models.Racun> GetRacunByTerminID(string terminID);
    }
}
