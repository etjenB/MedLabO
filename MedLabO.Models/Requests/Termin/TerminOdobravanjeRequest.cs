
namespace MedLabO.Models.Requests.Termin
{
    public class TerminOdobravanjeRequest
    {
        public Guid TerminID { get; set; }
        public string? Odgovor { get; set; }
        public bool Status { get; set; } = false;
    }
}
