using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MedLabO.Services.Database
{
    public class Termin
    {
        [Key]
        public Guid TerminID { get; set; } = Guid.NewGuid();

        [Required]
        public DateTime DTTermina { get; set; }

        //Ako je null znaci da je pending request, false znaci odbijeno, a true znaci prihvaceno
        public bool? Status { get; set; }

        //Napomenu navodi pacijent ukoliko zeli
        public string? Napomena { get; set; }

        //Odgovor unose zaposlenici laboratorija
        public string? Odgovor { get; set; }

        [Required]
        public bool Obavljen { get; set; } = false;

        //Kada se rezultat prebaci u true mora se postaviti RezultatPDF
        [Required]
        public bool RezultatTermina { get; set; } = false;

        public byte[]? RezultatTerminaPDF { get; set; }

        public virtual ICollection<Usluga> TerminUsluge { get; set; } = new List<Usluga>();
        public virtual ICollection<TerminTest> TestTerminRezultati { get; set; } = new List<TerminTest>();

        //[ForeignKey("Pacijent")]
        //public string PacijentID { get; set; }
        //public virtual Pacijent Pacijent { get; set; } = null!;

        [ForeignKey("Pacijent")]
        public Guid? PacijentID { get; set; }

        public virtual Pacijent? Pacijent { get; set; } = null!;

        //Zaposlenik koji je odobrio termin
        [ForeignKey("MedicinskoOsoblje")]
        public Guid? MedicinskoOsobljeID { get; set; }

        public virtual MedicinskoOsoblje? MedicinskoOsoblje { get; set; } = null!;

        [ForeignKey("Racun")]
        public Guid? RacunID { get; set; }

        public virtual Racun? Racun { get; set; } = null!;

        [ForeignKey("Zakljucak")]
        public Guid? ZakljucakID { get; set; }

        public virtual Zakljucak? Zakljucak { get; set; } = null!;
    }
}