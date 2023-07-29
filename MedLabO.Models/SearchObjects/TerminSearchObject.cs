using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models.SearchObjects
{
    public class TerminSearchObject : SearchObject
    {
        public bool? Obavljen { get; set; }
        public bool? IncludeRezultat { get; set; }
        //public bool? IncludeAdministrator { get; set; }
        //public bool? IncludeTestParametar { get; set; }
        //public bool? IncludeRezultat { get; set; }
    }
}
