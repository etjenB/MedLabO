using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services.Database
{
    public class Zakljucak
    {
        //[Key]
        //public Guid ZakljucakID { get; set; } = Guid.NewGuid();

        [Required]
        public string Opis { get; set; } = null!;

        [Required]
        public string Detaljno { get; set; } = null!;

        [Key]
        public Guid TerminID { get; set; }
        public virtual Termin Termin { get; set; } = null!;

    }
}
