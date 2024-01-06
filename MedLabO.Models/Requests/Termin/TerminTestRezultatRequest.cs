
namespace MedLabO.Models.Requests.Termin
{
    public class TerminTestRezultatRequest
    {
        public Guid TerminID { get; set; }
        public List<string> TestIDs { get; set; }
        public List<Rezultat> Rezultati { get; set; }
    }
}
