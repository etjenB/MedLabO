using System.ComponentModel.DataAnnotations;

namespace MedLabO.Services.Database
{
    public class Zakljucak
    {
        //[Key]
        //public Guid ZakljucakID { get; set; } = Guid.NewGuid();

        [Required]
        public string Opis { get; set; } = null!;

        [Required]
        public string Detaljno { get; set; } = null!;

        [Key]
        public Guid TerminID { get; set; }

        public virtual Termin Termin { get; set; } = null!;
    }
}