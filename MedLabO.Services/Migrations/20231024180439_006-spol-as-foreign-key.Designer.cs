﻿// <auto-generated />
using System;
using MedLabO.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace MedLabO.Services.Migrations
{
    [DbContext(typeof(MedLabOContext))]
    [Migration("20231024180439_006-spol-as-foreign-key")]
    partial class _006spolasforeignkey
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "6.0.15")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder, 1L, 1);

            modelBuilder.Entity("MedLabO.Services.Database.ApplicationUser", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<int>("AccessFailedCount")
                        .HasColumnType("int");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Discriminator")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Email")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.Property<bool>("EmailConfirmed")
                        .HasColumnType("bit");

                    b.Property<bool>("LockoutEnabled")
                        .HasColumnType("bit");

                    b.Property<DateTimeOffset?>("LockoutEnd")
                        .HasColumnType("datetimeoffset");

                    b.Property<string>("NormalizedEmail")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.Property<string>("NormalizedUserName")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.Property<string>("PasswordHash")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("PhoneNumber")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("PhoneNumberConfirmed")
                        .HasColumnType("bit");

                    b.Property<string>("SecurityStamp")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("TwoFactorEnabled")
                        .HasColumnType("bit");

                    b.Property<string>("UserName")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.HasKey("Id");

                    b.HasIndex("NormalizedEmail")
                        .HasDatabaseName("EmailIndex");

                    b.HasIndex("NormalizedUserName")
                        .IsUnique()
                        .HasDatabaseName("UserNameIndex")
                        .HasFilter("[NormalizedUserName] IS NOT NULL");

                    b.ToTable("AspNetUsers", (string)null);

                    b.HasDiscriminator<string>("Discriminator").HasValue("ApplicationUser");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Novost", b =>
                {
                    b.Property<Guid>("NovostID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid?>("AdministratorID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("DTKreiranja")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("DTZadnjeModifikacije")
                        .HasColumnType("datetime2");

                    b.Property<string>("Naslov")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Sadrzaj")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<byte[]>("Slika")
                        .IsRequired()
                        .HasColumnType("varbinary(max)");

                    b.HasKey("NovostID");

                    b.HasIndex("AdministratorID");

                    b.ToTable("Novosti");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Obavijest", b =>
                {
                    b.Property<Guid>("ObavijestID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid?>("AdministratorID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("DTKreiranja")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("DTZadnjeModifikacije")
                        .HasColumnType("datetime2");

                    b.Property<string>("Naslov")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Sadrzaj")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<byte[]>("Slika")
                        .IsRequired()
                        .HasColumnType("varbinary(max)");

                    b.HasKey("ObavijestID");

                    b.HasIndex("AdministratorID");

                    b.ToTable("Obavijesti");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Racun", b =>
                {
                    b.Property<Guid>("TerminID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<decimal>("Cijena")
                        .HasColumnType("decimal(18,2)");

                    b.Property<bool>("Placeno")
                        .HasColumnType("bit");

                    b.HasKey("TerminID");

                    b.ToTable("Racuni");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Rezultat", b =>
                {
                    b.Property<Guid>("RezultatID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("DTRezultata")
                        .HasColumnType("datetime2");

                    b.Property<bool>("Obiljezen")
                        .HasColumnType("bit");

                    b.Property<float?>("RazlikaOdNormalne")
                        .HasColumnType("real");

                    b.Property<float?>("RezFlo")
                        .HasColumnType("real");

                    b.Property<string>("RezStr")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("TestZakljucak")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("RezultatID");

                    b.ToTable("Rezultati");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Spol", b =>
                {
                    b.Property<int>("SpolID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("SpolID"), 1L, 1);

                    b.Property<string>("Kod")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("SpolID");

                    b.ToTable("Spolovi");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Termin", b =>
                {
                    b.Property<Guid>("TerminID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<DateTime>("DTTermina")
                        .HasColumnType("datetime2");

                    b.Property<Guid?>("MedicinskoOsobljeID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Napomena")
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("Obavljen")
                        .HasColumnType("bit");

                    b.Property<string>("Odgovor")
                        .HasColumnType("nvarchar(max)");

                    b.Property<Guid?>("PacijentID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<bool>("PrijemZavrsen")
                        .HasColumnType("bit");

                    b.Property<Guid?>("RacunID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<byte[]>("RezultatTerminaPDF")
                        .HasColumnType("varbinary(max)");

                    b.Property<bool?>("Status")
                        .HasColumnType("bit");

                    b.Property<Guid?>("ZakljucakID")
                        .HasColumnType("uniqueidentifier");

                    b.HasKey("TerminID");

                    b.HasIndex("MedicinskoOsobljeID");

                    b.HasIndex("PacijentID");

                    b.HasIndex("RacunID")
                        .IsUnique()
                        .HasFilter("[RacunID] IS NOT NULL");

                    b.HasIndex("ZakljucakID")
                        .IsUnique()
                        .HasFilter("[ZakljucakID] IS NOT NULL");

                    b.ToTable("Termini");
                });

            modelBuilder.Entity("MedLabO.Services.Database.TerminTest", b =>
                {
                    b.Property<Guid?>("TestID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid?>("TerminID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid?>("RezultatID")
                        .HasColumnType("uniqueidentifier");

                    b.HasKey("TestID", "TerminID");

                    b.HasIndex("RezultatID");

                    b.HasIndex("TerminID");

                    b.ToTable("TerminTest");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Test", b =>
                {
                    b.Property<Guid>("TestID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid?>("AdministratorID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<decimal>("Cijena")
                        .HasColumnType("decimal(18,2)");

                    b.Property<DateTime>("DTKreiranja")
                        .HasColumnType("datetime2");

                    b.Property<string>("NapomenaZaPripremu")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Opis")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<byte[]>("Slika")
                        .HasColumnType("varbinary(max)");

                    b.Property<Guid?>("TestParametarID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("TipUzorka")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("TestID");

                    b.HasIndex("AdministratorID");

                    b.HasIndex("TestParametarID");

                    b.ToTable("Testovi");
                });

            modelBuilder.Entity("MedLabO.Services.Database.TestParametar", b =>
                {
                    b.Property<Guid>("TestParametarID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Jedinica")
                        .HasColumnType("nvarchar(max)");

                    b.Property<float?>("MaxVrijednost")
                        .HasColumnType("real");

                    b.Property<float?>("MinVrijednost")
                        .HasColumnType("real");

                    b.Property<string>("NormalnaVrijednost")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("TestParametarID");

                    b.ToTable("TestParametri");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Usluga", b =>
                {
                    b.Property<Guid>("UslugaID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid?>("AdministratorID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<decimal>("Cijena")
                        .HasColumnType("decimal(18,2)");

                    b.Property<DateTime>("DTKreiranja")
                        .HasColumnType("datetime2");

                    b.Property<DateTime?>("DTZadnjeModifikacije")
                        .HasColumnType("datetime2");

                    b.Property<bool>("Dostupno")
                        .HasColumnType("bit");

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Opis")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<float>("RezultatUH")
                        .HasColumnType("real");

                    b.Property<byte[]>("Slika")
                        .HasColumnType("varbinary(max)");

                    b.Property<int>("TrajanjeUMin")
                        .HasColumnType("int");

                    b.HasKey("UslugaID");

                    b.HasIndex("AdministratorID");

                    b.ToTable("Usluge");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Zakljucak", b =>
                {
                    b.Property<Guid>("TerminID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Detaljno")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Opis")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("TerminID");

                    b.ToTable("Zakljucci");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Zvanje", b =>
                {
                    b.Property<Guid>("ZvanjeID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Naziv")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Opis")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("ZvanjeID");

                    b.ToTable("Zvanja");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRole<System.Guid>", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("ConcurrencyStamp")
                        .IsConcurrencyToken()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Name")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.Property<string>("NormalizedName")
                        .HasMaxLength(256)
                        .HasColumnType("nvarchar(256)");

                    b.HasKey("Id");

                    b.HasIndex("NormalizedName")
                        .IsUnique()
                        .HasDatabaseName("RoleNameIndex")
                        .HasFilter("[NormalizedName] IS NOT NULL");

                    b.ToTable("AspNetRoles", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<System.Guid>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("ClaimType")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("ClaimValue")
                        .HasColumnType("nvarchar(max)");

                    b.Property<Guid>("RoleId")
                        .HasColumnType("uniqueidentifier");

                    b.HasKey("Id");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetRoleClaims", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<System.Guid>", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("ClaimType")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("ClaimValue")
                        .HasColumnType("nvarchar(max)");

                    b.Property<Guid>("UserId")
                        .HasColumnType("uniqueidentifier");

                    b.HasKey("Id");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserClaims", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<System.Guid>", b =>
                {
                    b.Property<string>("LoginProvider")
                        .HasMaxLength(128)
                        .HasColumnType("nvarchar(128)");

                    b.Property<string>("ProviderKey")
                        .HasMaxLength(128)
                        .HasColumnType("nvarchar(128)");

                    b.Property<string>("ProviderDisplayName")
                        .HasColumnType("nvarchar(max)");

                    b.Property<Guid>("UserId")
                        .HasColumnType("uniqueidentifier");

                    b.HasKey("LoginProvider", "ProviderKey");

                    b.HasIndex("UserId");

                    b.ToTable("AspNetUserLogins", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<System.Guid>", b =>
                {
                    b.Property<Guid>("UserId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid>("RoleId")
                        .HasColumnType("uniqueidentifier");

                    b.HasKey("UserId", "RoleId");

                    b.HasIndex("RoleId");

                    b.ToTable("AspNetUserRoles", (string)null);
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<System.Guid>", b =>
                {
                    b.Property<Guid>("UserId")
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("LoginProvider")
                        .HasMaxLength(128)
                        .HasColumnType("nvarchar(128)");

                    b.Property<string>("Name")
                        .HasMaxLength(128)
                        .HasColumnType("nvarchar(128)");

                    b.Property<string>("Value")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("UserId", "LoginProvider", "Name");

                    b.ToTable("AspNetUserTokens", (string)null);
                });

            modelBuilder.Entity("TerminUsluga", b =>
                {
                    b.Property<Guid>("TerminUslugeUslugaID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid>("UslugaTerminiTerminID")
                        .HasColumnType("uniqueidentifier");

                    b.HasKey("TerminUslugeUslugaID", "UslugaTerminiTerminID");

                    b.HasIndex("UslugaTerminiTerminID");

                    b.ToTable("TerminUsluga");
                });

            modelBuilder.Entity("TestUsluga", b =>
                {
                    b.Property<Guid>("TestUslugeUslugaID")
                        .HasColumnType("uniqueidentifier");

                    b.Property<Guid>("UslugaTestoviTestID")
                        .HasColumnType("uniqueidentifier");

                    b.HasKey("TestUslugeUslugaID", "UslugaTestoviTestID");

                    b.HasIndex("UslugaTestoviTestID");

                    b.ToTable("TestUsluga");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Administrator", b =>
                {
                    b.HasBaseType("MedLabO.Services.Database.ApplicationUser");

                    b.Property<string>("Ime")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("IsKontakt")
                        .HasColumnType("bit");

                    b.Property<string>("KontaktInfo")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Prezime")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasDiscriminator().HasValue("Administrator");
                });

            modelBuilder.Entity("MedLabO.Services.Database.MedicinskoOsoblje", b =>
                {
                    b.HasBaseType("MedLabO.Services.Database.ApplicationUser");

                    b.Property<DateTime?>("DTPrekidRadnogOdnosa")
                        .HasColumnType("datetime2");

                    b.Property<DateTime>("DTZaposlenja")
                        .HasColumnType("datetime2");

                    b.Property<string>("Ime")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("MedicinskoOsoblje_Ime");

                    b.Property<bool>("IsActive")
                        .HasColumnType("bit");

                    b.Property<string>("Prezime")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("MedicinskoOsoblje_Prezime");

                    b.Property<int?>("SpolID")
                        .HasColumnType("int");

                    b.Property<Guid?>("ZvanjeID")
                        .HasColumnType("uniqueidentifier");

                    b.HasIndex("SpolID");

                    b.HasIndex("ZvanjeID");

                    b.HasDiscriminator().HasValue("MedicinskoOsoblje");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Pacijent", b =>
                {
                    b.HasBaseType("MedLabO.Services.Database.ApplicationUser");

                    b.Property<string>("Adresa")
                        .HasColumnType("nvarchar(max)");

                    b.Property<DateTime>("DatumRodjenja")
                        .HasColumnType("datetime2");

                    b.Property<string>("Ime")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("Pacijent_Ime");

                    b.Property<string>("Prezime")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)")
                        .HasColumnName("Pacijent_Prezime");

                    b.Property<int?>("SpolID")
                        .HasColumnType("int")
                        .HasColumnName("Pacijent_SpolID");

                    b.HasIndex("SpolID");

                    b.HasDiscriminator().HasValue("Pacijent");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Novost", b =>
                {
                    b.HasOne("MedLabO.Services.Database.Administrator", "Administrator")
                        .WithMany("KreiraneNovosti")
                        .HasForeignKey("AdministratorID");

                    b.Navigation("Administrator");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Obavijest", b =>
                {
                    b.HasOne("MedLabO.Services.Database.Administrator", "Administrator")
                        .WithMany("KreiraneObavijesti")
                        .HasForeignKey("AdministratorID");

                    b.Navigation("Administrator");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Termin", b =>
                {
                    b.HasOne("MedLabO.Services.Database.MedicinskoOsoblje", "MedicinskoOsoblje")
                        .WithMany("OdobreniTermini")
                        .HasForeignKey("MedicinskoOsobljeID");

                    b.HasOne("MedLabO.Services.Database.Pacijent", "Pacijent")
                        .WithMany("Termini")
                        .HasForeignKey("PacijentID");

                    b.HasOne("MedLabO.Services.Database.Racun", "Racun")
                        .WithOne("Termin")
                        .HasForeignKey("MedLabO.Services.Database.Termin", "RacunID");

                    b.HasOne("MedLabO.Services.Database.Zakljucak", "Zakljucak")
                        .WithOne("Termin")
                        .HasForeignKey("MedLabO.Services.Database.Termin", "ZakljucakID");

                    b.Navigation("MedicinskoOsoblje");

                    b.Navigation("Pacijent");

                    b.Navigation("Racun");

                    b.Navigation("Zakljucak");
                });

            modelBuilder.Entity("MedLabO.Services.Database.TerminTest", b =>
                {
                    b.HasOne("MedLabO.Services.Database.Rezultat", "Rezultat")
                        .WithMany()
                        .HasForeignKey("RezultatID");

                    b.HasOne("MedLabO.Services.Database.Termin", "Termin")
                        .WithMany("TestTerminRezultati")
                        .HasForeignKey("TerminID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("MedLabO.Services.Database.Test", "Test")
                        .WithMany("TerminTestovi")
                        .HasForeignKey("TestID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Rezultat");

                    b.Navigation("Termin");

                    b.Navigation("Test");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Test", b =>
                {
                    b.HasOne("MedLabO.Services.Database.Administrator", "Administrator")
                        .WithMany("KreiraniTestovi")
                        .HasForeignKey("AdministratorID");

                    b.HasOne("MedLabO.Services.Database.TestParametar", "TestParametar")
                        .WithMany()
                        .HasForeignKey("TestParametarID");

                    b.Navigation("Administrator");

                    b.Navigation("TestParametar");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Usluga", b =>
                {
                    b.HasOne("MedLabO.Services.Database.Administrator", null)
                        .WithMany("KreiraneUsluge")
                        .HasForeignKey("AdministratorID");
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityRoleClaim<System.Guid>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole<System.Guid>", null)
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserClaim<System.Guid>", b =>
                {
                    b.HasOne("MedLabO.Services.Database.ApplicationUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserLogin<System.Guid>", b =>
                {
                    b.HasOne("MedLabO.Services.Database.ApplicationUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserRole<System.Guid>", b =>
                {
                    b.HasOne("Microsoft.AspNetCore.Identity.IdentityRole<System.Guid>", null)
                        .WithMany()
                        .HasForeignKey("RoleId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("MedLabO.Services.Database.ApplicationUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("Microsoft.AspNetCore.Identity.IdentityUserToken<System.Guid>", b =>
                {
                    b.HasOne("MedLabO.Services.Database.ApplicationUser", null)
                        .WithMany()
                        .HasForeignKey("UserId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("TerminUsluga", b =>
                {
                    b.HasOne("MedLabO.Services.Database.Usluga", null)
                        .WithMany()
                        .HasForeignKey("TerminUslugeUslugaID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("MedLabO.Services.Database.Termin", null)
                        .WithMany()
                        .HasForeignKey("UslugaTerminiTerminID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("TestUsluga", b =>
                {
                    b.HasOne("MedLabO.Services.Database.Usluga", null)
                        .WithMany()
                        .HasForeignKey("TestUslugeUslugaID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("MedLabO.Services.Database.Test", null)
                        .WithMany()
                        .HasForeignKey("UslugaTestoviTestID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();
                });

            modelBuilder.Entity("MedLabO.Services.Database.MedicinskoOsoblje", b =>
                {
                    b.HasOne("MedLabO.Services.Database.Spol", "Spol")
                        .WithMany()
                        .HasForeignKey("SpolID");

                    b.HasOne("MedLabO.Services.Database.Zvanje", "Zvanje")
                        .WithMany("MedicinskoOsoblje")
                        .HasForeignKey("ZvanjeID");

                    b.Navigation("Spol");

                    b.Navigation("Zvanje");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Pacijent", b =>
                {
                    b.HasOne("MedLabO.Services.Database.Spol", "Spol")
                        .WithMany()
                        .HasForeignKey("SpolID");

                    b.Navigation("Spol");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Racun", b =>
                {
                    b.Navigation("Termin")
                        .IsRequired();
                });

            modelBuilder.Entity("MedLabO.Services.Database.Termin", b =>
                {
                    b.Navigation("TestTerminRezultati");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Test", b =>
                {
                    b.Navigation("TerminTestovi");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Zakljucak", b =>
                {
                    b.Navigation("Termin")
                        .IsRequired();
                });

            modelBuilder.Entity("MedLabO.Services.Database.Zvanje", b =>
                {
                    b.Navigation("MedicinskoOsoblje");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Administrator", b =>
                {
                    b.Navigation("KreiraneNovosti");

                    b.Navigation("KreiraneObavijesti");

                    b.Navigation("KreiraneUsluge");

                    b.Navigation("KreiraniTestovi");
                });

            modelBuilder.Entity("MedLabO.Services.Database.MedicinskoOsoblje", b =>
                {
                    b.Navigation("OdobreniTermini");
                });

            modelBuilder.Entity("MedLabO.Services.Database.Pacijent", b =>
                {
                    b.Navigation("Termini");
                });
#pragma warning restore 612, 618
        }
    }
}
