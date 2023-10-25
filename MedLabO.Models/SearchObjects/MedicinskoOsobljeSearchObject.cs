using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models.SearchObjects
{
    public class MedicinskoOsobljeSearchObject : SearchObject
    {
        public string? ImePrezime { get; set; }
        public bool? IncludeSpol { get; set; }
        public bool? IncludeZvanje { get; set; }
    }
}
