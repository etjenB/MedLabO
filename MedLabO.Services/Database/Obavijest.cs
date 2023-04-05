using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services.Database
{
    public class Obavijest
    {
        [Key]
        public Guid ObavijestID { get; set; } = Guid.NewGuid();

        [Required]
        public string Naslov { get; set; } = null!;

        [Required]
        public string Sadrzaj { get; set; } = null!;

        [Required]
        public DateTime DTKreiranja { get; set; } = DateTime.Now;

        [Required]
        public byte[] Slika { get; set; } = new byte[0];

        [ForeignKey("Administrator")]
        public string? AdministratorID { get; set; }
        public virtual Administrator? Administrator { get; set; } = null!;
    }
}
