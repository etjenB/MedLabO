using Microsoft.AspNetCore.Identity;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MedLabO.Services.Database
{
    public class MedicinskoOsoblje : ApplicationUser
    {
        //[Key]
        //public Guid MedicinskoOsobljeID { get; set; } = Guid.NewGuid();

        [Required]
        public string Ime { get; set; } = null!;

        [Required]
        public string Prezime { get; set; } = null!;

        //IsActive nam govori da li ovaj zaposlenik radi u laboratoriju
        //Primjer radi boljeg razumijevanja: ukoliko osoba vise nije u stalnom ili privremenom radnom odnosu onda je IsActive = false;
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