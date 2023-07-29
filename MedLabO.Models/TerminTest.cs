using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models
{
    public class TerminTest
    {
        public Guid? TestID { get; set; }
        public virtual Test? Test { get; set; }
        public Guid? RezultatID { get; set; }
        public virtual Rezultat? Rezultat { get; set; } = null!;
    }
}
