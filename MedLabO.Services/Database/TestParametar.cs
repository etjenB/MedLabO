using System.ComponentModel.DataAnnotations;

namespace MedLabO.Services.Database
{
    public class TestParametar
    {
        [Key]
        public Guid TestParametarID { get; set; } = Guid.NewGuid();

        //Ukoliko postoji minimalna referentna vrijednost za odredjeni test
        public float? MinVrijednost { get; set; }

        //Ukoliko postoji maksimalna referentna vrijednost za odredjeni test
        public float? MaxVrijednost { get; set; }

        //Ukoliko je normalna referentna vrijednost npr. neg, bistar itd.
        public string? NormalnaVrijednost { get; set; }

        //Mjerne jedinice npr. umol/L, g/L, pg itd.
        public string? Jedinica { get; set; }
    }
}