using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MedLabO.Services.Migrations
{
    public partial class TestTerminRezultat : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "TerminTest");

            migrationBuilder.DropIndex(
                name: "IX_Testovi_RezultatID",
                table: "Testovi");

            migrationBuilder.RenameColumn(
                name: "TestID",
                table: "Rezultati",
                newName: "RezultatID");

            migrationBuilder.CreateTable(
                name: "TestTerminRezultati",
                columns: table => new
                {
                    TestTerminRezultatID = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    TestID = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    TerminID = table.Column<Guid>(type: "uniqueidentifier", nullable: true),
                    RezultatID = table.Column<Guid>(type: "uniqueidentifier", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TestTerminRezultati", x => x.TestTerminRezultatID);
                    table.ForeignKey(
                        name: "FK_TestTerminRezultati_Rezultati_RezultatID",
                        column: x => x.RezultatID,
                        principalTable: "Rezultati",
                        principalColumn: "RezultatID");
                    table.ForeignKey(
                        name: "FK_TestTerminRezultati_Termini_TerminID",
                        column: x => x.TerminID,
                        principalTable: "Termini",
                        principalColumn: "TerminID");
                    table.ForeignKey(
                        name: "FK_TestTerminRezultati_Testovi_TestID",
                        column: x => x.TestID,
                        principalTable: "Testovi",
                        principalColumn: "TestID");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Testovi_RezultatID",
                table: "Testovi",
                column: "RezultatID");

            migrationBuilder.CreateIndex(
                name: "IX_TestTerminRezultati_RezultatID",
                table: "TestTerminRezultati",
                column: "RezultatID");

            migrationBuilder.CreateIndex(
                name: "IX_TestTerminRezultati_TerminID",
                table: "TestTerminRezultati",
                column: "TerminID");

            migrationBuilder.CreateIndex(
                name: "IX_TestTerminRezultati_TestID",
                table: "TestTerminRezultati",
                column: "TestID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "TestTerminRezultati");

            migrationBuilder.DropIndex(
                name: "IX_Testovi_RezultatID",
                table: "Testovi");

            migrationBuilder.RenameColumn(
                name: "RezultatID",
                table: "Rezultati",
                newName: "TestID");

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

            migrationBuilder.CreateIndex(
                name: "IX_Testovi_RezultatID",
                table: "Testovi",
                column: "RezultatID",
                unique: true,
                filter: "[RezultatID] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_TerminTest_TestTerminiTerminID",
                table: "TerminTest",
                column: "TestTerminiTerminID");
        }
    }
}
