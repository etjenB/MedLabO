using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models
{
    public class Spol
    {
        public int? SpolID { get; set; }
        public string? Kod { get; set; }
        public string? Naziv { get; set; }
    }
}
