using System.ComponentModel.DataAnnotations.Schema;

namespace MedLabO.Services.Database
{
    public class TerminTest
    {
        public Guid? TestID { get; set; }
        public Guid? TerminID { get; set; }

        public virtual Test? Test { get; set; }
        public virtual Termin? Termin { get; set; }

        [ForeignKey("Rezultat")]
        public Guid? RezultatID { get; set; }

        public virtual Rezultat? Rezultat { get; set; } = null!;
    }
}