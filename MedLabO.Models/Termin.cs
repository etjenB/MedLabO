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
        [MaxLength(300, ErrorMessage = "Maksimalna dužina napomene je 300 karaktera.")]
        public string? Napomena { get; set; }
        [MaxLength(300, ErrorMessage = "Maksimalna dužina odgovora je 300 karaktera.")]
        public string? Odgovor { get; set; }
        [MaxLength(300, ErrorMessage = "Maksimalna dužina razloga otkazivanja je 300 karaktera.")]
        public string? RazlogOtkazivanja { get; set; }
        public bool Obavljen { get; set; } = false;
        public bool RezultatDodan { get; set; }
        public bool ZakljucakDodan { get; set; }
        public bool Placeno { get; set; }
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
