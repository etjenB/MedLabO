using System.ComponentModel.DataAnnotations;

namespace MedLabO.Models
{
    public class Rezultat
    {
        public string? RezultatID { get; set; }
        public DateTime? DTRezultata { get; set; }
        [Required]
        public string TestZakljucak { get; set; }
        public bool? Obiljezen { get; set; } = false;
        public float? RezFlo { get; set; }
        public string? RezStr { get; set; }
        public float? RazlikaOdNormalne { get; set; }
    }
}
