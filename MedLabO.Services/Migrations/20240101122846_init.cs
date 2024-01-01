using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MedLabO.Services.Migrations
{
    public partial class init : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "AspNetRoles",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    NormalizedName = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    ConcurrencyStamp = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetRoles", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Rezultati",
                columns: table => new
                {
                    RezultatID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    DTRezultata = table.Column<DateTime>(type: "datetime2", nullable: false),
                    TestZakljucak = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Obiljezen = table.Column<bool>(type: "bit", nullable: false),
                    RezFlo = table.Column<float>(type: "real", nullable: true),
                    RezStr = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    RazlikaOdNormalne = table.Column<float>(type: "real", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Rezultati", x => x.RezultatID);
                });

            migrationBuilder.CreateTable(
                name: "Spolovi",
                columns: table => new
                {
                    SpolID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Kod = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Spolovi", x => x.SpolID);
                });

            migrationBuilder.CreateTable(
                name: "TestParametri",
                columns: table => new
                {
                    TestParametarID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    MinVrijednost = table.Column<float>(type: "real", nullable: true),
                    MaxVrijednost = table.Column<float>(type: "real", nullable: true),
                    NormalnaVrijednost = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Jedinica = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TestParametri", x => x.TestParametarID);
                });

            migrationBuilder.CreateTable(
                name: "Zvanja",
                columns: table => new
                {
                    ZvanjeID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Zvanja", x => x.ZvanjeID);
                });

            migrationBuilder.CreateTable(
                name: "AspNetRoleClaims",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RoleId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    ClaimType = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ClaimValue = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetRoleClaims", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AspNetRoleClaims_AspNetRoles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "AspNetRoles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUsers",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    isDeleted = table.Column<bool>(type: "bit", nullable: false),
                    Discriminator = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    IsKontakt = table.Column<bool>(type: "bit", nullable: true),
                    KontaktInfo = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MedicinskoOsoblje_Ime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MedicinskoOsoblje_Prezime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    IsActive = table.Column<bool>(type: "bit", nullable: true),
                    DTZaposlenja = table.Column<DateTime>(type: "datetime2", nullable: true),
                    DTPrekidRadnogOdnosa = table.Column<DateTime>(type: "datetime2", nullable: true),
                    SpolID = table.Column<int>(type: "int", nullable: true),
                    ZvanjeID = table.Column<int>(type: "int", nullable: true),
                    Pacijent_Ime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Pacijent_Prezime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DatumRodjenja = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Adresa = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Pacijent_SpolID = table.Column<int>(type: "int", nullable: true),
                    UserName = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    NormalizedUserName = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    Email = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    NormalizedEmail = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    EmailConfirmed = table.Column<bool>(type: "bit", nullable: false),
                    PasswordHash = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    SecurityStamp = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ConcurrencyStamp = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PhoneNumber = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PhoneNumberConfirmed = table.Column<bool>(type: "bit", nullable: false),
                    TwoFactorEnabled = table.Column<bool>(type: "bit", nullable: false),
                    LockoutEnd = table.Column<DateTimeOffset>(type: "datetimeoffset", nullable: true),
                    LockoutEnabled = table.Column<bool>(type: "bit", nullable: false),
                    AccessFailedCount = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUsers", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AspNetUsers_Spolovi_Pacijent_SpolID",
                        column: x => x.Pacijent_SpolID,
                        principalTable: "Spolovi",
                        principalColumn: "SpolID");
                    table.ForeignKey(
                        name: "FK_AspNetUsers_Spolovi_SpolID",
                        column: x => x.SpolID,
                        principalTable: "Spolovi",
                        principalColumn: "SpolID");
                    table.ForeignKey(
                        name: "FK_AspNetUsers_Zvanja_ZvanjeID",
                        column: x => x.ZvanjeID,
                        principalTable: "Zvanja",
                        principalColumn: "ZvanjeID");
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserClaims",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    ClaimType = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ClaimValue = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserClaims", x => x.Id);
                    table.ForeignKey(
                        name: "FK_AspNetUserClaims_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserLogins",
                columns: table => new
                {
                    LoginProvider = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: false),
                    ProviderKey = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: false),
                    ProviderDisplayName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    UserId = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserLogins", x => new { x.LoginProvider, x.ProviderKey });
                    table.ForeignKey(
                        name: "FK_AspNetUserLogins_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserRoles",
                columns: table => new
                {
                    UserId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    RoleId = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserRoles", x => new { x.UserId, x.RoleId });
                    table.ForeignKey(
                        name: "FK_AspNetUserRoles_AspNetRoles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "AspNetRoles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AspNetUserRoles_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "AspNetUserTokens",
                columns: table => new
                {
                    UserId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    LoginProvider = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: false),
                    Name = table.Column<string>(type: "nvarchar(128)", maxLength: 128, nullable: false),
                    Value = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetUserTokens", x => new { x.UserId, x.LoginProvider, x.Name });
                    table.ForeignKey(
                        name: "FK_AspNetUserTokens_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Novosti",
                columns: table => new
                {
                    NovostID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Naslov = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Sadrzaj = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DTKreiranja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DTZadnjeModifikacije = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    AdministratorID = table.Column<Guid>(type: "uniqueidentifier", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Novosti", x => x.NovostID);
                    table.ForeignKey(
                        name: "FK_Novosti_AspNetUsers_AdministratorID",
                        column: x => x.AdministratorID,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Obavijesti",
                columns: table => new
                {
                    ObavijestID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Naslov = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Sadrzaj = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DTKreiranja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DTZadnjeModifikacije = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    AdministratorID = table.Column<Guid>(type: "uniqueidentifier", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Obavijesti", x => x.ObavijestID);
                    table.ForeignKey(
                        name: "FK_Obavijesti_AspNetUsers_AdministratorID",
                        column: x => x.AdministratorID,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "Testovi",
                columns: table => new
                {
                    TestID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    NapomenaZaPripremu = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    TipUzorka = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DTKreiranja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    AdministratorID = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    TestParametarID = table.Column<Guid>(type: "uniqueidentifier", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Testovi", x => x.TestID);
                    table.ForeignKey(
                        name: "FK_Testovi_AspNetUsers_AdministratorID",
                        column: x => x.AdministratorID,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Testovi_TestParametri_TestParametarID",
                        column: x => x.TestParametarID,
                        principalTable: "TestParametri",
                        principalColumn: "TestParametarID");
                });

            migrationBuilder.CreateTable(
                name: "Usluge",
                columns: table => new
                {
                    UslugaID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    TrajanjeUMin = table.Column<int>(type: "int", nullable: false),
                    RezultatUH = table.Column<float>(type: "real", nullable: false),
                    Dostupno = table.Column<bool>(type: "bit", nullable: false),
                    DTKreiranja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DTZadnjeModifikacije = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    AdministratorID = table.Column<Guid>(type: "uniqueidentifier", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Usluge", x => x.UslugaID);
                    table.ForeignKey(
                        name: "FK_Usluge_AspNetUsers_AdministratorID",
                        column: x => x.AdministratorID,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "TestUsluga",
                columns: table => new
                {
                    TestUslugeUslugaID = table.Column<int>(type: "int", nullable: false),
                    UslugaTestoviTestID = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TestUsluga", x => new { x.TestUslugeUslugaID, x.UslugaTestoviTestID });
                    table.ForeignKey(
                        name: "FK_TestUsluga_Testovi_UslugaTestoviTestID",
                        column: x => x.UslugaTestoviTestID,
                        principalTable: "Testovi",
                        principalColumn: "TestID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_TestUsluga_Usluge_TestUslugeUslugaID",
                        column: x => x.TestUslugeUslugaID,
                        principalTable: "Usluge",
                        principalColumn: "UslugaID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Racuni",
                columns: table => new
                {
                    RacunID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Placeno = table.Column<bool>(type: "bit", nullable: false),
                    TerminID = table.Column<Guid>(type: "uniqueidentifier", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Racuni", x => x.RacunID);
                });

            migrationBuilder.CreateTable(
                name: "Termini",
                columns: table => new
                {
                    TerminID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    DTTermina = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: true),
                    Napomena = table.Column<string>(type: "nvarchar(300)", maxLength: 300, nullable: true),
                    Odgovor = table.Column<string>(type: "nvarchar(300)", maxLength: 300, nullable: true),
                    RazlogOtkazivanja = table.Column<string>(type: "nvarchar(300)", maxLength: 300, nullable: true),
                    Obavljen = table.Column<bool>(type: "bit", nullable: false),
                    RezultatDodan = table.Column<bool>(type: "bit", nullable: false),
                    ZakljucakDodan = table.Column<bool>(type: "bit", nullable: false),
                    Placeno = table.Column<bool>(type: "bit", nullable: false),
                    RezultatTerminaPDF = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    PacijentID = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    MedicinskoOsobljeID = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    RacunID = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    ZakljucakID = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    isDeleted = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Termini", x => x.TerminID);
                    table.ForeignKey(
                        name: "FK_Termini_AspNetUsers_MedicinskoOsobljeID",
                        column: x => x.MedicinskoOsobljeID,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Termini_AspNetUsers_PacijentID",
                        column: x => x.PacijentID,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Termini_Racuni_RacunID",
                        column: x => x.RacunID,
                        principalTable: "Racuni",
                        principalColumn: "RacunID");
                });

            migrationBuilder.CreateTable(
                name: "TerminTest",
                columns: table => new
                {
                    TestID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    TerminID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    RezultatID = table.Column<Guid>(type: "uniqueidentifier", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TerminTest", x => new { x.TestID, x.TerminID });
                    table.ForeignKey(
                        name: "FK_TerminTest_Rezultati_RezultatID",
                        column: x => x.RezultatID,
                        principalTable: "Rezultati",
                        principalColumn: "RezultatID");
                    table.ForeignKey(
                        name: "FK_TerminTest_Termini_TerminID",
                        column: x => x.TerminID,
                        principalTable: "Termini",
                        principalColumn: "TerminID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_TerminTest_Testovi_TestID",
                        column: x => x.TestID,
                        principalTable: "Testovi",
                        principalColumn: "TestID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "TerminUsluga",
                columns: table => new
                {
                    TerminUslugeUslugaID = table.Column<int>(type: "int", nullable: false),
                    UslugaTerminiTerminID = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TerminUsluga", x => new { x.TerminUslugeUslugaID, x.UslugaTerminiTerminID });
                    table.ForeignKey(
                        name: "FK_TerminUsluga_Termini_UslugaTerminiTerminID",
                        column: x => x.UslugaTerminiTerminID,
                        principalTable: "Termini",
                        principalColumn: "TerminID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_TerminUsluga_Usluge_TerminUslugeUslugaID",
                        column: x => x.TerminUslugeUslugaID,
                        principalTable: "Usluge",
                        principalColumn: "UslugaID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Zakljucci",
                columns: table => new
                {
                    ZakljucakID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Detaljno = table.Column<string>(type: "nvarchar(max)", maxLength: 10000, nullable: false),
                    TerminID = table.Column<Guid>(type: "uniqueidentifier", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Zakljucci", x => x.ZakljucakID);
                    table.ForeignKey(
                        name: "FK_Zakljucci_Termini_TerminID",
                        column: x => x.TerminID,
                        principalTable: "Termini",
                        principalColumn: "TerminID");
                });

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { new Guid("0507e219-2779-4096-8d17-a1a91055dfda"), "33bdaece-3b05-4c3d-9e28-6d25aadea48f", "Administrator", "ADMINISTRATOR" },
                    { new Guid("6d333ed3-85ff-4863-93cc-76701acb9e52"), "3a291db2-ba0f-48fa-bc42-724a7d05ae50", "MedicinskoOsoblje", "MEDICINSKOOSOBLJE" },
                    { new Guid("c4f2036e-1b4c-4ac8-836c-f40f09a01a98"), "2d1c96f2-34c3-498d-a8f2-c04aab32944a", "Pacijent", "PACIJENT" }
                });

            migrationBuilder.InsertData(
                table: "AspNetUsers",
                columns: new[] { "Id", "AccessFailedCount", "ConcurrencyStamp", "Discriminator", "Email", "EmailConfirmed", "Ime", "IsKontakt", "KontaktInfo", "LockoutEnabled", "LockoutEnd", "NormalizedEmail", "NormalizedUserName", "PasswordHash", "PhoneNumber", "PhoneNumberConfirmed", "Prezime", "SecurityStamp", "TwoFactorEnabled", "UserName", "isDeleted" },
                values: new object[] { new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 0, "6fe96a41-e729-4b98-b77e-f3f12d4f5130", "Administrator", "administrator@gmail.com", true, "Administrator", true, "administrator@gmail.com", false, null, "ADMINISTRATOR@GMAIL.COM", "ADMINISTRATOR", "AQAAAAEAACcQAAAAEGkOoR+cGiA+ARYPMO/o7JiECUfSxXPCV9IpSjTvFqt8hfAvvj0/2WXjmITiflzgRg==", "0601234567", true, "Administrator", "3b110b08-3940-425f-b7bf-cebda20a7605", false, "administrator", false });

            migrationBuilder.InsertData(
                table: "Racuni",
                columns: new[] { "RacunID", "Cijena", "Placeno", "TerminID" },
                values: new object[,]
                {
                    { new Guid("0bdc8864-0879-4401-8879-a5be3496cf6d"), 9m, true, null },
                    { new Guid("0fb113db-16af-4675-bcbf-c18709429e2a"), 21m, true, null },
                    { new Guid("1186f71a-e2d2-4db2-bf14-2b7727859c74"), 4m, true, null },
                    { new Guid("18356cdd-fba4-4d5b-a33c-e1d09894a145"), 11m, true, null },
                    { new Guid("2057cdbf-4bd4-4071-a2bc-5e19c0183c40"), 10m, true, null },
                    { new Guid("3c19770e-223d-43fe-8d15-3ba1fe7151fe"), 10m, true, null },
                    { new Guid("5461ce30-ad9c-49cb-9371-c5fd231fbf63"), 11m, true, null },
                    { new Guid("58f643cf-1079-4177-950e-a97162657093"), 11m, true, null },
                    { new Guid("6b746e04-31ac-46f5-ad2e-33bdea321d63"), 10m, true, null },
                    { new Guid("8d166154-fd43-485a-8263-93efdb69ac4c"), 11m, true, null },
                    { new Guid("903ab20a-1aea-493e-8e3c-05564353bc54"), 20m, true, null },
                    { new Guid("b35cef5e-0471-4ff2-99f0-6ecbd1d390f5"), 21m, true, null },
                    { new Guid("b36b8aaf-2c31-47df-88c8-e76d96e41c56"), 11m, true, null },
                    { new Guid("c6781a23-2c71-4dfe-a934-8597c0688812"), 36m, true, null },
                    { new Guid("e8f45c95-f42a-4220-841d-1ec3e4998f48"), 14m, true, null },
                    { new Guid("eca7c955-9ce4-42ab-a33a-0f2c08f1e38c"), 14m, true, null }
                });

            migrationBuilder.InsertData(
                table: "Spolovi",
                columns: new[] { "SpolID", "Kod", "Naziv" },
                values: new object[,]
                {
                    { 1, "M", "Muško" },
                    { 2, "Ž", "Žensko" },
                    { 3, "N", "Nepoznato" }
                });

            migrationBuilder.InsertData(
                table: "TestParametri",
                columns: new[] { "TestParametarID", "Jedinica", "MaxVrijednost", "MinVrijednost", "NormalnaVrijednost" },
                values: new object[,]
                {
                    { new Guid("0fe0697a-aa20-4e20-b152-58f6ed44efc3"), "mg/L", 5f, 0f, null },
                    { new Guid("46cba49e-0b4b-4018-ae70-5c9ceae529b5"), "mmol/L", 5.8f, 3.9f, null },
                    { new Guid("75b1dbb5-6b3c-4c76-8044-caff96608e08"), null, null, null, "Negativno na maligne stanice" },
                    { new Guid("77886ff8-caf5-4247-ae64-62e1a8c0969f"), "mg/dL", 20.5f, 1.2f, null },
                    { new Guid("788e2d86-4fc5-49a8-994e-541180dba9bb"), "mm/h", 30f, 0f, null },
                    { new Guid("84bfaf38-20b5-4648-b8f0-9d2c4cf7b95a"), null, null, null, "Negativno na MRSA" },
                    { new Guid("901a4f75-3529-4b57-b9c0-8dd99f495d32"), "U/L", 40f, 0f, null },
                    { new Guid("bab9d588-8ff1-4355-96fd-f94d9bdb4a8d"), "x10^12/L", 5.9f, 3.8f, null },
                    { new Guid("d70a4bfa-38c0-4d41-a090-208404e57209"), "x10^9/L", 11f, 4f, null },
                    { new Guid("e16fecb2-a4cf-41fd-a264-18dbc8a25cc8"), "mg/L", 30f, 0f, null },
                    { new Guid("e4f11b51-c4e6-473d-9221-c617354745f3"), "mmol/L", 2.3f, 0f, null },
                    { new Guid("e8319b5a-0868-4fef-b356-32f9fdabbd82"), "g/L", 355f, 320f, null },
                    { new Guid("e8e1e4b9-7fe9-4015-9f62-f3c844e831ce"), "mmol/L", 7.8f, 3.6f, null }
                });

            migrationBuilder.InsertData(
                table: "Zvanja",
                columns: new[] { "ZvanjeID", "Naziv", "Opis" },
                values: new object[,]
                {
                    { 1, "Ljekar", "Ljekar u medicinskom laboratoriju specijaliziran je za analizu bioloških uzoraka, dijagnosticiranje bolesti i savjetovanje ostalih zdravstvenih radnika, koristeći naprednu laboratorijsku tehnologiju." },
                    { 2, "Laboratorijski tehničar", "U medicinskom laboratoriju, laboratorijski tehničar precizno izvodi testiranja, održava laboratorijsku opremu i pomaže u interpretaciji rezultata testova." }
                });

            migrationBuilder.InsertData(
                table: "AspNetUserRoles",
                columns: new[] { "RoleId", "UserId" },
                values: new object[] { new Guid("0507e219-2779-4096-8d17-a1a91055dfda"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58") });

            migrationBuilder.InsertData(
                table: "AspNetUsers",
                columns: new[] { "Id", "AccessFailedCount", "ConcurrencyStamp", "DTPrekidRadnogOdnosa", "DTZaposlenja", "Discriminator", "Email", "EmailConfirmed", "MedicinskoOsoblje_Ime", "IsActive", "LockoutEnabled", "LockoutEnd", "NormalizedEmail", "NormalizedUserName", "PasswordHash", "PhoneNumber", "PhoneNumberConfirmed", "MedicinskoOsoblje_Prezime", "SecurityStamp", "SpolID", "TwoFactorEnabled", "UserName", "ZvanjeID", "isDeleted" },
                values: new object[] { new Guid("09098d7d-1be0-4d0b-926d-9eb493d81dcc"), 0, "53f6a720-c8cc-4f6c-a4a4-ef70b73c6bf5", null, new DateTime(2020, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "MedicinskoOsoblje", "medicinskoOsoblje@gmail.com", true, "MedicinskoOsoblje", true, false, null, "MEDICINSKOOSOBLJE@GMAIL.COM", "MEDICINSKOOSOBLJE", "AQAAAAEAACcQAAAAEGkOoR+cGiA+ARYPMO/o7JiECUfSxXPCV9IpSjTvFqt8hfAvvj0/2WXjmITiflzgRg==", "0607654321", true, "MedicinskoOsoblje", "2aa1af3c-765c-4dc4-ac2c-7216939e3f1e", 2, false, "medicinskoOsoblje", 1, false });

            migrationBuilder.InsertData(
                table: "AspNetUsers",
                columns: new[] { "Id", "AccessFailedCount", "Adresa", "ConcurrencyStamp", "DatumRodjenja", "Discriminator", "Email", "EmailConfirmed", "Pacijent_Ime", "LockoutEnabled", "LockoutEnd", "NormalizedEmail", "NormalizedUserName", "PasswordHash", "PhoneNumber", "PhoneNumberConfirmed", "Pacijent_Prezime", "SecurityStamp", "Pacijent_SpolID", "TwoFactorEnabled", "UserName", "isDeleted" },
                values: new object[] { new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28"), 0, "Ulica Prva 11", "ee1c5d57-e06b-4b35-b200-c80ff2242cbd", new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), "Pacijent", "pacijent@gmail.com", true, "Pacijent", false, null, "PACIJENT@GMAIL.COM", "PACIJENT", "AQAAAAEAACcQAAAAEGkOoR+cGiA+ARYPMO/o7JiECUfSxXPCV9IpSjTvFqt8hfAvvj0/2WXjmITiflzgRg==", "0605555555", true, "Pacijent", "7568e1b2-a164-437b-8c85-a232269f08c3", 1, false, "pacijent", false });

            migrationBuilder.InsertData(
                table: "Novosti",
                columns: new[] { "NovostID", "AdministratorID", "DTKreiranja", "DTZadnjeModifikacije", "Naslov", "Sadrzaj", "Slika" },
                values: new object[,]
                {
                    { new Guid("325d2b08-9822-4ef1-acbd-2d4528bbeebc"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3621), null, "Uvođenje Online Rezervacija Termina", "S ciljem poboljšanja naših usluga i olakšavanja pristupa zdravstvenoj skrbi, uvodimo novi sustav online rezervacija termina putem naše web stranice. Od sada, možete jednostavno i brzo rezervirati svoj termin za testiranje također putem naše web stranice. Ovaj sustav omogućava vam da izaberete datum i vrijeme koje vam najviše odgovara, bez potrebe za čekanjem u redu ili telefonskim pozivima. Također, putem sustava možete pratiti svoje rezervacije, dobiti podsjetnike za nadolazeće termine i pristupiti rezultatima testiranja. Naš cilj je učiniti proces testiranja što jednostavnijim i ugodnijim za vas, te vam pružiti brz i efikasan pristup informacijama o vašem zdravlju. Pozivamo vas da isprobate naš novi sustav rezervacija i podijelite s nama svoje dojmove.", new byte[0] },
                    { new Guid("465a1478-3027-498f-aa82-b46b9a0ec4ee"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3604), null, "Obavijest o Radnom Vremenu za Praznike", "Obavještavamo naše cijenjene pacijente da će tijekom nadolazećih praznika doći do promjena u radnom vremenu našeg laboratorija. Na Badnjak i Staru godinu laboratorij će raditi skraćeno, do 12:00 sati, dok će na Božić i Novu godinu laboratorij biti zatvoren. Molimo vas da planirate svoje posjete i testiranja sukladno ovom rasporedu. Također, želimo iskoristiti ovu priliku da vam zaželimo sretne i mirne praznike. Neka ovo vrijeme bude ispunjeno zdravljem, srećom i radosti. U novoj godini nastavljamo s našom misijom pružanja vrhunske zdravstvene skrbi i usluga. Hvala vam što ste dio naše zajednice i što nam vjerujete brigu o vašem zdravlju.", new byte[0] },
                    { new Guid("7fa51a3e-501c-4466-90e2-1eba0a549d23"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3636), null, "Modernizacija Laboratorijske Opreme", "S ponosom vas obavještavamo o nedavnoj modernizaciji naše laboratorijske opreme. Ulaganjem u najnovije tehnologije, osigurali smo da naši pacijenti imaju pristup najpreciznijim i najbržim dijagnostičkim testovima. Nova oprema omogućava nam da proširimo spektar testova, smanjimo vrijeme čekanja na rezultate i povećamo tačnost dijagnostike. Ovo je važan korak u našem nastojanju da pružimo vrhunsku medicinsku skrb i podršku našim pacijentima. Vjerujemo da će ove promjene značajno doprinijeti kvaliteti i efikasnosti naših usluga, te vam omogućiti bolje upravljanje vašim zdravljem. Zahvaljujemo vam na povjerenju i radujemo se što ćemo vam pružiti još bolju uslugu uz pomoć ove napredne tehnologije.", new byte[0] },
                    { new Guid("be49f5ad-6d18-435e-97a5-13600af6b4e5"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3581), null, "Dan Otvorenih Vrata u Laboratoriju", "Pozivamo vas na Dan otvorenih vrata koji će se održati 15.04.2023. u našem laboratoriju. Ovo je izvrsna prilika da se upoznate s našim radom, tehnologijama koje koristimo i timom stručnjaka koji brinu o vašem zdravlju. Tijekom ovog dana, moći ćete besplatno izvršiti osnovne zdravstvene preglede, sudjelovati u edukativnim radionicama i dobiti individualne savjete o zdravlju. Također, pripremili smo posebne popuste na odabrane testove i usluge. Ne propustite ovu priliku da saznate više o važnosti preventivnih pregleda i kako možete aktivno doprinijeti očuvanju svog zdravlja.", new byte[0] },
                    { new Guid("fc31fac7-27e4-41bd-95f4-da76a956bd23"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3559), null, "Novi Testovi Dostupni u Našem Laboratoriju", "Dragi pacijenti, s ponosom vas obavještavamo da smo proširili našu ponudu testova. Novi testovi uključuju napredne genetske analize, testove intolerancije na hranu, i detaljne hormonalne profile. Ovi testovi su dizajnirani da vam pruže dublji uvid u vaše zdravstveno stanje i omoguće personalizirani pristup liječenju. Naš tim stručnjaka je na raspolaganju da odgovori na sva vaša pitanja i pomogne vam odabrati najprikladnije testove za vaše potrebe. Posjetite nas i saznajte više o novim mogućnostima koje vam nudimo za očuvanje i unapređenje vašeg zdravlja.", new byte[0] }
                });

            migrationBuilder.InsertData(
                table: "Obavijesti",
                columns: new[] { "ObavijestID", "AdministratorID", "DTKreiranja", "DTZadnjeModifikacije", "Naslov", "Sadrzaj", "Slika" },
                values: new object[,]
                {
                    { new Guid("04cf6396-4405-43b0-87bc-fee864a88e2e"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3504), null, "Promjena Protokola za Obradu Uzoraka", "Obavještavamo sve zaposlenike da od 01.04.2023. stupaju na snagu novi protokoli za obradu uzoraka. Novi protokoli uključuju ažurirane postupke za rukovanje, analizu i pohranu uzoraka, s ciljem povećanja efikasnosti i tačnosti naših testova. Detaljne upute i obuke bit će organizirane u narednim sedmicama. Molimo sve zaposlenike da se upoznaju s novim protokolima i prate upute za obuku. Vaša suradnja i pridržavanje novih protokola su ključni za uspjeh ove promjene.", new byte[0] },
                    { new Guid("0e322352-b209-4dce-8369-9d7d67f38daf"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3472), null, "Neradni Dan - 18.02.2023.", "Poštovani kolege, obavještavamo vas da će laboratorij biti zatvoren 18.02.2023. zbog redovnog godišnjeg održavanja opreme i prostorija. Ovo je idealna prilika da se posvetite svom zdravlju i porodici, te da napunite baterije za nove radne izazove. Molimo vas da sve planirane aktivnosti prilagodite ovom datumu. Također, podsjećamo vas da je važno redovno pratiti stanje i održavanje opreme, kako bismo osigurali najviši standard naših usluga. Hvala vam na razumijevanju i suradnji.", new byte[0] },
                    { new Guid("55d8e97e-4379-4978-940a-d342158c5ce5"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3489), null, "Edukacijski Seminar za Zaposlenike", "Drage kolege, s velikim zadovoljstvom vas obavještavamo da ćemo 25.03.2023. organizirati edukacijski seminar na temu \"Najnovije tehnike u laboratorijskim ispitivanjima\". Seminar će voditi priznati stručnjaci u našem području rada. Ovo je izvrsna prilika za usavršavanje i razmjenu iskustava s kolegama iz struke. Seminar će se održati u konferencijskoj sali našeg laboratorija, s početkom u 10:00 sati. Molimo sve zainteresirane da potvrde svoje sudjelovanje najkasnije do 15.03.2023.", new byte[0] },
                    { new Guid("6cb8671d-2034-4bed-9a8b-1cf5a2f4d917"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3535), null, "Sigurnosne Mjere u Laboratoriju", "Sigurnost na radnom mjestu je naš prioritet. Stoga vas podsjećamo na važnost pridržavanja svih sigurnosnih protokola i procedura u laboratoriju. Ovo uključuje pravilno nošenje zaštitne opreme, pažljivo rukovanje uzorcima i hemikalijama, te održavanje čistoće i urednosti radnog prostora. Redovite provjere i obuke o sigurnosti bit će organizirane kako bismo osigurali da su svi upoznati s najboljim praksama i procedurama. Vaša sigurnost i zdravlje su od izuzetne važnosti, stoga vas molimo da ozbiljno shvatite ove mjere.", new byte[0] },
                    { new Guid("af32cfec-6818-44f2-9efa-053d24bebd9d"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3519), null, "Godišnji Plan Odmora", "Kako bismo osigurali kontinuirani rad laboratorija i zadovoljili potrebe naših pacijenata, molimo sve zaposlenike da do 15.04.2023. dostave svoje planove godišnjih odmora. Važno je da planiramo i koordiniramo odmore kako bismo izbjegli preklapanja i osigurali adekvatno osoblje u svakom trenutku. Molimo vas da razmotrite potrebe vašeg tima i laboratorija prilikom planiranja odmora. U slučaju bilo kakvih pitanja ili nedoumica, slobodno se obratite odjelu ljudskih resursa.", new byte[0] }
                });

            migrationBuilder.InsertData(
                table: "Testovi",
                columns: new[] { "TestID", "AdministratorID", "Cijena", "DTKreiranja", "NapomenaZaPripremu", "Naziv", "Opis", "Slika", "TestParametarID", "TipUzorka" },
                values: new object[,]
                {
                    { new Guid("0c1a4613-be50-48a6-abcb-a535870fe369"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 3.5m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3165), "Nema posebnih uputa.", "CRP", "Marker za upalu u tijelu.", new byte[0], new Guid("0fe0697a-aa20-4e20-b152-58f6ed44efc3"), "Krv" },
                    { new Guid("0c9db61b-d5e5-495d-876b-30ad80a8df3d"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 4.5m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3284), "Jutarnji sputum.", "Citologija sputuma", "Analiza sputuma za otkrivanje abnormalnih stanica.", new byte[0], new Guid("75b1dbb5-6b3c-4c76-8044-caff96608e08"), "Sputum" },
                    { new Guid("14a35eb5-c4bd-4a0b-9990-c8b493367bcf"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 3m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3193), "Nema posebnih uputa.", "Bilirubin", "Mjerenje bilirubina, važno za otkrivanje bolesti jetre i žučnih puteva.", new byte[0], new Guid("77886ff8-caf5-4247-ae64-62e1a8c0969f"), "Krv" },
                    { new Guid("1c978bd5-9777-4c05-b2ae-de4d3b9b4fc5"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 2.5m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3227), "Post od 12 sati prije testa.", "Holesterol", "Mjerenje ukupnog holesterola, važno za procjenu rizika od kardiovaskularnih bolesti.", new byte[0], new Guid("e8e1e4b9-7fe9-4015-9f62-f3c844e831ce"), "Krv" },
                    { new Guid("20b1bda2-14bc-4b3f-bac4-598e2a292519"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 2.5m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3255), "Post od 12 sati prije testa.", "Trigliceridi", "Mjerenje triglicerida, važno za procjenu rizika od srčanih bolesti.", new byte[0], new Guid("e4f11b51-c4e6-473d-9221-c617354745f3"), "Krv" },
                    { new Guid("54d120fc-224a-4710-9046-162d9b61c2d7"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 2.5m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3037), "Nema posebnih uputa.", "Eritrociti", "Broj eritrocita, važan za dijagnozu anemije i drugih poremećaja.", new byte[0], new Guid("bab9d588-8ff1-4355-96fd-f94d9bdb4a8d"), "Krv" },
                    { new Guid("59a5aaae-ec61-476d-84f5-2621d4054160"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 5m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3313), "Nema posebnih uputa.", "Nasalni bris za MRSA", "Testiranje na prisutnost MRSA (meticilin-rezistentni Staphylococcus aureus) u nosnoj šupljini.", new byte[0], new Guid("84bfaf38-20b5-4648-b8f0-9d2c4cf7b95a"), "Nasalni bris" },
                    { new Guid("8fff236b-4a25-4ed3-a138-f252ee4770eb"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 2.5m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3008), "Nema posebnih uputa.", "Leukociti", "Broj leukocita, važan za otkrivanje infekcija ili upalnih procesa.", new byte[0], new Guid("d70a4bfa-38c0-4d41-a090-208404e57209"), "Krv" },
                    { new Guid("a4a12d1c-b174-4938-8557-cb6281ccb2a6"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 2m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3139), "Nema posebnih uputa.", "Sedimentacija", "Brzina sedimentacije eritrocita, indikator upalnih procesa.", new byte[0], new Guid("788e2d86-4fc5-49a8-994e-541180dba9bb"), "Krv" },
                    { new Guid("ad25cc31-2b01-4ad3-bf2e-1fe4b53a3f25"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 3m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3105), "Nema posebnih uputa.", "AST", "Enzim važan za otkrivanje oštećenja jetre.", new byte[0], new Guid("901a4f75-3529-4b57-b9c0-8dd99f495d32"), "Krv" },
                    { new Guid("d687ff9d-1ec4-4aa9-a4f3-2eb5149d2212"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 2m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(2971), "Post od 8 sati prije testa.", "Glukoza", "Mjerenje glukoze u krvi, važno za dijagnozu i praćenje dijabetesa.", new byte[0], new Guid("46cba49e-0b4b-4018-ae70-5c9ceae529b5"), "Krv" },
                    { new Guid("d9f7156c-a460-4a7c-b51c-ef7d859244af"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 3m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3343), "Jutarnji urin.", "Urinarni albumin", "Mjerenje albumina u urinu, indikator oštećenja bubrega.", new byte[0], new Guid("e16fecb2-a4cf-41fd-a264-18dbc8a25cc8"), "Urin" },
                    { new Guid("ef16a7e3-3117-4246-ae58-fc54d2307c77"), new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 3m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3070), "Nema posebnih uputa.", "MCHC", "Prosječna koncentracija hemoglobina u eritrocitu.", new byte[0], new Guid("e8319b5a-0868-4fef-b356-32f9fdabbd82"), "Krv" }
                });

            migrationBuilder.InsertData(
                table: "Usluge",
                columns: new[] { "UslugaID", "AdministratorID", "Cijena", "DTKreiranja", "DTZadnjeModifikacije", "Dostupno", "Naziv", "Opis", "RezultatUH", "Slika", "TrajanjeUMin" },
                values: new object[,]
                {
                    { 1, new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 6m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3362), null, true, "Krvna slika", "Mjerenje osnovnih testova vezanih za krvnu sliku.", 24f, null, 10 },
                    { 2, new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 8m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3386), null, true, "Jetreni panel", "Kompletna analiza funkcije jetre.", 24f, null, 15 },
                    { 3, new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 4m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3401), null, true, "Kardiovaskularni rizik", "Procjena rizika od kardiovaskularnih bolesti.", 24f, null, 10 },
                    { 4, new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 5m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3415), null, true, "Upalni marker", "Testiranje za otkrivanje upalnih procesa u tijelu.", 24f, null, 10 },
                    { 5, new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 4m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3432), null, true, "Bubrežni panel", "Procjena funkcije bubrega i rizika od dijabetesa.", 24f, null, 15 },
                    { 6, new Guid("e6bb3c49-9aa6-4ef0-9625-b16bb3775e58"), 9m, new DateTime(2024, 1, 1, 13, 28, 45, 913, DateTimeKind.Local).AddTicks(3447), null, true, "Respiratorni panel", "Analiza respiratornog sistema za otkrivanje infekcija.", 48f, null, 20 }
                });

            migrationBuilder.InsertData(
                table: "AspNetUserRoles",
                columns: new[] { "RoleId", "UserId" },
                values: new object[,]
                {
                    { new Guid("6d333ed3-85ff-4863-93cc-76701acb9e52"), new Guid("09098d7d-1be0-4d0b-926d-9eb493d81dcc") },
                    { new Guid("c4f2036e-1b4c-4ac8-836c-f40f09a01a98"), new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28") }
                });

            migrationBuilder.InsertData(
                table: "Termini",
                columns: new[] { "TerminID", "DTTermina", "MedicinskoOsobljeID", "Napomena", "Obavljen", "Odgovor", "PacijentID", "Placeno", "RacunID", "RazlogOtkazivanja", "RezultatDodan", "RezultatTerminaPDF", "Status", "ZakljucakDodan", "ZakljucakID", "isDeleted" },
                values: new object[,]
                {
                    { new Guid("10254f8e-15dd-4673-aa54-b4da76946d1d"), new DateTime(2024, 1, 15, 10, 0, 0, 0, DateTimeKind.Unspecified), null, null, false, null, new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28"), true, null, null, false, null, null, false, null, false },
                    { new Guid("1137e44a-6e88-41ab-965f-8ea5a936ff24"), new DateTime(2024, 1, 24, 8, 0, 0, 0, DateTimeKind.Unspecified), null, null, false, null, new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28"), true, null, null, false, null, null, false, null, false },
                    { new Guid("26954381-1f85-4776-a5d4-39068d8add3a"), new DateTime(2024, 1, 19, 12, 0, 0, 0, DateTimeKind.Unspecified), null, null, false, null, new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28"), true, null, null, false, null, null, false, null, false },
                    { new Guid("34c710c6-ec80-483b-aa25-42c0229941ec"), new DateTime(2024, 1, 18, 8, 0, 0, 0, DateTimeKind.Unspecified), null, null, false, null, new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28"), true, null, null, false, null, null, false, null, false },
                    { new Guid("4253753f-db13-4d93-b0a8-7d4cf6b46013"), new DateTime(2024, 1, 23, 7, 40, 0, 0, DateTimeKind.Unspecified), null, null, false, null, new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28"), true, null, null, false, null, null, false, null, false },
                    { new Guid("42a4749b-7f8c-464d-a54a-e857e45d62a7"), new DateTime(2024, 1, 31, 7, 0, 0, 0, DateTimeKind.Unspecified), null, null, false, null, new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28"), true, null, null, false, null, null, false, null, false },
                    { new Guid("595c85f2-f1b1-4176-94a7-411bd46570cc"), new DateTime(2024, 1, 26, 7, 0, 0, 0, DateTimeKind.Unspecified), null, null, false, null, new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28"), true, null, null, false, null, null, false, null, false },
                    { new Guid("5c5e0879-6019-4b0d-81fb-804b73273d03"), new DateTime(2024, 1, 25, 11, 0, 0, 0, DateTimeKind.Unspecified), null, null, false, null, new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28"), true, null, null, false, null, null, false, null, false },
                    { new Guid("66f5142b-dcbc-4330-81a6-8bade0950f44"), new DateTime(2024, 1, 29, 11, 0, 0, 0, DateTimeKind.Unspecified), null, null, false, null, new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28"), true, null, null, false, null, null, false, null, false },
                    { new Guid("7ad39c1e-7d14-4127-bbac-459888f300e6"), new DateTime(2024, 1, 22, 15, 0, 0, 0, DateTimeKind.Unspecified), null, null, false, null, new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28"), true, null, null, false, null, null, false, null, false },
                    { new Guid("7c262d54-d6f6-4461-b4c9-a0e9266f2d50"), new DateTime(2024, 1, 11, 9, 40, 0, 0, DateTimeKind.Unspecified), null, null, false, null, new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28"), true, null, null, false, null, null, false, null, false },
                    { new Guid("d2539f37-0e15-44b6-af31-8cc93c03dcd1"), new DateTime(2024, 1, 12, 11, 0, 0, 0, DateTimeKind.Unspecified), null, null, false, null, new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28"), true, null, null, false, null, null, false, null, false },
                    { new Guid("dc0261ce-322d-45a1-851d-e88863031c84"), new DateTime(2024, 1, 30, 10, 40, 0, 0, DateTimeKind.Unspecified), null, null, false, null, new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28"), true, null, null, false, null, null, false, null, false },
                    { new Guid("dc433820-5129-44a9-bb1e-a3b87c1bc398"), new DateTime(2024, 1, 16, 10, 40, 0, 0, DateTimeKind.Unspecified), null, null, false, null, new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28"), true, null, null, false, null, null, false, null, false },
                    { new Guid("fb3bf003-4dda-4228-a1b6-d488644f90a8"), new DateTime(2024, 1, 17, 8, 0, 0, 0, DateTimeKind.Unspecified), null, null, false, null, new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28"), true, null, null, false, null, null, false, null, false },
                    { new Guid("fcbfe84d-b6fd-4b36-a31d-773eb669c123"), new DateTime(2024, 1, 10, 13, 0, 0, 0, DateTimeKind.Unspecified), null, null, false, null, new Guid("140fb21b-43c9-4da2-86e9-8f99d08d8d28"), true, null, null, false, null, null, false, null, false }
                });
				
			migrationBuilder.InsertData(
    table: "TestUsluga",
    columns: new[] { "TestUslugeUslugaID", "UslugaTestoviTestID" },
    values: new object[,]
    {
        { 1, Guid.Parse("d687ff9d-1ec4-4aa9-a4f3-2eb5149d2212") },
        { 1, Guid.Parse("8fff236b-4a25-4ed3-a138-f252ee4770eb") },
        { 1, Guid.Parse("54d120fc-224a-4710-9046-162d9b61c2d7") }
    });

migrationBuilder.InsertData(
    table: "TestUsluga",
    columns: new[] { "TestUslugeUslugaID", "UslugaTestoviTestID" },
    values: new object[,]
    {
        { 2, Guid.Parse("AD25CC31-2B01-4AD3-BF2E-1FE4B53A3F25") },
        { 2, Guid.Parse("14A35EB5-C4BD-4A0B-9990-C8B493367BCF") },
        { 2, Guid.Parse("D9F7156C-A460-4A7C-B51C-EF7D859244AF") }
    });
	
migrationBuilder.InsertData(
    table: "TestUsluga",
    columns: new[] { "TestUslugeUslugaID", "UslugaTestoviTestID" },
    values: new object[,]
    {
        { 3, Guid.Parse("1C978BD5-9777-4C05-B2AE-DE4D3B9B4FC5") },
        { 3, Guid.Parse("20B1BDA2-14BC-4B3F-BAC4-598E2A292519") }
    });
	
migrationBuilder.InsertData(
    table: "TestUsluga",
    columns: new[] { "TestUslugeUslugaID", "UslugaTestoviTestID" },
    values: new object[,]
    {
        { 4, Guid.Parse("0C1A4613-BE50-48A6-ABCB-A535870FE369") },
        { 4, Guid.Parse("A4A12D1C-B174-4938-8557-CB6281CCB2A6") }
    });
	
migrationBuilder.InsertData(
    table: "TestUsluga",
    columns: new[] { "TestUslugeUslugaID", "UslugaTestoviTestID" },
    values: new object[,]
    {
        { 5, Guid.Parse("D9F7156C-A460-4A7C-B51C-EF7D859244AF") },
        { 5, Guid.Parse("D687FF9D-1EC4-4AA9-A4F3-2EB5149D2212") }
    });
	
migrationBuilder.InsertData(
    table: "TestUsluga",
    columns: new[] { "TestUslugeUslugaID", "UslugaTestoviTestID" },
    values: new object[,]
    {
        { 6, Guid.Parse("0C9DB61B-D5E5-495D-876B-30AD80A8DF3D") },
        { 6, Guid.Parse("59A5AAAE-EC61-476D-84F5-2621D4054160") }
    });
	
	migrationBuilder.InsertData(
    table: "TerminUsluga",
    columns: new[] { "TerminUslugeUslugaID", "UslugaTerminiTerminID" },
    values: new object[,]
    {
        { 1, Guid.Parse("26954381-1F85-4776-A5D4-39068D8ADD3A") },
        { 3, Guid.Parse("26954381-1F85-4776-A5D4-39068D8ADD3A") },
        { 4, Guid.Parse("595C85F2-F1B1-4176-94A7-411BD46570CC") },
        { 6, Guid.Parse("595C85F2-F1B1-4176-94A7-411BD46570CC") },
        { 4, Guid.Parse("34C710C6-EC80-483B-AA25-42C0229941EC") },
        { 5, Guid.Parse("34C710C6-EC80-483B-AA25-42C0229941EC") },
        { 1, Guid.Parse("7AD39C1E-7D14-4127-BBAC-459888F300E6") },
        { 4, Guid.Parse("7AD39C1E-7D14-4127-BBAC-459888F300E6") },
        { 1, Guid.Parse("FCBFE84D-B6FD-4B36-A31D-773EB669C123") },
        { 2, Guid.Parse("FCBFE84D-B6FD-4B36-A31D-773EB669C123") },
        { 3, Guid.Parse("FCBFE84D-B6FD-4B36-A31D-773EB669C123") },
        { 4, Guid.Parse("FCBFE84D-B6FD-4B36-A31D-773EB669C123") },
        { 5, Guid.Parse("FCBFE84D-B6FD-4B36-A31D-773EB669C123") },
        { 6, Guid.Parse("FCBFE84D-B6FD-4B36-A31D-773EB669C123") },
        { 3, Guid.Parse("4253753F-DB13-4D93-B0A8-7D4CF6B46013") },
        { 1, Guid.Parse("5C5E0879-6019-4B0D-81FB-804B73273D03") },
        { 4, Guid.Parse("5C5E0879-6019-4B0D-81FB-804B73273D03") },
        { 6, Guid.Parse("5C5E0879-6019-4B0D-81FB-804B73273D03") },
        { 1, Guid.Parse("66F5142B-DCBC-4330-81A6-8BADE0950F44") },
        { 3, Guid.Parse("66F5142B-DCBC-4330-81A6-8BADE0950F44") },
        { 1, Guid.Parse("D2539F37-0E15-44B6-AF31-8CC93C03DCD1") },
        { 4, Guid.Parse("D2539F37-0E15-44B6-AF31-8CC93C03DCD1") },
        { 1, Guid.Parse("1137E44A-6E88-41AB-965F-8EA5A936FF24") },
        { 4, Guid.Parse("1137E44A-6E88-41AB-965F-8EA5A936FF24") },
        { 1, Guid.Parse("7C262D54-D6F6-4461-B4C9-A0E9266F2D50") },
        { 3, Guid.Parse("7C262D54-D6F6-4461-B4C9-A0E9266F2D50") },
        { 1, Guid.Parse("DC433820-5129-44A9-BB1E-A3B87C1BC398") },
        { 4, Guid.Parse("DC433820-5129-44A9-BB1E-A3B87C1BC398") },
        { 2, Guid.Parse("10254F8E-15DD-4673-AA54-B4DA76946D1D") },
        { 5, Guid.Parse("10254F8E-15DD-4673-AA54-B4DA76946D1D") },
        { 6, Guid.Parse("10254F8E-15DD-4673-AA54-B4DA76946D1D") },
        { 4, Guid.Parse("FB3BF003-4DDA-4228-A1B6-D488644F90A8") },
        { 6, Guid.Parse("FB3BF003-4DDA-4228-A1B6-D488644F90A8") },
        { 1, Guid.Parse("42A4749B-7F8C-464D-A54A-E857E45D62A7") },
        { 4, Guid.Parse("42A4749B-7F8C-464D-A54A-E857E45D62A7") },
        { 2, Guid.Parse("DC0261CE-322D-45A1-851D-E88863031C84") },
        { 5, Guid.Parse("DC0261CE-322D-45A1-851D-E88863031C84") },
        { 6, Guid.Parse("DC0261CE-322D-45A1-851D-E88863031C84") }
    }
);

migrationBuilder.Sql("UPDATE Termini SET RacunID = '3C19770E-223D-43FE-8D15-3BA1FE7151FE' WHERE TerminID = '26954381-1F85-4776-A5D4-39068D8ADD3A';");migrationBuilder.Sql("UPDATE Racuni SET TerminID = '26954381-1F85-4776-A5D4-39068D8ADD3A' WHERE RacunID = '3C19770E-223D-43FE-8D15-3BA1FE7151FE';");
migrationBuilder.Sql("UPDATE Termini SET RacunID = 'ECA7C955-9CE4-42AB-A33A-0F2C08F1E38C' WHERE TerminID = '595C85F2-F1B1-4176-94A7-411BD46570CC';");migrationBuilder.Sql("UPDATE Racuni SET TerminID = '595C85F2-F1B1-4176-94A7-411BD46570CC' WHERE RacunID = 'ECA7C955-9CE4-42AB-A33A-0F2C08F1E38C';");
migrationBuilder.Sql("UPDATE Termini SET RacunID = '0BDC8864-0879-4401-8879-A5BE3496CF6D' WHERE TerminID = '34C710C6-EC80-483B-AA25-42C0229941EC';");migrationBuilder.Sql("UPDATE Racuni SET TerminID = '34C710C6-EC80-483B-AA25-42C0229941EC' WHERE RacunID = '0BDC8864-0879-4401-8879-A5BE3496CF6D';");
migrationBuilder.Sql("UPDATE Termini SET RacunID = '5461CE30-AD9C-49CB-9371-C5FD231FBF63' WHERE TerminID = '7AD39C1E-7D14-4127-BBAC-459888F300E6';");migrationBuilder.Sql("UPDATE Racuni SET TerminID = '7AD39C1E-7D14-4127-BBAC-459888F300E6' WHERE RacunID = '5461CE30-AD9C-49CB-9371-C5FD231FBF63';");
migrationBuilder.Sql("UPDATE Termini SET RacunID = 'C6781A23-2C71-4DFE-A934-8597C0688812' WHERE TerminID = 'FCBFE84D-B6FD-4B36-A31D-773EB669C123';");migrationBuilder.Sql("UPDATE Racuni SET TerminID = 'FCBFE84D-B6FD-4B36-A31D-773EB669C123' WHERE RacunID = 'C6781A23-2C71-4DFE-A934-8597C0688812';");
migrationBuilder.Sql("UPDATE Termini SET RacunID = '1186F71A-E2D2-4DB2-BF14-2B7727859C74' WHERE TerminID = '4253753F-DB13-4D93-B0A8-7D4CF6B46013';");migrationBuilder.Sql("UPDATE Racuni SET TerminID = '4253753F-DB13-4D93-B0A8-7D4CF6B46013' WHERE RacunID = '1186F71A-E2D2-4DB2-BF14-2B7727859C74';");
migrationBuilder.Sql("UPDATE Termini SET RacunID = '903AB20A-1AEA-493E-8E3C-05564353BC54' WHERE TerminID = '5C5E0879-6019-4B0D-81FB-804B73273D03';");migrationBuilder.Sql("UPDATE Racuni SET TerminID = '5C5E0879-6019-4B0D-81FB-804B73273D03' WHERE RacunID = '903AB20A-1AEA-493E-8E3C-05564353BC54';");
migrationBuilder.Sql("UPDATE Termini SET RacunID = '2057CDBF-4BD4-4071-A2BC-5E19C0183C40' WHERE TerminID = '66F5142B-DCBC-4330-81A6-8BADE0950F44';");migrationBuilder.Sql("UPDATE Racuni SET TerminID = '66F5142B-DCBC-4330-81A6-8BADE0950F44' WHERE RacunID = '2057CDBF-4BD4-4071-A2BC-5E19C0183C40';");
migrationBuilder.Sql("UPDATE Termini SET RacunID = '18356CDD-FBA4-4D5B-A33C-E1D09894A145' WHERE TerminID = 'D2539F37-0E15-44B6-AF31-8CC93C03DCD1';");migrationBuilder.Sql("UPDATE Racuni SET TerminID = 'D2539F37-0E15-44B6-AF31-8CC93C03DCD1' WHERE RacunID = '18356CDD-FBA4-4D5B-A33C-E1D09894A145';");
migrationBuilder.Sql("UPDATE Termini SET RacunID = '58F643CF-1079-4177-950E-A97162657093' WHERE TerminID = '1137E44A-6E88-41AB-965F-8EA5A936FF24';");migrationBuilder.Sql("UPDATE Racuni SET TerminID = '1137E44A-6E88-41AB-965F-8EA5A936FF24' WHERE RacunID = '58F643CF-1079-4177-950E-A97162657093';");
migrationBuilder.Sql("UPDATE Termini SET RacunID = '6B746E04-31AC-46F5-AD2E-33BDEA321D63' WHERE TerminID = '7C262D54-D6F6-4461-B4C9-A0E9266F2D50';");migrationBuilder.Sql("UPDATE Racuni SET TerminID = '7C262D54-D6F6-4461-B4C9-A0E9266F2D50' WHERE RacunID = '6B746E04-31AC-46F5-AD2E-33BDEA321D63';");
migrationBuilder.Sql("UPDATE Termini SET RacunID = '8D166154-FD43-485A-8263-93EFDB69AC4C' WHERE TerminID = 'DC433820-5129-44A9-BB1E-A3B87C1BC398';");migrationBuilder.Sql("UPDATE Racuni SET TerminID = 'DC433820-5129-44A9-BB1E-A3B87C1BC398' WHERE RacunID = '8D166154-FD43-485A-8263-93EFDB69AC4C';");
migrationBuilder.Sql("UPDATE Termini SET RacunID = '0FB113DB-16AF-4675-BCBF-C18709429E2A' WHERE TerminID = '10254F8E-15DD-4673-AA54-B4DA76946D1D';");migrationBuilder.Sql("UPDATE Racuni SET TerminID = '10254F8E-15DD-4673-AA54-B4DA76946D1D' WHERE RacunID = '0FB113DB-16AF-4675-BCBF-C18709429E2A';");
migrationBuilder.Sql("UPDATE Termini SET RacunID = 'E8F45C95-F42A-4220-841D-1EC3E4998F48' WHERE TerminID = 'FB3BF003-4DDA-4228-A1B6-D488644F90A8';");migrationBuilder.Sql("UPDATE Racuni SET TerminID = 'FB3BF003-4DDA-4228-A1B6-D488644F90A8' WHERE RacunID = 'E8F45C95-F42A-4220-841D-1EC3E4998F48';");
migrationBuilder.Sql("UPDATE Termini SET RacunID = 'B36B8AAF-2C31-47DF-88C8-E76D96E41C56' WHERE TerminID = '42A4749B-7F8C-464D-A54A-E857E45D62A7';");migrationBuilder.Sql("UPDATE Racuni SET TerminID = '42A4749B-7F8C-464D-A54A-E857E45D62A7' WHERE RacunID = 'B36B8AAF-2C31-47DF-88C8-E76D96E41C56';");
migrationBuilder.Sql("UPDATE Termini SET RacunID = 'B35CEF5E-0471-4FF2-99F0-6ECBD1D390F5' WHERE TerminID = 'DC0261CE-322D-45A1-851D-E88863031C84';");migrationBuilder.Sql("UPDATE Racuni SET TerminID = 'DC0261CE-322D-45A1-851D-E88863031C84' WHERE RacunID = 'B35CEF5E-0471-4FF2-99F0-6ECBD1D390F5';");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetRoleClaims_RoleId",
                table: "AspNetRoleClaims",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "RoleNameIndex",
                table: "AspNetRoles",
                column: "NormalizedName",
                unique: true,
                filter: "[NormalizedName] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserClaims_UserId",
                table: "AspNetUserClaims",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserLogins_UserId",
                table: "AspNetUserLogins",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUserRoles_RoleId",
                table: "AspNetUserRoles",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "EmailIndex",
                table: "AspNetUsers",
                column: "NormalizedEmail");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUsers_Pacijent_SpolID",
                table: "AspNetUsers",
                column: "Pacijent_SpolID");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUsers_SpolID",
                table: "AspNetUsers",
                column: "SpolID");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUsers_ZvanjeID",
                table: "AspNetUsers",
                column: "ZvanjeID");

            migrationBuilder.CreateIndex(
                name: "UserNameIndex",
                table: "AspNetUsers",
                column: "NormalizedUserName",
                unique: true,
                filter: "[NormalizedUserName] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_Novosti_AdministratorID",
                table: "Novosti",
                column: "AdministratorID");

            migrationBuilder.CreateIndex(
                name: "IX_Obavijesti_AdministratorID",
                table: "Obavijesti",
                column: "AdministratorID");

            migrationBuilder.CreateIndex(
                name: "IX_Racuni_TerminID",
                table: "Racuni",
                column: "TerminID");

            migrationBuilder.CreateIndex(
                name: "IX_Termini_MedicinskoOsobljeID",
                table: "Termini",
                column: "MedicinskoOsobljeID");

            migrationBuilder.CreateIndex(
                name: "IX_Termini_PacijentID",
                table: "Termini",
                column: "PacijentID");

            migrationBuilder.CreateIndex(
                name: "IX_Termini_RacunID",
                table: "Termini",
                column: "RacunID");

            migrationBuilder.CreateIndex(
                name: "IX_Termini_ZakljucakID",
                table: "Termini",
                column: "ZakljucakID");

            migrationBuilder.CreateIndex(
                name: "IX_TerminTest_RezultatID",
                table: "TerminTest",
                column: "RezultatID");

            migrationBuilder.CreateIndex(
                name: "IX_TerminTest_TerminID",
                table: "TerminTest",
                column: "TerminID");

            migrationBuilder.CreateIndex(
                name: "IX_TerminUsluga_UslugaTerminiTerminID",
                table: "TerminUsluga",
                column: "UslugaTerminiTerminID");

            migrationBuilder.CreateIndex(
                name: "IX_Testovi_AdministratorID",
                table: "Testovi",
                column: "AdministratorID");

            migrationBuilder.CreateIndex(
                name: "IX_Testovi_TestParametarID",
                table: "Testovi",
                column: "TestParametarID");

            migrationBuilder.CreateIndex(
                name: "IX_TestUsluga_UslugaTestoviTestID",
                table: "TestUsluga",
                column: "UslugaTestoviTestID");

            migrationBuilder.CreateIndex(
                name: "IX_Usluge_AdministratorID",
                table: "Usluge",
                column: "AdministratorID");

            migrationBuilder.CreateIndex(
                name: "IX_Zakljucci_TerminID",
                table: "Zakljucci",
                column: "TerminID");

            migrationBuilder.AddForeignKey(
                name: "FK_Racuni_Termini_TerminID",
                table: "Racuni",
                column: "TerminID",
                principalTable: "Termini",
                principalColumn: "TerminID");

            migrationBuilder.AddForeignKey(
                name: "FK_Termini_Zakljucci_ZakljucakID",
                table: "Termini",
                column: "ZakljucakID",
                principalTable: "Zakljucci",
                principalColumn: "ZakljucakID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Termini_AspNetUsers_MedicinskoOsobljeID",
                table: "Termini");

            migrationBuilder.DropForeignKey(
                name: "FK_Termini_AspNetUsers_PacijentID",
                table: "Termini");

            migrationBuilder.DropForeignKey(
                name: "FK_Racuni_Termini_TerminID",
                table: "Racuni");

            migrationBuilder.DropForeignKey(
                name: "FK_Zakljucci_Termini_TerminID",
                table: "Zakljucci");

            migrationBuilder.DropTable(
                name: "AspNetRoleClaims");

            migrationBuilder.DropTable(
                name: "AspNetUserClaims");

            migrationBuilder.DropTable(
                name: "AspNetUserLogins");

            migrationBuilder.DropTable(
                name: "AspNetUserRoles");

            migrationBuilder.DropTable(
                name: "AspNetUserTokens");

            migrationBuilder.DropTable(
                name: "Novosti");

            migrationBuilder.DropTable(
                name: "Obavijesti");

            migrationBuilder.DropTable(
                name: "TerminTest");

            migrationBuilder.DropTable(
                name: "TerminUsluga");

            migrationBuilder.DropTable(
                name: "TestUsluga");

            migrationBuilder.DropTable(
                name: "AspNetRoles");

            migrationBuilder.DropTable(
                name: "Rezultati");

            migrationBuilder.DropTable(
                name: "Testovi");

            migrationBuilder.DropTable(
                name: "Usluge");

            migrationBuilder.DropTable(
                name: "TestParametri");

            migrationBuilder.DropTable(
                name: "AspNetUsers");

            migrationBuilder.DropTable(
                name: "Spolovi");

            migrationBuilder.DropTable(
                name: "Zvanja");

            migrationBuilder.DropTable(
                name: "Termini");

            migrationBuilder.DropTable(
                name: "Racuni");

            migrationBuilder.DropTable(
                name: "Zakljucci");
        }
    }
}
