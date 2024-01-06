
namespace MedLabO.Models.Test
{
    public class TestWithoutTerminTestovi
    {
        public string TestID { get; set; }
        public string Naziv { get; set; }
        public string Opis { get; set; }
        public decimal Cijena { get; set; }
        public byte[]? Slika { get; set; }
        public string? NapomenaZaPripremu { get; set; }
        public string? TipUzorka { get; set; }
        public DateTime DTKreiranja { get; set; }
        public string? AdministratorID { get; set; }
        public virtual Administrator? Administrator { get; set; }
        public string? TestParametarID { get; set; }
        public virtual TestParametar? TestParametar { get; set; }
    }
}
