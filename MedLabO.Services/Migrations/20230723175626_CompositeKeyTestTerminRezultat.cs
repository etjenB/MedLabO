using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MedLabO.Services.Migrations
{
    public partial class CompositeKeyTestTerminRezultat : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_TestTerminRezultati_Rezultati_RezultatID",
                table: "TestTerminRezultati");

            migrationBuilder.DropForeignKey(
                name: "FK_TestTerminRezultati_Termini_TerminID",
                table: "TestTerminRezultati");

            migrationBuilder.DropForeignKey(
                name: "FK_TestTerminRezultati_Testovi_TestID",
                table: "TestTerminRezultati");

            migrationBuilder.DropPrimaryKey(
                name: "PK_TestTerminRezultati",
                table: "TestTerminRezultati");

            migrationBuilder.DropIndex(
                name: "IX_TestTerminRezultati_TestID",
                table: "TestTerminRezultati");

            migrationBuilder.DropColumn(
                name: "TestTerminRezultatID",
                table: "TestTerminRezultati");

            migrationBuilder.AlterColumn<Guid>(
                name: "TestID",
                table: "TestTerminRezultati",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier",
                oldNullable: true);

            migrationBuilder.AlterColumn<Guid>(
                name: "TerminID",
                table: "TestTerminRezultati",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier",
                oldNullable: true);

            migrationBuilder.AlterColumn<Guid>(
                name: "RezultatID",
                table: "TestTerminRezultati",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier",
                oldNullable: true);

            migrationBuilder.AddPrimaryKey(
                name: "PK_TestTerminRezultati",
                table: "TestTerminRezultati",
                columns: new[] { "TestID", "TerminID", "RezultatID" });

            migrationBuilder.AddForeignKey(
                name: "FK_TestTerminRezultati_Rezultati_RezultatID",
                table: "TestTerminRezultati",
                column: "RezultatID",
                principalTable: "Rezultati",
                principalColumn: "RezultatID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_TestTerminRezultati_Termini_TerminID",
                table: "TestTerminRezultati",
                column: "TerminID",
                principalTable: "Termini",
                principalColumn: "TerminID",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_TestTerminRezultati_Testovi_TestID",
                table: "TestTerminRezultati",
                column: "TestID",
                principalTable: "Testovi",
                principalColumn: "TestID",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_TestTerminRezultati_Rezultati_RezultatID",
                table: "TestTerminRezultati");

            migrationBuilder.DropForeignKey(
                name: "FK_TestTerminRezultati_Termini_TerminID",
                table: "TestTerminRezultati");

            migrationBuilder.DropForeignKey(
                name: "FK_TestTerminRezultati_Testovi_TestID",
                table: "TestTerminRezultati");

            migrationBuilder.DropPrimaryKey(
                name: "PK_TestTerminRezultati",
                table: "TestTerminRezultati");

            migrationBuilder.AlterColumn<Guid>(
                name: "RezultatID",
                table: "TestTerminRezultati",
                type: "uniqueidentifier",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier");

            migrationBuilder.AlterColumn<Guid>(
                name: "TerminID",
                table: "TestTerminRezultati",
                type: "uniqueidentifier",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier");

            migrationBuilder.AlterColumn<Guid>(
                name: "TestID",
                table: "TestTerminRezultati",
                type: "uniqueidentifier",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier");

            migrationBuilder.AddColumn<Guid>(
                name: "TestTerminRezultatID",
                table: "TestTerminRezultati",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddPrimaryKey(
                name: "PK_TestTerminRezultati",
                table: "TestTerminRezultati",
                column: "TestTerminRezultatID");

            migrationBuilder.CreateIndex(
                name: "IX_TestTerminRezultati_TestID",
                table: "TestTerminRezultati",
                column: "TestID");

            migrationBuilder.AddForeignKey(
                name: "FK_TestTerminRezultati_Rezultati_RezultatID",
                table: "TestTerminRezultati",
                column: "RezultatID",
                principalTable: "Rezultati",
                principalColumn: "RezultatID");

            migrationBuilder.AddForeignKey(
                name: "FK_TestTerminRezultati_Termini_TerminID",
                table: "TestTerminRezultati",
                column: "TerminID",
                principalTable: "Termini",
                principalColumn: "TerminID");

            migrationBuilder.AddForeignKey(
                name: "FK_TestTerminRezultati_Testovi_TestID",
                table: "TestTerminRezultati",
                column: "TestID",
                principalTable: "Testovi",
                principalColumn: "TestID");
        }
    }
}
