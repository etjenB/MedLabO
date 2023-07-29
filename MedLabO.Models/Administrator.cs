namespace MedLabO.Models
{
    public class Administrator
    {
        public string Id { get; set; }
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public bool IsKontakt { get; set; } = false;
        public string? KontaktInfo { get; set; }
    }
}