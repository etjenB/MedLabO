using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models
{
    public class MedicinskoOsoblje : ApplicationUser
    {
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public bool IsActive { get; set; }
        public DateTime DTZaposlenja { get; set; }
        public DateTime? DTPrekidRadnogOdnosa { get; set; }
        public string Spol { get; set; }
        public string? ZvanjeID { get; set; }
        public virtual Zvanje? Zvanje { get; set; }
    }
}
