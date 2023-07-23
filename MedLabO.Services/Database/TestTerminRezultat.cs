using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services.Database
{
    public class TestTerminRezultat
    {
        public Guid TestID { get; set; }
        public Guid TerminID { get; set; }
        public Guid RezultatID { get; set; }

        // Navigation properties
        public virtual Test? Test { get; set; }
        public virtual Termin? Termin { get; set; }
        public virtual Rezultat? Rezultat { get; set; }
    }
}
