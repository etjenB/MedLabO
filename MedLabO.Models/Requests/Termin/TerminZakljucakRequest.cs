using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models.Requests.Termin
{
    public class TerminZakljucakRequest
    {
        public string Opis { get; set; }
        public string Detaljno { get; set; }
        public Guid TerminID { get; set; }
    }
}
