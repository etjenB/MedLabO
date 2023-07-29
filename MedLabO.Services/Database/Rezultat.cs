using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MedLabO.Services.Database
{
    public class Rezultat
    {
        [Key]
        public Guid RezultatID { get; set; } = Guid.NewGuid();

        [Required]
        public DateTime DTRezultata { get; set; } = DateTime.Now;

        [Required]
        public string TestZakljucak { get; set; } = null!;

        [Required]
        public bool Obiljezen { get; set; } = false;

        //Ukoliko je rezultat brojcana vrijednost
        public float? RezFlo { get; set; }

        //Ukoliko je rezultat tekstualna vrijednost
        public string? RezStr { get; set; }

        //Koja je razlika od normalne, ukoliko je uopste ima
        //npr. -1,4, 55 itd.
        //Izracunava se na osnovu RezFlo iz ove klase, MinVrijednost i MaxVrijednost iz TestParametar klase
        //Ukoliko ona postoji Obiljezen = true
        public float? RazlikaOdNormalne { get; set; }

        //public virtual ICollection<TestTerminRezultat> TestTerminRezultati { get; set; } = new List<TestTerminRezultat>();

        //[Key]
        //public Guid TestID { get; set; }
        //public virtual Test Test { get; set; } = null!;
    }
}