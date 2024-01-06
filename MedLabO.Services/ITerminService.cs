using MedLabO.Models.Requests.Termin;
using MedLabO.Models.SearchObjects;
using MedLabO.Models.Termin;

namespace MedLabO.Services
{
    public interface ITerminService : ICRUDService<Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest, Guid>
    {
        Task<ICollection<TerminMinimal>> GetTerminiOfTheDay(DateTime day);
        Task TerminOdobravanje(TerminOdobravanjeRequest request);
        Task TerminOtkazivanje(TerminOtkazivanjeRequest request);
        Task TerminDodavanjeRezultata(TerminTestRezultatRequest request);
        Task TerminDodavanjeZakljucka(TerminZakljucakRequest request);
    }
}
