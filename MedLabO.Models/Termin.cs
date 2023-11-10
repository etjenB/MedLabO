using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models
{
    public class Termin : SoftDeleteEntity
    {
        public Guid TerminID { get; set; }
        public DateTime DTTermina { get; set; }
        public bool? Status { get; set; }
        public string? Napomena { get; set; }
        public string? Odgovor { get; set; }
        public bool Obavljen { get; set; } = false;
        public bool RezultatTermina { get; set; } = false;
        public byte[]? RezultatTerminaPDF { get; set; }
        public ICollection<Usluga> TerminUsluge { get; set; } = new List<Usluga>();
        public ICollection<TerminTest> TerminTestovi { get; set; } = new List<TerminTest>();
        //public string? PacijentID { get; set; }
        //public virtual Pacijent? Pacijent { get; set; }
        //public string? MedicinskoOsobljeID { get; set; }

        //public virtual MedicinskoOsoblje? MedicinskoOsoblje { get; set; }
        //public Guid? RacunID { get; set; }

        //public virtual Racun? Racun { get; set; }
        //public Guid? ZakljucakID { get; set; }

        //public virtual Zakljucak? Zakljucak { get; set; }
    }
}
