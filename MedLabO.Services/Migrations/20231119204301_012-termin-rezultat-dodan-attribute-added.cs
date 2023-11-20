using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MedLabO.Services.Migrations
{
    public partial class _012terminrezultatdodanattributeadded : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "RezultatDodan",
                table: "Termini",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "RezultatDodan",
                table: "Termini");
        }
    }
}
