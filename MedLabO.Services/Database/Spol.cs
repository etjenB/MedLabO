using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
