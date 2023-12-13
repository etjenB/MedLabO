using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models.Test
{
    public class TestBasicData
    {
        public string TestID { get; set; }
        public string Naziv { get; set; }
        public string Opis { get; set; }
        public decimal Cijena { get; set; }
        public string? NapomenaZaPripremu { get; set; }
        public string? TipUzorka { get; set; }
        public DateTime DTKreiranja { get; set; }
        public string? AdministratorID { get; set; }
        public string? TestParametarID { get; set; }

        public int? OccurrenceCount { get; set; }
    }
}
