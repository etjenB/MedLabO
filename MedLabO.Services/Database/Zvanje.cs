using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services.Database
{
    public class Zvanje
    {
        [Key]
        public Guid ZvanjeID { get; set; } = Guid.NewGuid();

        [Required]
        public string Naziv { get; set; } = null!;

        public string? Opis { get; set; }

        //Lista zaposlenika sa datim zvanjem
        public ICollection<MedicinskoOsoblje> MedicinskoOsoblje { get; set; } = new List<MedicinskoOsoblje>();

    }
}
