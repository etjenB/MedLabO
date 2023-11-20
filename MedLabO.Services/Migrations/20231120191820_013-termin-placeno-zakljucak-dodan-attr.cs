using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MedLabO.Services.Migrations
{
    public partial class _013terminplacenozakljucakdodanattr : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "PrijemZavrsen",
                table: "Termini",
                newName: "ZakljucakDodan");

            migrationBuilder.AddColumn<bool>(
                name: "Placeno",
                table: "Termini",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Placeno",
                table: "Termini");

            migrationBuilder.RenameColumn(
                name: "ZakljucakDodan",
                table: "Termini",
                newName: "PrijemZavrsen");
        }
    }
}
