using MedLabO.Models;
using MedLabO.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public class AdministratorService : IAdministratorService
    {
        private readonly MedLabOContext _db;

        public AdministratorService(MedLabOContext db)
        {
            _db = db;
        }

        public IList<Models.Administrator> Get()
        {
            var entityList = _db.Administratori.ToList();
            var list = new List<Models.Administrator>();
            foreach (var item in entityList)
            {
                list.Add(new Models.Administrator() { 
                    Ime = item.Ime,
                    Prezime = item.Prezime,
                    IsKontakt = item.IsKontakt, 
                    KontaktInfo = item.KontaktInfo 
                });
            }
            return list;
        }
    }
}
