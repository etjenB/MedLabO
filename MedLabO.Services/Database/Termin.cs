﻿using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MedLabO.Services.Database
{
    public class Termin : SoftDeleteEntity
    {
        [Key]
        public Guid TerminID { get; set; } = Guid.NewGuid();

        [Required]
        public DateTime DTTermina { get; set; }

        //Ako je null znaci da je pending request, false znaci odbijeno, a true znaci prihvaceno
        public bool? Status { get; set; }

        //Napomenu navodi pacijent ukoliko zeli
        [MaxLength(300)]
        public string? Napomena { get; set; }

        //Odgovor unose zaposlenici laboratorija
        [MaxLength(300)]
        public string? Odgovor { get; set; }

        [MaxLength(300)]
        public string? RazlogOtkazivanja { get; set; }

        [Required]
        public bool Obavljen { get; set; } = false;

        public bool RezultatDodan { get; set; } = false;

        public bool ZakljucakDodan { get; set; } = false;

        public bool Placeno { get; set; } = false;

        public byte[]? RezultatTerminaPDF { get; set; }

        public virtual ICollection<Usluga> TerminUsluge { get; set; } = new List<Usluga>();
        public virtual ICollection<TerminTest> TerminTestovi { get; set; } = new List<TerminTest>();

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