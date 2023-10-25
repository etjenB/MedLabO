using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MedLabO.Services.Migrations
{
    public partial class _007zvanjeidchange : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {

            migrationBuilder.DropPrimaryKey(
                name: "PK_Zvanja",
                table: "Zvanja");

            migrationBuilder.DropIndex(
                name: "IX_AspNetUsers_ZvanjeID",
                table: "AspNetUsers");

            migrationBuilder.DropColumn(
                name: "ZvanjeID",
                table: "AspNetUsers");

            migrationBuilder.AddColumn<int>(
                name: "NewId",
                table: "Zvanja",
                type: "int",
                nullable: false,
                defaultValue: 0)
                .Annotation("SqlServer:Identity", "1, 1");

            migrationBuilder.AddColumn<int>(
                name: "ZvanjeNewId",
                table: "AspNetUsers",
                type: "int",
                nullable: true);

            migrationBuilder.AddPrimaryKey(
                name: "PK_Zvanja",
                table: "Zvanja",
                column: "NewId");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUsers_ZvanjeNewId",
                table: "AspNetUsers",
                column: "ZvanjeNewId");

            migrationBuilder.AddForeignKey(
                name: "FK_AspNetUsers_Zvanja_ZvanjeNewId",
                table: "AspNetUsers",
                column: "ZvanjeNewId",
                principalTable: "Zvanja",
                principalColumn: "NewId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AspNetUsers_Zvanja_ZvanjeNewId",
                table: "AspNetUsers");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Zvanja",
                table: "Zvanja");

            migrationBuilder.DropIndex(
                name: "IX_AspNetUsers_ZvanjeNewId",
                table: "AspNetUsers");

            migrationBuilder.DropColumn(
                name: "NewId",
                table: "Zvanja");

            migrationBuilder.DropColumn(
                name: "ZvanjeNewId",
                table: "AspNetUsers");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Zvanja",
                table: "Zvanja",
                column: "ZvanjeID");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUsers_ZvanjeID",
                table: "AspNetUsers",
                column: "ZvanjeID");

            migrationBuilder.AddForeignKey(
                name: "FK_AspNetUsers_Zvanja_ZvanjeID",
                table: "AspNetUsers",
                column: "ZvanjeID",
                principalTable: "Zvanja",
                principalColumn: "ZvanjeID");
        }
    }
}
