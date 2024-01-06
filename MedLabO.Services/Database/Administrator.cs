using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations;

namespace MedLabO.Services.Database
{
    public class Administrator : ApplicationUser
    {
        [Required]
        public string? Ime { get; set; }

        [Required]
        public string? Prezime { get; set; }

        [Required]
        public bool IsKontakt { get; set; } = false;

        //Ukoliko je dati administrator kontakt, u KontaktInfo se pise nacin kontakta
        //npr. KontaktInfo = "medlabo_podrska@gmail.com";
        public string? KontaktInfo { get; set; }

        public virtual ICollection<Usluga> KreiraneUsluge { get; set; } = new List<Usluga>();
        public virtual ICollection<Test> KreiraniTestovi { get; set; } = new List<Test>();
        public virtual ICollection<Novost> KreiraneNovosti { get; set; } = new List<Novost>();
        public virtual ICollection<Obavijest> KreiraneObavijesti { get; set; } = new List<Obavijest>();
    }
}