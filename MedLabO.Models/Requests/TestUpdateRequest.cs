using System.ComponentModel.DataAnnotations;

namespace MedLabO.Models.Requests
{
    public class TestUpdateRequest
    {
        [Required(AllowEmptyStrings = false)]
        [MinLength(1)]
        [MaxLength(50)]
        public string Naziv { get; set; } = null!;

        [Required(AllowEmptyStrings = false)]
        public string Opis { get; set; } = null!;

        [Range(0.01, double.MaxValue, ErrorMessage = "Cijena mora biti veca od nula.")]
        public decimal Cijena { get; set; }

        public byte[]? Slika { get; set; }

        public string? NapomenaZaPripremu { get; set; }
        public string? TipUzorka { get; set; }
    }
}
