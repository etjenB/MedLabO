using MedLabO.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public class UslugaService : IUslugaService
    {
        List<Usluga> Usluge = new List<Usluga>()
        {
            new Usluga()
            {
                UslugaID = new Guid(),
                Naziv = "Lipidni test",
                Opis = "Nalaz na masti",
                 Cijena = 20,
                  Dostupno = true,
                   DTKreiranja = new DateTime(2001, 12, 11),
                    RezultatUH = 24,
                     TrajanjeUMin = 15,
                      AdministratorID = null
            }
        };

        public IList<Usluga> Get()
        {
            return Usluge;
        }
    }
}
