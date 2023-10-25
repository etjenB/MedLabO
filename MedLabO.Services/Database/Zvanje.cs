using System.ComponentModel.DataAnnotations;

namespace MedLabO.Services.Database
{
    public class Zvanje
    {
        [Key]
        public int ZvanjeID { get; set; }

        [Required]
        public string Naziv { get; set; } = null!;

        public string? Opis { get; set; }

        //Lista zaposlenika sa datim zvanjem
        public virtual ICollection<MedicinskoOsoblje> MedicinskoOsoblje { get; set; } = new List<MedicinskoOsoblje>();
    }
}