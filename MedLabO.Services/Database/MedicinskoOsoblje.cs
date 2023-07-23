using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services.Database
{
    public class MedicinskoOsoblje : IdentityUser
    {
        //[Key]
        //public Guid MedicinskoOsobljeID { get; set; } = Guid.NewGuid();

        [Required]
        public string? Ime { get; set; }
        [Required]
        public string? Prezime { get; set; }

        //IsActive nam govori da li ovaj zaposlenik radi u laboratoriju
        //Primjer radi boljeg razumijevanja: ukoliko osoba vise nije u stalnom ili privremenom radnom odnosu onda je IsActive = false;
        //Takodjer, moze se koristiti ukoliko zaposleni uzme duzi godisnji odmor, moze se staviti IsActive = false;, a kada se vrati moze se staviti IsActive = true;
        [Required]
        public bool IsActive { get; set; } = true;

        //Datum stupanja u radni odnos
        [Required]
        public DateTime DTZaposlenja { get; set; } = DateTime.Now;

        //Datum prekida radnog odnosa
        public DateTime? DTPrekidRadnogOdnosa { get; set; }

        [Required]
        public string Spol { get; set; } = null!;

        //Lista odobrenih termina
        public virtual ICollection<Termin> OdobreniTermini { get; set; } = new List<Termin>();

        //Jedan zaposlenik moze imati samo jedno zvanje tj. ulogu koju obavlja u laboratoriju
        //Npr. Doktor, LaboratorijskiTehnicar itd.
        //Dok potencijalno postoji vise zaposlenika sa istim zvanjem
        [ForeignKey("Zvanje")]
        public Guid? ZvanjeID { get; set; }
        public virtual Zvanje? Zvanje { get; set; } = null!;

    }
}
