
namespace MedLabO.Models.Requests.Termin
{
    public class TerminUpdateRequest
    {
        public bool? Status { get; set; }
        public string? Odgovor { get; set; }
        public bool Obavljen { get; set; } = false;
        public bool PrijemZavrsen { get; set; } = false;
        public byte[]? RezultatTerminaPDF { get; set; }
    }
}
