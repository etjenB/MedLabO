using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MedLabO.Services.Database
{
    public class Pacijent : ApplicationUser
    {
        [Required]
        public string? Ime { get; set; }

        [Required]
        public string? Prezime { get; set; }

        [Required]
        public DateTime DatumRodjenja { get; set; }

        public string? Adresa { get; set; }

        //Lista svih termina pacijenta
        public virtual ICollection<Termin> Termini { get; set; } = new List<Termin>();

        [ForeignKey("Spol")]
        public int? SpolID { get; set; }
        public Spol? Spol { get; set; } = null!;
    }
}