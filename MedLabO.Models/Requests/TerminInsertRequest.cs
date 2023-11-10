using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models.Requests
{
    public class TerminInsertRequest
    {
        [Required]
        public DateTime DTTermina { get; set; }
        public string? Napomena { get; set; }


        public List<string>? Usluge { get; set; } = new List<string>();
        public List<string>? Testovi { get; set; } = new List<string>();
    }
}
