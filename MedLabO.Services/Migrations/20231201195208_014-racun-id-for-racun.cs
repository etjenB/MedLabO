using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MedLabO.Services.Migrations
{
    public partial class _014racunidforracun : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Termini_RacunID",
                table: "Termini");

            migrationBuilder.RenameColumn(
                name: "TerminID",
                table: "Racuni",
                newName: "RacunID");

            migrationBuilder.CreateIndex(
                name: "IX_Termini_RacunID",
                table: "Termini",
                column: "RacunID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Termini_RacunID",
                table: "Termini");

            migrationBuilder.RenameColumn(
                name: "RacunID",
                table: "Racuni",
                newName: "TerminID");

            migrationBuilder.CreateIndex(
                name: "IX_Termini_RacunID",
                table: "Termini",
                column: "RacunID",
                unique: true,
                filter: "[RacunID] IS NOT NULL");
        }
    }
}
