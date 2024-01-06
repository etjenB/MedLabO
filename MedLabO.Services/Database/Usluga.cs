using MedLabO.Services.Database;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MedLabO.Services.Database
{
    public class Usluga
    {
        [Key]
        public int UslugaID { get; set; }

        [Required]
        public string Naziv { get; set; } = null!;

        [Required]
        public string Opis { get; set; } = null!;

        [Required]
        [Range(0.01, double.MaxValue, ErrorMessage = "Cijena mora biti veca od nula.")]
        public decimal Cijena { get; set; }

        //TrajanjeUMin pohranjuje koliko otprilike traje proces davanja uzoraka i svih ostalih procesa potrebnih za uslugu
        //izrazava se u minutama
        //npr. TrajanjeUMin=15 znaci da traje otprilike 15 minuta
        [Required]
        [Range(0, int.MaxValue, ErrorMessage = "Vrijednost mora biti pozitivna.")]
        public int TrajanjeUMin { get; set; }

        //RezultatUH pohranjuje koliko otprilike je potrebno da se obrade dati uzorci pojedinih testova gledajuci ukupno kao uslugu
        //izrazava se u satima
        //npr. RezultatUH=24 znaci u roku od 24 sata najcesce stizu rezultati
        [Required]
        [Range(0.0f, float.MaxValue, ErrorMessage = "Vrijednost mora biti pozitivna.")]
        public float RezultatUH { get; set; }

        //Dostupno oznacava da li je trenutno ta usluga dostupna u laboratoriju
        [Required]
        public bool Dostupno { get; set; } = true;

        //DatumIVrijemeKreiranja pohranjuje kada je data usluga kreirana od strane administratora
        [Required]
        public DateTime DTKreiranja { get; set; } = DateTime.Now;

        //DatumIVrijemeModifikacije pohranjuje kada je data usluga zadnji put modificirana od strane administratora
        public DateTime? DTZadnjeModifikacije { get; set; }

        public byte[]? Slika { get; set; }

        public virtual ICollection<Termin> UslugaTermini { get; set; } = new List<Termin>();
        public virtual ICollection<Test> UslugaTestovi { get; set; } = new List<Test>();

        [ForeignKey("Administrator")]
        public Guid? AdministratorID { get; set; }

        [NotMapped]
        public virtual Administrator? Administrator { get; set; } = null!;
    }
}