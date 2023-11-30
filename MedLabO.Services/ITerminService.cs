using MedLabO.Models.Requests.Termin;
using MedLabO.Models.SearchObjects;
using MedLabO.Models.Termin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public interface ITerminService : ICRUDService<Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>
    {
        Task<ICollection<TerminMinimal>> GetTerminiOfTheDay(DateTime day);
        Task TerminOdobravanje(TerminOdobravanjeRequest request);
        Task TerminOtkazivanje(TerminOtkazivanjeRequest request);
        Task TerminDodavanjeRezultata(TerminTestRezultatRequest request);
        Task TerminDodavanjeZakljucka(TerminZakljucakRequest request);
    }
}
