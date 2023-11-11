using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MedLabO.Models.Pacijent;

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

        public string? PacijentID { get; set; }
        public PacijentWithoutTermini? Pacijent { get; set; }

        public string? MedicinskoOsobljeID { get; set; }
        public MedicinskoOsoblje? MedicinskoOsoblje { get; set; }

        public string? RacunID { get; set; }
        public Racun? Racun { get; set; }

        public string? ZakljucakID { get; set; }
        public Zakljucak? Zakljucak { get; set; }
    }
}
