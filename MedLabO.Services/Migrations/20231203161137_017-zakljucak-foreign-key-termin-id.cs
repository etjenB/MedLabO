using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MedLabO.Services.Migrations
{
    public partial class _017zakljucakforeignkeyterminid : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "TerminID",
                table: "Zakljucci",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Zakljucci_TerminID",
                table: "Zakljucci",
                column: "TerminID");

            migrationBuilder.AddForeignKey(
                name: "FK_Zakljucci_Termini_TerminID",
                table: "Zakljucci",
                column: "TerminID",
                principalTable: "Termini",
                principalColumn: "TerminID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Zakljucci_Termini_TerminID",
                table: "Zakljucci");

            migrationBuilder.DropIndex(
                name: "IX_Zakljucci_TerminID",
                table: "Zakljucci");

            migrationBuilder.DropColumn(
                name: "TerminID",
                table: "Zakljucci");
        }
    }
}
