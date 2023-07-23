using MedLabO.Models;
using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace MedLabO.Services.Database
{
    public class Administrator : IdentityUser
    {
        //[Key]
        //public Guid AdministratorID { get; set; } = Guid.NewGuid();

        [Required]
        public string? Ime { get; set; }
        [Required]
        public string? Prezime { get; set; }

        [Required]
        public bool IsKontakt { get; set; } = false;

        //Ukoliko je dati administrator kontakt, u KontaktInfo se pise kratki opis kontakta
        //npr. KontaktInfo = "Podrska za korisnike";
        public string? KontaktInfo { get; set; }

        public virtual ICollection<Usluga> KreiraneUsluge { get; set; } = new List<Usluga>();
        public virtual ICollection<Test> KreiraniTestovi { get; set; } = new List<Test>();
        public virtual ICollection<Novost> KreiraneNovosti { get; set; } = new List<Novost>();
        public virtual ICollection<Obavijest> KreiraneObavijesti { get; set; } = new List<Obavijest>();

    }
}
