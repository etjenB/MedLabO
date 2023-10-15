using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MedLabO.Services.Migrations
{
    public partial class _004renamerezultatterminatoprijemzavrsen : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "RezultatTermina",
                table: "Termini",
                newName: "PrijemZavrsen");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "PrijemZavrsen",
                table: "Termini",
                newName: "RezultatTermina");
        }
    }
}
