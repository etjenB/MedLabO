using System.ComponentModel.DataAnnotations;

namespace MedLabO.Models.Requests
{
    public class TestInsertRequest
    {
        [Required(AllowEmptyStrings = false)]
        [MinLength(1)]
        [MaxLength(50)]
        public string Naziv { get; set; } = null!;

        [Required(AllowEmptyStrings = false)]
        public string Opis { get; set; } = null!;

        [Range(0.01, double.MaxValue, ErrorMessage = "Cijena field must be greater than zero.")]
        public decimal Cijena { get; set; }

        public string? NapomenaZaPripremu { get; set; }
        public string? TipUzorka { get; set; }
        public DateTime DTKreiranja { get; set; } = DateTime.Now;

        [Required]
        public string AdministratorID { get; set; }

        [Required]
        public string TestParametarID { get; set; }
    }
}
