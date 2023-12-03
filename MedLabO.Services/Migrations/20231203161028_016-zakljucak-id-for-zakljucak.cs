using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MedLabO.Services.Migrations
{
    public partial class _016zakljucakidforzakljucak : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Termini_ZakljucakID",
                table: "Termini");

            migrationBuilder.RenameColumn(
                name: "TerminID",
                table: "Zakljucci",
                newName: "ZakljucakID");

            migrationBuilder.AlterColumn<string>(
                name: "Opis",
                table: "Zakljucci",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.CreateIndex(
                name: "IX_Termini_ZakljucakID",
                table: "Termini",
                column: "ZakljucakID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Termini_ZakljucakID",
                table: "Termini");

            migrationBuilder.RenameColumn(
                name: "ZakljucakID",
                table: "Zakljucci",
                newName: "TerminID");

            migrationBuilder.AlterColumn<string>(
                name: "Opis",
                table: "Zakljucci",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(100)",
                oldMaxLength: 100);

            migrationBuilder.CreateIndex(
                name: "IX_Termini_ZakljucakID",
                table: "Termini",
                column: "ZakljucakID",
                unique: true,
                filter: "[ZakljucakID] IS NOT NULL");
        }
    }
}
