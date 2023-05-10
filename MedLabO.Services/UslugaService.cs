using MedLabO.Models;
using MedLabO.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public class UslugaService : IUslugaService
    {
        
        private readonly MedLabOContext _db;

        public UslugaService(MedLabOContext db)
        {
            _db = db;
        }

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
            return _db.Usluge.ToList();
        }
    }
}
