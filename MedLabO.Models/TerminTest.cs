using MedLabO.Models.Test;

namespace MedLabO.Models
{
    public class TerminTest
    {
        public Guid? TerminID { get; set; }
        public Guid? TestID { get; set; }
        public TestWithoutTerminTestovi? Test { get; set; }
        public Guid? RezultatID { get; set; }
        public Rezultat? Rezultat { get; set; }
    }
}
