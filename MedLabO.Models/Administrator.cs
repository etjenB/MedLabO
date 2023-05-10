using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore.Migrations;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models
{
    //baca mi error jer je nekako usluga i administrator kako su povezani pa nesta nije u redu
    public class Administrator
    {
        [Required]
        public string? Ime { get; set; }
        [Required]
        public string? Prezime { get; set; }

        [Required]
        public bool IsKontakt { get; set; } = false;

        //Ukoliko je dati administrator kontakt, u KontaktInfo se pise kratki opis kontakta
        //npr. KontaktInfo = "Podrska za korisnike";
        public string? KontaktInfo { get; set; }
    }
}
