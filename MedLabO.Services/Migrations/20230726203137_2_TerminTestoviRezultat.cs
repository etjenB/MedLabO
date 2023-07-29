using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MedLabO.Services.Migrations
{
    public partial class _2_TerminTestoviRezultat : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Testovi_Rezultati_RezultatID",
                table: "Testovi");

            migrationBuilder.DropIndex(
                name: "IX_Testovi_RezultatID",
                table: "Testovi");

            migrationBuilder.DropColumn(
                name: "RezultatID",
                table: "Testovi");

            migrationBuilder.AddColumn<Guid>(
                name: "RezultatID",
                table: "TerminTest",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_TerminTest_RezultatID",
                table: "TerminTest",
                column: "RezultatID");

            migrationBuilder.AddForeignKey(
                name: "FK_TerminTest_Rezultati_RezultatID",
                table: "TerminTest",
                column: "RezultatID",
                principalTable: "Rezultati",
                principalColumn: "RezultatID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_TerminTest_Rezultati_RezultatID",
                table: "TerminTest");

            migrationBuilder.DropIndex(
                name: "IX_TerminTest_RezultatID",
                table: "TerminTest");

            migrationBuilder.DropColumn(
                name: "RezultatID",
                table: "TerminTest");

            migrationBuilder.AddColumn<Guid>(
                name: "RezultatID",
                table: "Testovi",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Testovi_RezultatID",
                table: "Testovi",
                column: "RezultatID");

            migrationBuilder.AddForeignKey(
                name: "FK_Testovi_Rezultati_RezultatID",
                table: "Testovi",
                column: "RezultatID",
                principalTable: "Rezultati",
                principalColumn: "RezultatID");
        }
    }
}
