using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MedLabO.Services.Migrations
{
    public partial class _015racunforeignkeyterminid : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "TerminID",
                table: "Racuni",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Racuni_TerminID",
                table: "Racuni",
                column: "TerminID");

            migrationBuilder.AddForeignKey(
                name: "FK_Racuni_Termini_TerminID",
                table: "Racuni",
                column: "TerminID",
                principalTable: "Termini",
                principalColumn: "TerminID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Racuni_Termini_TerminID",
                table: "Racuni");

            migrationBuilder.DropIndex(
                name: "IX_Racuni_TerminID",
                table: "Racuni");

            migrationBuilder.DropColumn(
                name: "TerminID",
                table: "Racuni");
        }
    }
}
