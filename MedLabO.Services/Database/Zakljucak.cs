using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MedLabO.Services.Database
{
    public class Zakljucak
    {
        [Key]
        public Guid ZakljucakID { get; set; } = Guid.NewGuid();

        [Required]
        [MaxLength(100, ErrorMessage = "Opis zaključka ne može biti duži od 100 karaktera.")]
        public string Opis { get; set; } = null!;

        [Required]
        [MaxLength(10000, ErrorMessage = "Detaljni opis zaključka ne može biti duži od 10000 karaktera.")]
        public string Detaljno { get; set; } = null!;

        [ForeignKey("Termin")]
        public Guid? TerminID { get; set; }
        public virtual Termin? Termin { get; set; }
    }
}