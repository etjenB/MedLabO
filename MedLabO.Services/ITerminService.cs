using MedLabO.Models.Requests.Termin;
using MedLabO.Models.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public interface ITerminService : ICRUDService<Models.Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>
    {
        Task TerminOdobravanje(TerminOdobravanjeRequest request);
        Task TerminOtkazivanje(TerminOtkazivanjeRequest request);
        Task TerminDodavanjeRezultata(TerminTestRezultatRequest request);
        Task TerminDodavanjeZakljucka(TerminZakljucakRequest request);
    }
}
