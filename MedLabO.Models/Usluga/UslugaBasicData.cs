using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models.Usluga
{
    public class UslugaBasicData
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
        public string? AdministratorID { get; set; }
    }
}
