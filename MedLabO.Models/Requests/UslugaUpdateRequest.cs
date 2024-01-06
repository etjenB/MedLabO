using System.ComponentModel.DataAnnotations;

namespace MedLabO.Models.Requests
{
    public class UslugaUpdateRequest
    {
        [Required]
        public string Naziv { get; set; } = null!;

        [Required]
        public string Opis { get; set; } = null!;

        [Required]
        [Range(0.01, double.MaxValue, ErrorMessage = "Cijena mora biti veca od nula.")]
        public decimal Cijena { get; set; }

        [Required]
        [Range(0, int.MaxValue, ErrorMessage = "Vrijednost mora biti pozitivna.")]
        public int TrajanjeUMin { get; set; }

        [Required]
        [Range(0.0f, float.MaxValue, ErrorMessage = "Vrijednost mora biti pozitivna.")]
        public float RezultatUH { get; set; }

        [Required]
        public bool Dostupno { get; set; } = true;

        public byte[]? Slika { get; set; }

        public List<string>? Testovi { get; set; } = new List<string>();
    }
}
