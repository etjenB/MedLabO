using System.ComponentModel.DataAnnotations.Schema;

namespace MedLabO.Services.Database
{
    public class TerminTest
    {
        public Guid? TestID { get; set; }
        public Guid? TerminID { get; set; }

        public Test? Test { get; set; }
        public Termin? Termin { get; set; }

        [ForeignKey("Rezultat")]
        public Guid? RezultatID { get; set; }

        public Rezultat? Rezultat { get; set; } = null!;
    }
}