using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models.SearchObjects
{
    public class SoftDeleteSearchObject : SearchObject
    {
        public bool IncludeSoftDeleted { get; set; } = false;
    }
}
