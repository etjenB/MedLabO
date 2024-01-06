
namespace MedLabO.Models.Usluga
{
    public class Usluga
    {
        public int UslugaID { get; set; }
        public string Naziv { get; set; }
        public string Opis { get; set; }
        public decimal Cijena { get; set; }
        public int TrajanjeUMin { get; set; }
        public float RezultatUH { get; set; }
        public bool Dostupno { get; set; }
        public DateTime DTKreiranja { get; set; }
        public DateTime? DTZadnjeModifikacije { get; set; }
        public byte[]? Slika { get; set; }
        public ICollection<Test.Test> UslugaTestovi { get; set; } = new List<Test.Test>();
        public string? AdministratorID { get; set; }
        public Administrator? Administrator { get; set; }
    }
}