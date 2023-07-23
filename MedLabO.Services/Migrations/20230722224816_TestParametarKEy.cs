using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MedLabO.Services.Migrations
{
    public partial class TestParametarKEy : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "TestUsluga");

            migrationBuilder.DropIndex(
                name: "IX_Testovi_TestParametarID",
                table: "Testovi");

            migrationBuilder.RenameColumn(
                name: "TestID",
                table: "TestParametri",
                newName: "TestParametarID");

            migrationBuilder.AddColumn<Guid>(
                name: "TestID",
                table: "Usluge",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "Administrator",
                columns: table => new
                {
                    Id = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Ime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Prezime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    IsKontakt = table.Column<bool>(type: "bit", nullable: false),
                    KontaktInfo = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Administrator", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "TestParametar",
                columns: table => new
                {
                    TestParametarID = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    MinVrijednost = table.Column<float>(type: "real", nullable: true),
                    MaxVrijednost = table.Column<float>(type: "real", nullable: true),
                    NormalnaVrijednost = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Jedinica = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TestParametar", x => x.TestParametarID);
                });

            migrationBuilder.CreateTable(
                name: "Test",
                columns: table => new
                {
                    TestID = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Naziv = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Opis = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Cijena = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    NapomenaZaPripremu = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    TipUzorka = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DTKreiranja = table.Column<DateTime>(type: "datetime2", nullable: false),
                    AdministratorID = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    TestParametarID = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    UslugaID = table.Column<Guid>(type: "uniqueidentifier", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Test", x => x.TestID);
                    table.ForeignKey(
                        name: "FK_Test_Administrator_AdministratorID",
                        column: x => x.AdministratorID,
                        principalTable: "Administrator",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Test_TestParametar_TestParametarID",
                        column: x => x.TestParametarID,
                        principalTable: "TestParametar",
                        principalColumn: "TestParametarID");
                    table.ForeignKey(
                        name: "FK_Test_Usluge_UslugaID",
                        column: x => x.UslugaID,
                        principalTable: "Usluge",
                        principalColumn: "UslugaID");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Usluge_TestID",
                table: "Usluge",
                column: "TestID");

            migrationBuilder.CreateIndex(
                name: "IX_Testovi_TestParametarID",
                table: "Testovi",
                column: "TestParametarID");

            migrationBuilder.CreateIndex(
                name: "IX_Test_AdministratorID",
                table: "Test",
                column: "AdministratorID");

            migrationBuilder.CreateIndex(
                name: "IX_Test_TestParametarID",
                table: "Test",
                column: "TestParametarID");

            migrationBuilder.CreateIndex(
                name: "IX_Test_UslugaID",
                table: "Test",
                column: "UslugaID");

            migrationBuilder.AddForeignKey(
                name: "FK_Usluge_Testovi_TestID",
                table: "Usluge",
                column: "TestID",
                principalTable: "Testovi",
                principalColumn: "TestID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Usluge_Testovi_TestID",
                table: "Usluge");

            migrationBuilder.DropTable(
                name: "Test");

            migrationBuilder.DropTable(
                name: "Administrator");

            migrationBuilder.DropTable(
                name: "TestParametar");

            migrationBuilder.DropIndex(
                name: "IX_Usluge_TestID",
                table: "Usluge");

            migrationBuilder.DropIndex(
                name: "IX_Testovi_TestParametarID",
                table: "Testovi");

            migrationBuilder.DropColumn(
                name: "TestID",
                table: "Usluge");

            migrationBuilder.RenameColumn(
                name: "TestParametarID",
                table: "TestParametri",
                newName: "TestID");

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
                name: "IX_Testovi_TestParametarID",
                table: "Testovi",
                column: "TestParametarID",
                unique: true,
                filter: "[TestParametarID] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_TestUsluga_UslugaTestoviTestID",
                table: "TestUsluga",
                column: "UslugaTestoviTestID");
        }
    }
}
