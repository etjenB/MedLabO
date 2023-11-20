using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
