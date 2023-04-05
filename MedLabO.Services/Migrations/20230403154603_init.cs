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
                    Id = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    NormalizedName = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    ConcurrencyStamp = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AspNetRoles", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Racuni",
                columns: table => new
                {
                    TerminID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Placeno = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Racuni", x => x.TerminID);
                });

            migrationBuilder.CreateTable(
                name: "Rezultati",
                columns: table => new
                {
                    TestID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    DTRezultata = table.Column<DateTime>(type: "datetime2", nullable: false),
                    TestZakljucak = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Obiljezen = table.Column<bool>(type: "bit", nullable: false),
                    RezFlo = table.Column<float>(type: "real", nullable: true),
                    RezStr = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    RazlikaOdNormalne = table.Column<float>(type: "real", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Rezultati", x => x.TestID);
                });

            migrationBuilder.CreateTable(
                name: "TestParametri",
                columns: table => new
                {
                    TestID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    MinVrijednost = table.Column<float>(type: "real", nullable: true),
                    MaxVrijednost = table.Column<float>(type: "real", nullable: true),
                    NormalnaVrijednost = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Jedinica = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TestParametri", x => x.TestID);
                });

            migrationBuilder.CreateTable(
                name: "Zakljucci",
                columns: table => new
                {
                    TerminID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Detaljno = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Zakljucci", x => x.TerminID);
                });

            migrationBuilder.CreateTable(
                name: "Zvanja",
                columns: table => new
                {
                    ZvanjeID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
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
                    RoleId = table.Column<string>(type: "nvarchar(450)", nullable: false),
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
                    Id = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Discriminator = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IsKontakt = table.Column<bool>(type: "bit", nullable: true),
                    KontaktInfo = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    IsActive = table.Column<bool>(type: "bit", nullable: true),
                    DTZaposlenja = table.Column<DateTime>(type: "datetime2", nullable: true),
                    DTPrekidRadnogOdnosa = table.Column<DateTime>(type: "datetime2", nullable: true),
                    MedicinskoOsoblje_Spol = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ZvanjeID = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    DatumRodjenja = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Adresa = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Spol = table.Column<string>(type: "nvarchar(max)", nullable: true),
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
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
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
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false)
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
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    RoleId = table.Column<string>(type: "nvarchar(450)", nullable: false)
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
                    UserId = table.Column<string>(type: "nvarchar(450)", nullable: false),
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
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    AdministratorID = table.Column<string>(type: "nvarchar(450)", nullable: true)
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
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: false),
                    AdministratorID = table.Column<string>(type: "nvarchar(450)", nullable: true)
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
                name: "Termini",
                columns: table => new
                {
                    TerminID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    DTTermina = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Status = table.Column<bool>(type: "bit", nullable: true),
                    Napomena = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Odgovor = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Obavljen = table.Column<bool>(type: "bit", nullable: false),
                    RezultatTermina = table.Column<bool>(type: "bit", nullable: false),
                    RezultatTerminaPDF = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    PacijentID = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    MedicinskoOsobljeID = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    RacunID = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    ZakljucakID = table.Column<Guid>(type: "uniqueidentifier", nullable: true)
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
                        principalColumn: "TerminID");
                    table.ForeignKey(
                        name: "FK_Termini_Zakljucci_ZakljucakID",
                        column: x => x.ZakljucakID,
                        principalTable: "Zakljucci",
                        principalColumn: "TerminID");
                });

            migrationBuilder.CreateTable(
                name: "Testovi",
                columns: table => new
                {
                    TestID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    NapomenaZaPripremu = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    TipUzorka = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DTKreiranja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    AdministratorID = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    TestParametarID = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    RezultatID = table.Column<Guid>(type: "uniqueidentifier", nullable: true)
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
                        name: "FK_Testovi_Rezultati_RezultatID",
                        column: x => x.RezultatID,
                        principalTable: "Rezultati",
                        principalColumn: "TestID");
                    table.ForeignKey(
                        name: "FK_Testovi_TestParametri_TestParametarID",
                        column: x => x.TestParametarID,
                        principalTable: "TestParametri",
                        principalColumn: "TestID");
                });

            migrationBuilder.CreateTable(
                name: "Usluge",
                columns: table => new
                {
                    UslugaID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    TrajanjeUMin = table.Column<int>(type: "int", nullable: false),
                    RezultatUH = table.Column<float>(type: "real", nullable: false),
                    Dostupno = table.Column<bool>(type: "bit", nullable: false),
                    DTKreiranja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    DTZadnjeModifikacije = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Slika = table.Column<byte[]>(type: "varbinary(max)", nullable: true),
                    AdministratorID = table.Column<string>(type: "nvarchar(450)", nullable: true)
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
                name: "TerminTest",
                columns: table => new
                {
                    TerminTestoviTestID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    TestTerminiTerminID = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TerminTest", x => new { x.TerminTestoviTestID, x.TestTerminiTerminID });
                    table.ForeignKey(
                        name: "FK_TerminTest_Termini_TestTerminiTerminID",
                        column: x => x.TestTerminiTerminID,
                        principalTable: "Termini",
                        principalColumn: "TerminID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_TerminTest_Testovi_TerminTestoviTestID",
                        column: x => x.TerminTestoviTestID,
                        principalTable: "Testovi",
                        principalColumn: "TestID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "TerminUsluga",
                columns: table => new
                {
                    TerminUslugeUslugaID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
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
                name: "TestUsluga",
                columns: table => new
                {
                    TestUslugeUslugaID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
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
                column: "RacunID",
                unique: true,
                filter: "[RacunID] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_Termini_ZakljucakID",
                table: "Termini",
                column: "ZakljucakID",
                unique: true,
                filter: "[ZakljucakID] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_TerminTest_TestTerminiTerminID",
                table: "TerminTest",
                column: "TestTerminiTerminID");

            migrationBuilder.CreateIndex(
                name: "IX_TerminUsluga_UslugaTerminiTerminID",
                table: "TerminUsluga",
                column: "UslugaTerminiTerminID");

            migrationBuilder.CreateIndex(
                name: "IX_Testovi_AdministratorID",
                table: "Testovi",
                column: "AdministratorID");

            migrationBuilder.CreateIndex(
                name: "IX_Testovi_RezultatID",
                table: "Testovi",
                column: "RezultatID",
                unique: true,
                filter: "[RezultatID] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_Testovi_TestParametarID",
                table: "Testovi",
                column: "TestParametarID",
                unique: true,
                filter: "[TestParametarID] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_TestUsluga_UslugaTestoviTestID",
                table: "TestUsluga",
                column: "UslugaTestoviTestID");

            migrationBuilder.CreateIndex(
                name: "IX_Usluge_AdministratorID",
                table: "Usluge",
                column: "AdministratorID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
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
                name: "Termini");

            migrationBuilder.DropTable(
                name: "Testovi");

            migrationBuilder.DropTable(
                name: "Usluge");

            migrationBuilder.DropTable(
                name: "Racuni");

            migrationBuilder.DropTable(
                name: "Zakljucci");

            migrationBuilder.DropTable(
                name: "Rezultati");

            migrationBuilder.DropTable(
                name: "TestParametri");

            migrationBuilder.DropTable(
                name: "AspNetUsers");

            migrationBuilder.DropTable(
                name: "Zvanja");
        }
    }
}
