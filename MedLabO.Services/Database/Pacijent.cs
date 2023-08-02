using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations;

namespace MedLabO.Services.Database
{
    public class Pacijent : ApplicationUser
    {
        //[Key]
        //public Guid PacijentID { get; set; } = Guid.NewGuid();

        [Required]
        public string? Ime { get; set; }

        [Required]
        public string? Prezime { get; set; }

        //Pokusao sam koristiti DateOnly, novi tip podatka koji je dosao sa .net 7, ali entity framework jos uvijek ne podrzava koristenje tog tipa podatka
        //[Required]
        //public DateOnly DatumRodjenja { get; set; }
        [Required]
        public DateTime DatumRodjenja { get; set; }

        public string? Adresa { get; set; }

        public string? Spol { get; set; }

        //Lista svih termina pacijenta
        public virtual ICollection<Termin> Termini { get; set; } = new List<Termin>();
    }
}