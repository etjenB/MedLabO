using System.ComponentModel.DataAnnotations;

namespace MedLabO.Services.Database
{
    public class Racun
    {
        //[Key]
        //public Guid RacunID { get; set; } = Guid.NewGuid();

        [Required]
        [Range(0.01, double.MaxValue, ErrorMessage = "Cijena mora biti veca od nula.")]
        public decimal Cijena { get; set; }

        [Required]
        public bool Placeno { get; set; } = false;

        [Key]
        public Guid TerminID { get; set; }

        public virtual Termin Termin { get; set; } = null!;
    }
}