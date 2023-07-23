using MedLabO.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services.Database
{
    public class Test
    {
        [Key]
        public Guid TestID { get; set; } = Guid.NewGuid();

        [Required]
        public string Naziv { get; set; } = null!;

        [Required]
        public string Opis { get; set; } = null!;

        [Required]
        [Range(0.01, double.MaxValue, ErrorMessage = "Cijena mora biti veca od nula.")]
        public decimal Cijena { get; set; }

        //NapomenaZaPripremu moze biti npr. Ne jesti nista minimalno 6h prije nalaza itd.
        public string? NapomenaZaPripremu { get; set; }

        //Tip uzorka moze biti npr. Krv, Urin, Sluz itd.
        public string? TipUzorka { get; set; }

        [Required]
        public DateTime DTKreiranja { get; set; } = DateTime.Now;

        public virtual ICollection<Termin> TestTermini { get; set; } = new List<Termin>();
        public virtual ICollection<Usluga> TestUsluge { get; set; } = new List<Usluga>();

        //Foreign Key na tabelu Administrator
        [ForeignKey("Administrator")]
        public string? AdministratorID { get; set; }
        public virtual Administrator? Administrator { get; set; } = null!;

        [ForeignKey("TestParametar")]
        public Guid? TestParametarID { get; set; }
        public virtual TestParametar? TestParametar { get; set; } = null!;

        [ForeignKey("Rezultat")]
        public Guid? RezultatID { get; set; }
        //[InverseProperty("Test")]
        public virtual Rezultat? Rezultat { get; set; }

    }
}
