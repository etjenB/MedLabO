using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

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
        public Guid? AdministratorID { get; set; }

        public virtual Administrator? Administrator { get; set; } = null!;
    }
}