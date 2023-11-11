using MedLabO.Models.Test;
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
        public Guid? TerminID { get; set; }
        public Guid? TestID { get; set; }
        public TestWithoutTerminTestovi? Test { get; set; }
        public Guid? RezultatID { get; set; }
        public Rezultat? Rezultat { get; set; }
    }
}
