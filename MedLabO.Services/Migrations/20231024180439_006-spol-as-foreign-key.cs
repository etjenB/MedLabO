using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MedLabO.Services.Migrations
{
    public partial class _006spolasforeignkey : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Pacijent_Spol",
                table: "AspNetUsers");

            migrationBuilder.DropColumn(
                name: "Spol",
                table: "AspNetUsers");

            migrationBuilder.RenameColumn(
                name: "Id",
                table: "Spolovi",
                newName: "SpolID");

            migrationBuilder.AddColumn<int>(
                name: "Pacijent_SpolID",
                table: "AspNetUsers",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "SpolID",
                table: "AspNetUsers",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUsers_Pacijent_SpolID",
                table: "AspNetUsers",
                column: "Pacijent_SpolID");

            migrationBuilder.CreateIndex(
                name: "IX_AspNetUsers_SpolID",
                table: "AspNetUsers",
                column: "SpolID");

            migrationBuilder.AddForeignKey(
                name: "FK_AspNetUsers_Spolovi_Pacijent_SpolID",
                table: "AspNetUsers",
                column: "Pacijent_SpolID",
                principalTable: "Spolovi",
                principalColumn: "SpolID");

            migrationBuilder.AddForeignKey(
                name: "FK_AspNetUsers_Spolovi_SpolID",
                table: "AspNetUsers",
                column: "SpolID",
                principalTable: "Spolovi",
                principalColumn: "SpolID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AspNetUsers_Spolovi_Pacijent_SpolID",
                table: "AspNetUsers");

            migrationBuilder.DropForeignKey(
                name: "FK_AspNetUsers_Spolovi_SpolID",
                table: "AspNetUsers");

            migrationBuilder.DropIndex(
                name: "IX_AspNetUsers_Pacijent_SpolID",
                table: "AspNetUsers");

            migrationBuilder.DropIndex(
                name: "IX_AspNetUsers_SpolID",
                table: "AspNetUsers");

            migrationBuilder.DropColumn(
                name: "Pacijent_SpolID",
                table: "AspNetUsers");

            migrationBuilder.DropColumn(
                name: "SpolID",
                table: "AspNetUsers");

            migrationBuilder.RenameColumn(
                name: "SpolID",
                table: "Spolovi",
                newName: "Id");

            migrationBuilder.AddColumn<string>(
                name: "Pacijent_Spol",
                table: "AspNetUsers",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Spol",
                table: "AspNetUsers",
                type: "nvarchar(max)",
                nullable: true);
        }
    }
}
