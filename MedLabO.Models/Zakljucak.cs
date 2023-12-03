using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models
{
    public class Zakljucak
    {
        public string? Opis { get; set; }
        public string? Detaljno { get; set; }
        public string? TerminID { get; set; }
    }
}
