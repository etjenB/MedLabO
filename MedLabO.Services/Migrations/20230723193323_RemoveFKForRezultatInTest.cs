using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MedLabO.Services.Migrations
{
    public partial class RemoveFKForRezultatInTest : Migration
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
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
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
