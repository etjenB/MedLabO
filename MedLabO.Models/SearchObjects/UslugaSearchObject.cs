using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models.SearchObjects
{
    public class UslugaSearchObject : SearchObject
    {
        public string? Naziv { get; set; }
        public bool? IncludeTestovi { get; set; }
        public bool? IncludeAdministrator { get; set; }
    }
}
