using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models
{
    public class Racun
    {
        public decimal? Cijena { get; set; }
        public bool? Placeno { get; set; }
        public string? TerminID { get; set; }
        public Termin.Termin? Termin { get; set; }
    }
}
