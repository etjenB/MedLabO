using MedLabO.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services.Database
{
    public class MedLabOContext : IdentityDbContext
    {
        public MedLabOContext(DbContextOptions options) : base(options)
        {

        }

        public DbSet<IdentityUser> Korisnici { get; set; }
        public DbSet<Administrator> Administratori { get; set; }
        public DbSet<MedicinskoOsoblje> MedicinskoOsoblje { get; set; }
        public DbSet<Pacijent> Pacijenti { get; set; }


        public DbSet<Novost> Novosti { get; set; }
        public DbSet<Obavijest> Obavijesti { get; set; }
        public DbSet<Zvanje> Zvanja { get; set; }
        public DbSet<Termin> Termini { get; set; }
        public DbSet<Racun> Racuni { get; set; }
        public DbSet<Zakljucak> Zakljucci { get; set; }
        public DbSet<Rezultat> Rezultati { get; set; }
        public DbSet<Test> Testovi { get; set; }
        public DbSet<TestParametar> TestParametri { get; set; }
        public DbSet<Usluga> Usluge { get; set; }
    }
}
