using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services.Database
{
    public class TestParametar
    {
        //[Key]
        //public Guid TestParametarID { get; set; } = Guid.NewGuid();

        //Ukoliko postoji minimalna referentna vrijednost za odredjeni test
        public float? MinVrijednost { get; set; }

        //Ukoliko postoji maksimalna referentna vrijednost za odredjeni test
        public float? MaxVrijednost { get; set; }

        //Ukoliko je normalna referentna vrijednost npr. neg, bistar itd.
        public string? NormalnaVrijednost { get; set; }

        //Mjerne jedinice npr. umol/L, g/L, pg itd.
        public string? Jedinica { get; set; }

        [Key]
        public Guid TestID { get; set; }
        public virtual Test Test { get; set; } = null!;
    }
}
