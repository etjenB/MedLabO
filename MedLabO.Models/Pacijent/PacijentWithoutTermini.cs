using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models.Pacijent
{
    public class PacijentWithoutTermini : ApplicationUser
    {
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public DateTime? DatumRodjenja { get; set; }
        public string? Adresa { get; set; }
        public int? SpolID { get; set; }
        public Spol? Spol { get; set; }
    }
}
