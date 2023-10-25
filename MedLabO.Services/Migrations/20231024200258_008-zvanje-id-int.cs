using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MedLabO.Services.Migrations
{
    public partial class _008zvanjeidint : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ZvanjeID",
                table: "Zvanja");

            migrationBuilder.RenameColumn(
                name: "NewId",
                table: "Zvanja",
                newName: "ZvanjeID");

            migrationBuilder.RenameColumn(
                name: "ZvanjeNewId",
                table: "AspNetUsers",
                newName: "ZvanjeID");

            migrationBuilder.RenameIndex(
                name: "IX_AspNetUsers_ZvanjeNewId",
                table: "AspNetUsers",
                newName: "IX_AspNetUsers_ZvanjeID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {

        }
    }
}
