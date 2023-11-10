using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services.Database
{
    public abstract class SoftDeleteEntity
    {
        public bool isDeleted { get; set; } = false;
    }
}
