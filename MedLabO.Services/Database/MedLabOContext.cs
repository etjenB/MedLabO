using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace MedLabO.Services.Database
{
    public class MedLabOContext : IdentityDbContext<ApplicationUser, IdentityRole<Guid>, Guid>
    {
        public MedLabOContext(DbContextOptions options) : base(options)
        {
        }

        public virtual DbSet<ApplicationUser> Korisnici { get; set; }
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

        public virtual DbSet<TerminTest> TerminTest { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<TerminTest>()
                .HasKey(ttr => new { ttr.TestID, ttr.TerminID });

            //modelBuilder.Entity<TestTerminRezultat>()
            //    .HasOne(ttr => ttr.Rezultat)
            //    .WithMany()
            //    .HasForeignKey(ttr => ttr.RezultatID)
            //    .IsRequired(false);

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