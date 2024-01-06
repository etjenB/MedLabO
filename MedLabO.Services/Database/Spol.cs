using System.ComponentModel.DataAnnotations;

namespace MedLabO.Services.Database
{
    public class Spol
    {
        [Key]
        public int SpolID { get; set; }
        [Required]
        public string Kod { get; set; } = null!;
        [Required]
        public string Naziv { get; set; } = null!;
    }
}
