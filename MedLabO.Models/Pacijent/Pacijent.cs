﻿
namespace MedLabO.Models.Pacijent
{
    public class Pacijent : ApplicationUser
    {
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public DateTime? DatumRodjenja { get; set; }
        public string? Adresa { get; set; }
        public ICollection<Termin.Termin>? Termini { get; set; } = new List<Termin.Termin>();
        public int? SpolID { get; set; }
        public Spol? Spol { get; set; }
    }
}
