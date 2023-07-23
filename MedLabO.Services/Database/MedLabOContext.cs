using MedLabO.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
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

        public virtual DbSet<IdentityUser> Korisnici { get; set; }
        public virtual DbSet<Administrator> Administratori { get; set; }
        public virtual DbSet<MedicinskoOsoblje> MedicinskoOsoblje { get; set; }
        public virtual DbSet<Pacijent> Pacijenti { get; set; }


        public virtual DbSet<Novost> Novosti { get; set; }
        public virtual DbSet<Obavijest> Obavijesti { get; set; }
        public virtual DbSet<Zvanje> Zvanja { get; set; }
        public virtual DbSet<Termin> Termini { get; set; }
        public virtual DbSet<Racun> Racuni { get; set; }
        public virtual DbSet<Zakljucak> Zakljucci { get; set; }
        public virtual DbSet<Rezultat> Rezultati { get; set; }
        public virtual DbSet<Test> Testovi { get; set; }
        public virtual DbSet<TestParametar> TestParametri { get; set; }
        public virtual DbSet<Usluga> Usluge { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
        }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            //za lazy loading npr. administrator u test.cs
            //optionsBuilder.UseLazyLoadingProxies();
            base.OnConfiguring(optionsBuilder);
        }
    }
}
