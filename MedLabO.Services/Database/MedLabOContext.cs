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

        public virtual DbSet<Spol> Spolovi { get; set; }

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


        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            //za lazy loading npr. administrator u test.cs
            //optionsBuilder.UseLazyLoadingProxies();
            base.OnConfiguring(optionsBuilder);
        }

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

            // Seed genders
            modelBuilder.Entity<Spol>().HasData(
                new Spol
                {
                    SpolID = 1,
                    Kod = "M",
                    Naziv = "Muško"
                },
                new Spol
                {
                    SpolID = 2,
                    Kod = "Ž",
                    Naziv = "Žensko"
                },
                new Spol
                {
                    SpolID = 3,
                    Kod = "N",
                    Naziv = "Nepoznato"
                }
            );

            // Seed zvanja
            modelBuilder.Entity<Zvanje>().HasData(
                new Zvanje
                {
                    ZvanjeID = 1,
                    Naziv = "Ljekar",
                    Opis = "Ljekar u medicinskom laboratoriju specijaliziran je za analizu bioloških uzoraka, dijagnosticiranje bolesti i savjetovanje ostalih zdravstvenih radnika, koristeći naprednu laboratorijsku tehnologiju."
                },
                new Zvanje
                {
                    ZvanjeID = 2,
                    Naziv = "Laboratorijski tehničar",
                    Opis = "U medicinskom laboratoriju, laboratorijski tehničar precizno izvodi testiranja, održava laboratorijsku opremu i pomaže u interpretaciji rezultata testova."
                }
            );

            // Seed roles
            modelBuilder.Entity<IdentityRole<Guid>>().HasData(
                new IdentityRole<Guid>
                {
                    Id = Guid.Parse("0507e219-2779-4096-8d17-a1a91055dfda"),
                    Name = "Administrator",
                    NormalizedName = "ADMINISTRATOR",
                    ConcurrencyStamp = "33bdaece-3b05-4c3d-9e28-6d25aadea48f"
                },
                new IdentityRole<Guid>
                {
                    Id = Guid.Parse("6d333ed3-85ff-4863-93cc-76701acb9e52"),
                    Name = "MedicinskoOsoblje",
                    NormalizedName = "MEDICINSKOOSOBLJE",
                    ConcurrencyStamp = "3a291db2-ba0f-48fa-bc42-724a7d05ae50"
                },
                new IdentityRole<Guid>
                {
                    Id = Guid.Parse("c4f2036e-1b4c-4ac8-836c-f40f09a01a98"),
                    Name = "Pacijent",
                    NormalizedName = "PACIJENT",
                    ConcurrencyStamp = "2d1c96f2-34c3-498d-a8f2-c04aab32944a"
                }
            );

            // Seed users
            modelBuilder.Entity<Administrator>().HasData(
                new Administrator
                {
                    Id = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"),
                    Ime = "Administrator",
                    Prezime = "Administrator",
                    IsKontakt = true,
                    KontaktInfo = "administrator@gmail.com",
                    UserName = "administrator",
                    NormalizedUserName = "ADMINISTRATOR",
                    Email = "administrator@gmail.com",
                    NormalizedEmail = "ADMINISTRATOR@GMAIL.COM",
                    EmailConfirmed = true,
                    PasswordHash = "AQAAAAEAACcQAAAAEGkOoR+cGiA+ARYPMO/o7JiECUfSxXPCV9IpSjTvFqt8hfAvvj0/2WXjmITiflzgRg==",
                    SecurityStamp = "3b110b08-3940-425f-b7bf-cebda20a7605",
                    ConcurrencyStamp = "6fe96a41-e729-4b98-b77e-f3f12d4f5130",
                    PhoneNumber = "0601234567",
                    PhoneNumberConfirmed = true,
                    TwoFactorEnabled = false,
                    LockoutEnabled = false,
                    AccessFailedCount = 0
                }
            );
            modelBuilder.Entity<MedicinskoOsoblje>().HasData(
                new MedicinskoOsoblje
                {
                    Id = Guid.Parse("09098d7d-1be0-4d0b-926d-9eb493d81dcc"),
                    Ime = "MedicinskoOsoblje",
                    Prezime = "MedicinskoOsoblje",
                    IsActive = true,
                    DTZaposlenja = new DateTime(2020, 1, 1),
                    SpolID = 2,
                    ZvanjeID = 1,
                    UserName = "medicinskoOsoblje",
                    NormalizedUserName = "MEDICINSKOOSOBLJE",
                    Email = "medicinskoOsoblje@gmail.com",
                    NormalizedEmail = "MEDICINSKOOSOBLJE@GMAIL.COM",
                    EmailConfirmed = true,
                    PasswordHash = "AQAAAAEAACcQAAAAEGkOoR+cGiA+ARYPMO/o7JiECUfSxXPCV9IpSjTvFqt8hfAvvj0/2WXjmITiflzgRg==",
                    SecurityStamp = "2aa1af3c-765c-4dc4-ac2c-7216939e3f1e",
                    ConcurrencyStamp = "53f6a720-c8cc-4f6c-a4a4-ef70b73c6bf5",
                    PhoneNumber = "0607654321",
                    PhoneNumberConfirmed = true,
                    TwoFactorEnabled = false,
                    LockoutEnabled = false,
                    AccessFailedCount = 0
                }
            );
            modelBuilder.Entity<Pacijent>().HasData(
                new Pacijent
                {
                    Id = Guid.Parse("140fb21b-43c9-4da2-86e9-8f99d08d8d28"),
                    Ime = "Pacijent",
                    Prezime = "Pacijent",
                    DatumRodjenja = new DateTime(1970, 1, 1),
                    Adresa = "Ulica Prva 11",
                    SpolID = 1,
                    UserName = "pacijent",
                    NormalizedUserName = "PACIJENT",
                    Email = "pacijent@gmail.com",
                    NormalizedEmail = "PACIJENT@GMAIL.COM",
                    EmailConfirmed = true,
                    PasswordHash = "AQAAAAEAACcQAAAAEGkOoR+cGiA+ARYPMO/o7JiECUfSxXPCV9IpSjTvFqt8hfAvvj0/2WXjmITiflzgRg==",
                    SecurityStamp = "7568e1b2-a164-437b-8c85-a232269f08c3",
                    ConcurrencyStamp = "ee1c5d57-e06b-4b35-b200-c80ff2242cbd",
                    PhoneNumber = "0605555555",
                    PhoneNumberConfirmed = true,
                    TwoFactorEnabled = false,
                    LockoutEnabled = false,
                    AccessFailedCount = 0
                }
            );

            // Seed user-role relationships
            modelBuilder.Entity<IdentityUserRole<Guid>>().HasData(
                new IdentityUserRole<Guid>
                {
                    RoleId = Guid.Parse("0507e219-2779-4096-8d17-a1a91055dfda"), // Administrator role
                    UserId = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58")  // Administrator user
                },
                new IdentityUserRole<Guid>
                {
                    RoleId = Guid.Parse("6d333ed3-85ff-4863-93cc-76701acb9e52"), // MedicinskoOsoblje role
                    UserId = Guid.Parse("09098d7d-1be0-4d0b-926d-9eb493d81dcc")  // MedicinskoOsoblje user
                },
                new IdentityUserRole<Guid>
                {
                    RoleId = Guid.Parse("c4f2036e-1b4c-4ac8-836c-f40f09a01a98"), // Pacijent role
                    UserId = Guid.Parse("140fb21b-43c9-4da2-86e9-8f99d08d8d28")  // Pacijent user
                }
            );


            // Seed tests and parameters
            modelBuilder.Entity<TestParametar>().HasData(
                new TestParametar
                {
                    TestParametarID = Guid.Parse("46cba49e-0b4b-4018-ae70-5c9ceae529b5"),
                    MinVrijednost = 3.9f,
                    MaxVrijednost = 5.8f,
                    Jedinica = "mmol/L"
                }
            );
            modelBuilder.Entity<Test>().HasData(
                new Test
                {
                    TestID = Guid.Parse("d687ff9d-1ec4-4aa9-a4f3-2eb5149d2212"),
                    Naziv = "Glukoza",
                    Opis = "Mjerenje glukoze u krvi, važno za dijagnozu i praćenje dijabetesa.",
                    Cijena = 2,
                    NapomenaZaPripremu = "Post od 8 sati prije testa.",
                    TipUzorka = "Krv",
                    DTKreiranja = DateTime.Now,
                    AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"),
                    TestParametarID = Guid.Parse("46cba49e-0b4b-4018-ae70-5c9ceae529b5")
                }
            );

            modelBuilder.Entity<TestParametar>().HasData(
                new TestParametar
                {
                    TestParametarID = Guid.Parse("d70a4bfa-38c0-4d41-a090-208404e57209"),
                    MinVrijednost = 4.0f,
                    MaxVrijednost = 11.0f,
                    Jedinica = "x10^9/L"
                }
            );
            modelBuilder.Entity<Test>().HasData(
                new Test
                {
                    TestID = Guid.Parse("8fff236b-4a25-4ed3-a138-f252ee4770eb"),
                    Naziv = "Leukociti",
                    Opis = "Broj leukocita, važan za otkrivanje infekcija ili upalnih procesa.",
                    Cijena = 2.5m,
                    NapomenaZaPripremu = "Nema posebnih uputa.",
                    TipUzorka = "Krv",
                    DTKreiranja = DateTime.Now,
                    AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"),
                    TestParametarID = Guid.Parse("d70a4bfa-38c0-4d41-a090-208404e57209")
                }
            );

            modelBuilder.Entity<TestParametar>().HasData(
                new TestParametar
                {
                    TestParametarID = Guid.Parse("bab9d588-8ff1-4355-96fd-f94d9bdb4a8d"),
                    MinVrijednost = 3.8f,
                    MaxVrijednost = 5.9f,
                    Jedinica = "x10^12/L"
                }
            );
            modelBuilder.Entity<Test>().HasData(
                new Test
                {
                    TestID = Guid.Parse("54d120fc-224a-4710-9046-162d9b61c2d7"),
                    Naziv = "Eritrociti",
                    Opis = "Broj eritrocita, važan za dijagnozu anemije i drugih poremećaja.",
                    Cijena = 2.5m,
                    NapomenaZaPripremu = "Nema posebnih uputa.",
                    TipUzorka = "Krv",
                    DTKreiranja = DateTime.Now,
                    AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"),
                    TestParametarID = Guid.Parse("bab9d588-8ff1-4355-96fd-f94d9bdb4a8d")
                }
            );

            modelBuilder.Entity<TestParametar>().HasData(
                new TestParametar
                {
                    TestParametarID = Guid.Parse("e8319b5a-0868-4fef-b356-32f9fdabbd82"),
                    MinVrijednost = 320f,
                    MaxVrijednost = 355f,
                    Jedinica = "g/L"
                }
            );
            modelBuilder.Entity<Test>().HasData(
                new Test
                {
                    TestID = Guid.Parse("ef16a7e3-3117-4246-ae58-fc54d2307c77"),
                    Naziv = "MCHC",
                    Opis = "Prosječna koncentracija hemoglobina u eritrocitu.",
                    Cijena = 3,
                    NapomenaZaPripremu = "Nema posebnih uputa.",
                    TipUzorka = "Krv",
                    DTKreiranja = DateTime.Now,
                    AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"),
                    TestParametarID = Guid.Parse("e8319b5a-0868-4fef-b356-32f9fdabbd82")
                }
            );

            modelBuilder.Entity<TestParametar>().HasData(
                new TestParametar
                {
                    TestParametarID = Guid.Parse("901a4f75-3529-4b57-b9c0-8dd99f495d32"),
                    MinVrijednost = 0f,
                    MaxVrijednost = 40f,
                    Jedinica = "U/L"
                }
            );
            modelBuilder.Entity<Test>().HasData(
                new Test
                {
                    TestID = Guid.Parse("ad25cc31-2b01-4ad3-bf2e-1fe4b53a3f25"),
                    Naziv = "AST",
                    Opis = "Enzim važan za otkrivanje oštećenja jetre.",
                    Cijena = 3,
                    NapomenaZaPripremu = "Nema posebnih uputa.",
                    TipUzorka = "Krv",
                    DTKreiranja = DateTime.Now,
                    AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"),
                    TestParametarID = Guid.Parse("901a4f75-3529-4b57-b9c0-8dd99f495d32")
                }
            );

            modelBuilder.Entity<TestParametar>().HasData(
                new TestParametar
                {
                    TestParametarID = Guid.Parse("788e2d86-4fc5-49a8-994e-541180dba9bb"),
                    MinVrijednost = 0f,
                    MaxVrijednost = 30f,
                    Jedinica = "mm/h"
                }
            );
            modelBuilder.Entity<Test>().HasData(
                new Test
                {
                    TestID = Guid.Parse("a4a12d1c-b174-4938-8557-cb6281ccb2a6"),
                    Naziv = "Sedimentacija",
                    Opis = "Brzina sedimentacije eritrocita, indikator upalnih procesa.",
                    Cijena = 2,
                    NapomenaZaPripremu = "Nema posebnih uputa.",
                    TipUzorka = "Krv",
                    DTKreiranja = DateTime.Now,
                    AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"),
                    TestParametarID = Guid.Parse("788e2d86-4fc5-49a8-994e-541180dba9bb")
                }
            );

            modelBuilder.Entity<TestParametar>().HasData(
                new TestParametar
                {
                    TestParametarID = Guid.Parse("0fe0697a-aa20-4e20-b152-58f6ed44efc3"),
                    MinVrijednost = 0f,
                    MaxVrijednost = 5f,
                    Jedinica = "mg/L"
                }
            );
            modelBuilder.Entity<Test>().HasData(
                new Test
                {
                    TestID = Guid.Parse("0c1a4613-be50-48a6-abcb-a535870fe369"),
                    Naziv = "CRP",
                    Opis = "Marker za upalu u tijelu.",
                    Cijena = 3.5m,
                    NapomenaZaPripremu = "Nema posebnih uputa.",
                    TipUzorka = "Krv",
                    DTKreiranja = DateTime.Now,
                    AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"),
                    TestParametarID = Guid.Parse("0fe0697a-aa20-4e20-b152-58f6ed44efc3")
                }
            );

            modelBuilder.Entity<TestParametar>().HasData(
                new TestParametar
                {
                    TestParametarID = Guid.Parse("77886ff8-caf5-4247-ae64-62e1a8c0969f"),
                    MinVrijednost = 1.2f,
                    MaxVrijednost = 20.5f,
                    Jedinica = "mg/dL"
                }
            );
            modelBuilder.Entity<Test>().HasData(
                new Test
                {
                    TestID = Guid.Parse("14a35eb5-c4bd-4a0b-9990-c8b493367bcf"),
                    Naziv = "Bilirubin",
                    Opis = "Mjerenje bilirubina, važno za otkrivanje bolesti jetre i žučnih puteva.",
                    Cijena = 3m,
                    NapomenaZaPripremu = "Nema posebnih uputa.",
                    TipUzorka = "Krv",
                    DTKreiranja = DateTime.Now,
                    AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"),
                    TestParametarID = Guid.Parse("77886ff8-caf5-4247-ae64-62e1a8c0969f")
                }
            );

            modelBuilder.Entity<TestParametar>().HasData(
                new TestParametar
                {
                    TestParametarID = Guid.Parse("e8e1e4b9-7fe9-4015-9f62-f3c844e831ce"),
                    MinVrijednost = 3.6f,
                    MaxVrijednost = 7.8f,
                    Jedinica = "mmol/L"
                }
            );
            modelBuilder.Entity<Test>().HasData(
                new Test
                {
                    TestID = Guid.Parse("1c978bd5-9777-4c05-b2ae-de4d3b9b4fc5"),
                    Naziv = "Holesterol",
                    Opis = "Mjerenje ukupnog holesterola, važno za procjenu rizika od kardiovaskularnih bolesti.",
                    Cijena = 2.5m,
                    NapomenaZaPripremu = "Post od 12 sati prije testa.",
                    TipUzorka = "Krv",
                    DTKreiranja = DateTime.Now,
                    AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"),
                    TestParametarID = Guid.Parse("e8e1e4b9-7fe9-4015-9f62-f3c844e831ce")
                }
            );

            modelBuilder.Entity<TestParametar>().HasData(
                new TestParametar
                {
                    TestParametarID = Guid.Parse("e4f11b51-c4e6-473d-9221-c617354745f3"),
                    MinVrijednost = 0f,
                    MaxVrijednost = 2.3f,
                    Jedinica = "mmol/L"
                }
            );
            modelBuilder.Entity<Test>().HasData(
                new Test
                {
                    TestID = Guid.Parse("20b1bda2-14bc-4b3f-bac4-598e2a292519"),
                    Naziv = "Trigliceridi",
                    Opis = "Mjerenje triglicerida, važno za procjenu rizika od srčanih bolesti.",
                    Cijena = 2.5m,
                    NapomenaZaPripremu = "Post od 12 sati prije testa.",
                    TipUzorka = "Krv",
                    DTKreiranja = DateTime.Now,
                    AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"),
                    TestParametarID = Guid.Parse("e4f11b51-c4e6-473d-9221-c617354745f3")
                }
            );

            modelBuilder.Entity<TestParametar>().HasData(
                new TestParametar
                {
                    TestParametarID = Guid.Parse("75b1dbb5-6b3c-4c76-8044-caff96608e08"),
                    NormalnaVrijednost = "Negativno na maligne stanice"
                }
            );
            modelBuilder.Entity<Test>().HasData(
                new Test
                {
                    TestID = Guid.Parse("0c9db61b-d5e5-495d-876b-30ad80a8df3d"),
                    Naziv = "Citologija sputuma",
                    Opis = "Analiza sputuma za otkrivanje abnormalnih stanica.",
                    Cijena = 4.5m,
                    NapomenaZaPripremu = "Jutarnji sputum.",
                    TipUzorka = "Sputum",
                    DTKreiranja = DateTime.Now,
                    AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"),
                    TestParametarID = Guid.Parse("75b1dbb5-6b3c-4c76-8044-caff96608e08")
                }
            );

            modelBuilder.Entity<TestParametar>().HasData(
                new TestParametar
                {
                    TestParametarID = Guid.Parse("84bfaf38-20b5-4648-b8f0-9d2c4cf7b95a"),
                    NormalnaVrijednost = "Negativno na MRSA"
                }
            );
            modelBuilder.Entity<Test>().HasData(
                new Test
                {
                    TestID = Guid.Parse("59a5aaae-ec61-476d-84f5-2621d4054160"),
                    Naziv = "Nasalni bris za MRSA",
                    Opis = "Testiranje na prisutnost MRSA (meticilin-rezistentni Staphylococcus aureus) u nosnoj šupljini.",
                    Cijena = 5m,
                    NapomenaZaPripremu = "Nema posebnih uputa.",
                    TipUzorka = "Nasalni bris",
                    DTKreiranja = DateTime.Now,
                    AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"),
                    TestParametarID = Guid.Parse("84bfaf38-20b5-4648-b8f0-9d2c4cf7b95a")
                }
            );

            modelBuilder.Entity<TestParametar>().HasData(
                new TestParametar
                {
                    TestParametarID = Guid.Parse("e16fecb2-a4cf-41fd-a264-18dbc8a25cc8"),
                    MinVrijednost = 0f,
                    MaxVrijednost = 30f,
                    Jedinica = "mg/L"
                }
            );
            modelBuilder.Entity<Test>().HasData(
                new Test
                {
                    TestID = Guid.Parse("d9f7156c-a460-4a7c-b51c-ef7d859244af"),
                    Naziv = "Urinarni albumin",
                    Opis = "Mjerenje albumina u urinu, indikator oštećenja bubrega.",
                    Cijena = 3m,
                    NapomenaZaPripremu = "Jutarnji urin.",
                    TipUzorka = "Urin",
                    DTKreiranja = DateTime.Now,
                    AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"),
                    TestParametarID = Guid.Parse("e16fecb2-a4cf-41fd-a264-18dbc8a25cc8")
                }
            );


            // Seed services
            modelBuilder.Entity<Usluga>().HasData(
                new Usluga
                {
                    UslugaID = 1,
                    Naziv = "Krvna slika",
                    Opis = "Mjerenje osnovnih testova vezanih za krvnu sliku.",
                    Cijena = 6,
                    TrajanjeUMin = 10,
                    RezultatUH = 24,
                    Dostupno = true,
                    DTKreiranja = DateTime.Now,
                    AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58")
                }
            );
            modelBuilder.Entity<Usluga>().HasData(
               new Usluga
               {
                   UslugaID = 2,
                   Naziv = "Jetreni panel",
                   Opis = "Kompletna analiza funkcije jetre.",
                   Cijena = 8,
                   TrajanjeUMin = 15,
                   RezultatUH = 24,
                   Dostupno = true,
                   DTKreiranja = DateTime.Now,
                   AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58")
               }
           );
            modelBuilder.Entity<Usluga>().HasData(
               new Usluga
               {
                   UslugaID = 3,
                   Naziv = "Kardiovaskularni rizik",
                   Opis = "Procjena rizika od kardiovaskularnih bolesti.",
                   Cijena = 4,
                   TrajanjeUMin = 10,
                   RezultatUH = 24,
                   Dostupno = true,
                   DTKreiranja = DateTime.Now,
                   AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58")
               }
           );
            modelBuilder.Entity<Usluga>().HasData(
               new Usluga
               {
                   UslugaID = 4,
                   Naziv = "Upalni marker",
                   Opis = "Testiranje za otkrivanje upalnih procesa u tijelu.",
                   Cijena = 5,
                   TrajanjeUMin = 10,
                   RezultatUH = 24,
                   Dostupno = true,
                   DTKreiranja = DateTime.Now,
                   AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58")
               }
           );
            modelBuilder.Entity<Usluga>().HasData(
               new Usluga
               {
                   UslugaID = 5,
                   Naziv = "Bubrežni panel",
                   Opis = "Procjena funkcije bubrega i rizika od dijabetesa.",
                   Cijena = 4,
                   TrajanjeUMin = 15,
                   RezultatUH = 24,
                   Dostupno = true,
                   DTKreiranja = DateTime.Now,
                   AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58")
               }
           );
            modelBuilder.Entity<Usluga>().HasData(
               new Usluga
               {
                   UslugaID = 6,
                   Naziv = "Respiratorni panel",
                   Opis = "Analiza respiratornog sistema za otkrivanje infekcija.",
                   Cijena = 9,
                   TrajanjeUMin = 20,
                   RezultatUH = 48,
                   Dostupno = true,
                   DTKreiranja = DateTime.Now,
                   AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58")
               }
           );

            //seed obavijesti
            modelBuilder.Entity<Obavijest>().HasData(
               new Obavijest
               {
                   ObavijestID = Guid.Parse("0e322352-b209-4dce-8369-9d7d67f38daf"),
                   Naslov = "Neradni Dan - 18.02.2023.",
                   Sadrzaj = "Poštovani kolege, obavještavamo vas da će laboratorij biti zatvoren 18.02.2023. zbog redovnog godišnjeg održavanja opreme i prostorija. Ovo je idealna prilika da se posvetite svom zdravlju i porodici, te da napunite baterije za nove radne izazove. Molimo vas da sve planirane aktivnosti prilagodite ovom datumu. Također, podsjećamo vas da je važno redovno pratiti stanje i održavanje opreme, kako bismo osigurali najviši standard naših usluga. Hvala vam na razumijevanju i suradnji.",
                   DTKreiranja = DateTime.Now,
                   AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58")
               }
           );
            modelBuilder.Entity<Obavijest>().HasData(
               new Obavijest
               {
                   ObavijestID = Guid.Parse("55d8e97e-4379-4978-940a-d342158c5ce5"),
                   Naslov = "Edukacijski Seminar za Zaposlenike",
                   Sadrzaj = "Drage kolege, s velikim zadovoljstvom vas obavještavamo da ćemo 25.03.2023. organizirati edukacijski seminar na temu \"Najnovije tehnike u laboratorijskim ispitivanjima\". Seminar će voditi priznati stručnjaci u našem području rada. Ovo je izvrsna prilika za usavršavanje i razmjenu iskustava s kolegama iz struke. Seminar će se održati u konferencijskoj sali našeg laboratorija, s početkom u 10:00 sati. Molimo sve zainteresirane da potvrde svoje sudjelovanje najkasnije do 15.03.2023.",
                   DTKreiranja = DateTime.Now,
                   AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58")
               }
           );
            modelBuilder.Entity<Obavijest>().HasData(
               new Obavijest
               {
                   ObavijestID = Guid.Parse("04cf6396-4405-43b0-87bc-fee864a88e2e"),
                   Naslov = "Promjena Protokola za Obradu Uzoraka",
                   Sadrzaj = "Obavještavamo sve zaposlenike da od 01.04.2023. stupaju na snagu novi protokoli za obradu uzoraka. Novi protokoli uključuju ažurirane postupke za rukovanje, analizu i pohranu uzoraka, s ciljem povećanja efikasnosti i tačnosti naših testova. Detaljne upute i obuke bit će organizirane u narednim sedmicama. Molimo sve zaposlenike da se upoznaju s novim protokolima i prate upute za obuku. Vaša suradnja i pridržavanje novih protokola su ključni za uspjeh ove promjene.",
                   DTKreiranja = DateTime.Now,
                   AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58")
               }
           );
            modelBuilder.Entity<Obavijest>().HasData(
               new Obavijest
               {
                   ObavijestID = Guid.Parse("af32cfec-6818-44f2-9efa-053d24bebd9d"),
                   Naslov = "Godišnji Plan Odmora",
                   Sadrzaj = "Kako bismo osigurali kontinuirani rad laboratorija i zadovoljili potrebe naših pacijenata, molimo sve zaposlenike da do 15.04.2023. dostave svoje planove godišnjih odmora. Važno je da planiramo i koordiniramo odmore kako bismo izbjegli preklapanja i osigurali adekvatno osoblje u svakom trenutku. Molimo vas da razmotrite potrebe vašeg tima i laboratorija prilikom planiranja odmora. U slučaju bilo kakvih pitanja ili nedoumica, slobodno se obratite odjelu ljudskih resursa.",
                   DTKreiranja = DateTime.Now,
                   AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58")
               }
           );
            modelBuilder.Entity<Obavijest>().HasData(
               new Obavijest
               {
                   ObavijestID = Guid.Parse("6cb8671d-2034-4bed-9a8b-1cf5a2f4d917"),
                   Naslov = "Sigurnosne Mjere u Laboratoriju",
                   Sadrzaj = "Sigurnost na radnom mjestu je naš prioritet. Stoga vas podsjećamo na važnost pridržavanja svih sigurnosnih protokola i procedura u laboratoriju. Ovo uključuje pravilno nošenje zaštitne opreme, pažljivo rukovanje uzorcima i hemikalijama, te održavanje čistoće i urednosti radnog prostora. Redovite provjere i obuke o sigurnosti bit će organizirane kako bismo osigurali da su svi upoznati s najboljim praksama i procedurama. Vaša sigurnost i zdravlje su od izuzetne važnosti, stoga vas molimo da ozbiljno shvatite ove mjere.",
                   DTKreiranja = DateTime.Now,
                   AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58")
               }
           );

            //seed novosti
            modelBuilder.Entity<Novost>().HasData(
               new Novost
               {
                   NovostID = Guid.Parse("fc31fac7-27e4-41bd-95f4-da76a956bd23"),
                   Naslov = "Novi Testovi Dostupni u Našem Laboratoriju",
                   Sadrzaj = "Dragi pacijenti, s ponosom vas obavještavamo da smo proširili našu ponudu testova. Novi testovi uključuju napredne genetske analize, testove intolerancije na hranu, i detaljne hormonalne profile. Ovi testovi su dizajnirani da vam pruže dublji uvid u vaše zdravstveno stanje i omoguće personalizirani pristup liječenju. Naš tim stručnjaka je na raspolaganju da odgovori na sva vaša pitanja i pomogne vam odabrati najprikladnije testove za vaše potrebe. Posjetite nas i saznajte više o novim mogućnostima koje vam nudimo za očuvanje i unapređenje vašeg zdravlja.",
                   DTKreiranja = DateTime.Now,
                   AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58")
               }
           );
            modelBuilder.Entity<Novost>().HasData(
               new Novost
               {
                   NovostID = Guid.Parse("be49f5ad-6d18-435e-97a5-13600af6b4e5"),
                   Naslov = "Dan Otvorenih Vrata u Laboratoriju",
                   Sadrzaj = "Pozivamo vas na Dan otvorenih vrata koji će se održati 15.04.2023. u našem laboratoriju. Ovo je izvrsna prilika da se upoznate s našim radom, tehnologijama koje koristimo i timom stručnjaka koji brinu o vašem zdravlju. Tijekom ovog dana, moći ćete besplatno izvršiti osnovne zdravstvene preglede, sudjelovati u edukativnim radionicama i dobiti individualne savjete o zdravlju. Također, pripremili smo posebne popuste na odabrane testove i usluge. Ne propustite ovu priliku da saznate više o važnosti preventivnih pregleda i kako možete aktivno doprinijeti očuvanju svog zdravlja.",
                   DTKreiranja = DateTime.Now,
                   AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58")
               }
           );
            modelBuilder.Entity<Novost>().HasData(
               new Novost
               {
                   NovostID = Guid.Parse("465a1478-3027-498f-aa82-b46b9a0ec4ee"),
                   Naslov = "Obavijest o Radnom Vremenu za Praznike",
                   Sadrzaj = "Obavještavamo naše cijenjene pacijente da će tijekom nadolazećih praznika doći do promjena u radnom vremenu našeg laboratorija. Na Badnjak i Staru godinu laboratorij će raditi skraćeno, do 12:00 sati, dok će na Božić i Novu godinu laboratorij biti zatvoren. Molimo vas da planirate svoje posjete i testiranja sukladno ovom rasporedu. Također, želimo iskoristiti ovu priliku da vam zaželimo sretne i mirne praznike. Neka ovo vrijeme bude ispunjeno zdravljem, srećom i radosti. U novoj godini nastavljamo s našom misijom pružanja vrhunske zdravstvene skrbi i usluga. Hvala vam što ste dio naše zajednice i što nam vjerujete brigu o vašem zdravlju.",
                   DTKreiranja = DateTime.Now,
                   AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58")
               }
           );
            modelBuilder.Entity<Novost>().HasData(
               new Novost
               {
                   NovostID = Guid.Parse("325d2b08-9822-4ef1-acbd-2d4528bbeebc"),
                   Naslov = "Uvođenje Online Rezervacija Termina",
                   Sadrzaj = "S ciljem poboljšanja naših usluga i olakšavanja pristupa zdravstvenoj skrbi, uvodimo novi sustav online rezervacija termina putem naše web stranice. Od sada, možete jednostavno i brzo rezervirati svoj termin za testiranje također putem naše web stranice. Ovaj sustav omogućava vam da izaberete datum i vrijeme koje vam najviše odgovara, bez potrebe za čekanjem u redu ili telefonskim pozivima. Također, putem sustava možete pratiti svoje rezervacije, dobiti podsjetnike za nadolazeće termine i pristupiti rezultatima testiranja. Naš cilj je učiniti proces testiranja što jednostavnijim i ugodnijim za vas, te vam pružiti brz i efikasan pristup informacijama o vašem zdravlju. Pozivamo vas da isprobate naš novi sustav rezervacija i podijelite s nama svoje dojmove.",
                   DTKreiranja = DateTime.Now,
                   AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58")
               }
           );
            modelBuilder.Entity<Novost>().HasData(
               new Novost
               {
                   NovostID = Guid.Parse("7fa51a3e-501c-4466-90e2-1eba0a549d23"),
                   Naslov = "Modernizacija Laboratorijske Opreme",
                   Sadrzaj = "S ponosom vas obavještavamo o nedavnoj modernizaciji naše laboratorijske opreme. Ulaganjem u najnovije tehnologije, osigurali smo da naši pacijenti imaju pristup najpreciznijim i najbržim dijagnostičkim testovima. Nova oprema omogućava nam da proširimo spektar testova, smanjimo vrijeme čekanja na rezultate i povećamo tačnost dijagnostike. Ovo je važan korak u našem nastojanju da pružimo vrhunsku medicinsku skrb i podršku našim pacijentima. Vjerujemo da će ove promjene značajno doprinijeti kvaliteti i efikasnosti naših usluga, te vam omogućiti bolje upravljanje vašim zdravljem. Zahvaljujemo vam na povjerenju i radujemo se što ćemo vam pružiti još bolju uslugu uz pomoć ove napredne tehnologije.",
                   DTKreiranja = DateTime.Now,
                   AdministratorID = Guid.Parse("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58")
               }
           );

           modelBuilder.Entity<Termin>().HasData(
                new Termin
                {
                    TerminID = new Guid("26954381-1F85-4776-A5D4-39068D8ADD3A"),
                    DTTermina = new DateTime(2024, 1, 19, 12, 0, 0),
                    Obavljen = false,
                    RezultatDodan = false,
                    ZakljucakDodan = false,
                    Placeno = true,
                    PacijentID = new Guid("140FB21B-43C9-4DA2-86E9-8F99D08D8D28")
                },
                new Termin
                {
                    TerminID = new Guid("595C85F2-F1B1-4176-94A7-411BD46570CC"),
                    DTTermina = new DateTime(2024, 1, 26, 7, 0, 0),
                    Obavljen = false,
                    RezultatDodan = false,
                    ZakljucakDodan = false,
                    Placeno = true,
                    PacijentID = new Guid("140FB21B-43C9-4DA2-86E9-8F99D08D8D28")
                },
                new Termin
                {
                    TerminID = new Guid("34C710C6-EC80-483B-AA25-42C0229941EC"),
                    DTTermina = new DateTime(2024, 1, 18, 8, 0, 0),
                    Obavljen = false,
                    RezultatDodan = false,
                    ZakljucakDodan = false,
                    Placeno = true,
                    PacijentID = new Guid("140FB21B-43C9-4DA2-86E9-8F99D08D8D28")
                },
                new Termin
                {
                    TerminID = new Guid("7AD39C1E-7D14-4127-BBAC-459888F300E6"),
                    DTTermina = new DateTime(2024, 1, 22, 15, 0, 0),
                    Obavljen = false,
                    RezultatDodan = false,
                    ZakljucakDodan = false,
                    Placeno = true,
                    PacijentID = new Guid("140FB21B-43C9-4DA2-86E9-8F99D08D8D28")
                },
                new Termin
                {
                    TerminID = new Guid("FCBFE84D-B6FD-4B36-A31D-773EB669C123"),
                    DTTermina = new DateTime(2024, 1, 10, 13, 0, 0),
                    Obavljen = false,
                    RezultatDodan = false,
                    ZakljucakDodan = false,
                    Placeno = true,
                    PacijentID = new Guid("140FB21B-43C9-4DA2-86E9-8F99D08D8D28")
                },
                new Termin
                {
                    TerminID = new Guid("4253753F-DB13-4D93-B0A8-7D4CF6B46013"),
                    DTTermina = new DateTime(2024, 1, 23, 7, 40, 0),
                    Obavljen = false,
                    RezultatDodan = false,
                    ZakljucakDodan = false,
                    Placeno = true,
                    PacijentID = new Guid("140FB21B-43C9-4DA2-86E9-8F99D08D8D28")
                },
                new Termin
                {
                    TerminID = new Guid("5C5E0879-6019-4B0D-81FB-804B73273D03"),
                    DTTermina = new DateTime(2024, 1, 25, 11, 0, 0),
                    Obavljen = false,
                    RezultatDodan = false,
                    ZakljucakDodan = false,
                    Placeno = true,
                    PacijentID = new Guid("140FB21B-43C9-4DA2-86E9-8F99D08D8D28")
                },
                new Termin
                {
                    TerminID = new Guid("66F5142B-DCBC-4330-81A6-8BADE0950F44"),
                    DTTermina = new DateTime(2024, 1, 29, 11, 0, 0),
                    Obavljen = false,
                    RezultatDodan = false,
                    ZakljucakDodan = false,
                    Placeno = true,
                    PacijentID = new Guid("140FB21B-43C9-4DA2-86E9-8F99D08D8D28")
                },
                new Termin
                {
                    TerminID = new Guid("D2539F37-0E15-44B6-AF31-8CC93C03DCD1"),
                    DTTermina = new DateTime(2024, 1, 12, 11, 0, 0),
                    Obavljen = false,
                    RezultatDodan = false,
                    ZakljucakDodan = false,
                    Placeno = true,
                    PacijentID = new Guid("140FB21B-43C9-4DA2-86E9-8F99D08D8D28")
                },
                new Termin
                {
                    TerminID = new Guid("1137E44A-6E88-41AB-965F-8EA5A936FF24"),
                    DTTermina = new DateTime(2024, 1, 24, 8, 0, 0),
                    Obavljen = false,
                    RezultatDodan = false,
                    ZakljucakDodan = false,
                    Placeno = true,
                    PacijentID = new Guid("140FB21B-43C9-4DA2-86E9-8F99D08D8D28")
                },
                new Termin
                {
                    TerminID = new Guid("7C262D54-D6F6-4461-B4C9-A0E9266F2D50"),
                    DTTermina = new DateTime(2024, 1, 11, 9, 40, 0),
                    Obavljen = false,
                    RezultatDodan = false,
                    ZakljucakDodan = false,
                    Placeno = true,
                    PacijentID = new Guid("140FB21B-43C9-4DA2-86E9-8F99D08D8D28")
                },
                new Termin
                {
                    TerminID = new Guid("DC433820-5129-44A9-BB1E-A3B87C1BC398"),
                    DTTermina = new DateTime(2024, 1, 16, 10, 40, 0),
                    Obavljen = false,
                    RezultatDodan = false,
                    ZakljucakDodan = false,
                    Placeno = true,
                    PacijentID = new Guid("140FB21B-43C9-4DA2-86E9-8F99D08D8D28")
                },
                new Termin
                {
                    TerminID = new Guid("10254F8E-15DD-4673-AA54-B4DA76946D1D"),
                    DTTermina = new DateTime(2024, 1, 15, 10, 0, 0),
                    Obavljen = false,
                    RezultatDodan = false,
                    ZakljucakDodan = false,
                    Placeno = true,
                    PacijentID = new Guid("140FB21B-43C9-4DA2-86E9-8F99D08D8D28")
                },
                new Termin
                {
                    TerminID = new Guid("FB3BF003-4DDA-4228-A1B6-D488644F90A8"),
                    DTTermina = new DateTime(2024, 1, 17, 8, 0, 0),
                    Obavljen = false,
                    RezultatDodan = false,
                    ZakljucakDodan = false,
                    Placeno = true,
                    PacijentID = new Guid("140FB21B-43C9-4DA2-86E9-8F99D08D8D28")
                },
                new Termin
                {
                    TerminID = new Guid("42A4749B-7F8C-464D-A54A-E857E45D62A7"),
                    DTTermina = new DateTime(2024, 1, 31, 7, 0, 0),
                    Obavljen = false,
                    RezultatDodan = false,
                    ZakljucakDodan = false,
                    Placeno = true,
                    PacijentID = new Guid("140FB21B-43C9-4DA2-86E9-8F99D08D8D28")
                },
                new Termin
                {
                    TerminID = new Guid("DC0261CE-322D-45A1-851D-E88863031C84"),
                    DTTermina = new DateTime(2024, 1, 30, 10, 40, 0),
                    Obavljen = false,
                    RezultatDodan = false,
                    ZakljucakDodan = false,
                    Placeno = true,
                    PacijentID = new Guid("140FB21B-43C9-4DA2-86E9-8F99D08D8D28")
                }
            );
            modelBuilder.Entity<Racun>().HasData(
                new Racun
                {
                    RacunID = new Guid("3C19770E-223D-43FE-8D15-3BA1FE7151FE"),
                    Cijena = 10,
                    Placeno = true
                },
                new Racun
                {
                    RacunID = new Guid("ECA7C955-9CE4-42AB-A33A-0F2C08F1E38C"),
                    Cijena = 14,
                    Placeno = true
                },
                new Racun
                {
                    RacunID = new Guid("0BDC8864-0879-4401-8879-A5BE3496CF6D"),
                    Cijena = 9,
                    Placeno = true
                },
                new Racun
                {
                    RacunID = new Guid("5461CE30-AD9C-49CB-9371-C5FD231FBF63"),
                    Cijena = 11,
                    Placeno = true
                },
                new Racun
                {
                    RacunID = new Guid("C6781A23-2C71-4DFE-A934-8597C0688812"),
                    Cijena = 36,
                    Placeno = true,
                },
                new Racun
                {
                    RacunID = new Guid("1186F71A-E2D2-4DB2-BF14-2B7727859C74"),
                    Cijena = 4,
                    Placeno = true
                },
                new Racun
                {
                    RacunID = new Guid("903AB20A-1AEA-493E-8E3C-05564353BC54"),
                    Cijena = 20,
                    Placeno = true
                },
                new Racun
                {
                    RacunID = new Guid("2057CDBF-4BD4-4071-A2BC-5E19C0183C40"),
                    Cijena = 10,
                    Placeno = true
                },
                new Racun
                {
                    RacunID = new Guid("18356CDD-FBA4-4D5B-A33C-E1D09894A145"),
                    Cijena = 11,
                    Placeno = true
                },
                new Racun
                {
                    RacunID = new Guid("58F643CF-1079-4177-950E-A97162657093"),
                    Cijena = 11,
                    Placeno = true
                },
                new Racun
                {
                    RacunID = new Guid("6B746E04-31AC-46F5-AD2E-33BDEA321D63"),
                    Cijena = 10,
                    Placeno = true
                },
                new Racun
                {
                    RacunID = new Guid("8D166154-FD43-485A-8263-93EFDB69AC4C"),
                    Cijena = 11,
                    Placeno = true
                },
                new Racun
                {
                    RacunID = new Guid("0FB113DB-16AF-4675-BCBF-C18709429E2A"),
                    Cijena = 21,
                    Placeno = true
                },
                new Racun
                {
                    RacunID = new Guid("E8F45C95-F42A-4220-841D-1EC3E4998F48"),
                    Cijena = 14,
                    Placeno = true
                },
                new Racun
                {
                    RacunID = new Guid("B36B8AAF-2C31-47DF-88C8-E76D96E41C56"),
                    Cijena = 11,
                    Placeno = true
                },
                new Racun
                {
                    RacunID = new Guid("B35CEF5E-0471-4FF2-99F0-6ECBD1D390F5"),
                    Cijena = 21,
                    Placeno = true
                }
            );
        }
    }
}