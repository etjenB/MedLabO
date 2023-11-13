using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models.Requests.Termin
{
    public class TerminOtkazivanjeRequest
    {
        public Guid TerminID { get; set; }
        public string? RazlogOtkazivanja { get; set; }
    }
}
