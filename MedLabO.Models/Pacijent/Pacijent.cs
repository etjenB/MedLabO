using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models.Pacijent
{
    public class Pacijent : ApplicationUser
    {
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public DateTime? DatumRodjenja { get; set; }
        public string? Adresa { get; set; }
        public ICollection<Termin>? Termini { get; set; } = new List<Termin>();
        public int? SpolID { get; set; }
        public Spol? Spol { get; set; }
    }
}
