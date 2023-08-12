using System.ComponentModel.DataAnnotations;

namespace MedLabO.Models.Requests
{
    public class ObavijestInsertRequest
    {
        [Required(AllowEmptyStrings = false)]
        [MinLength(1)]
        [MaxLength(100)]
        public string Naslov { get; set; } = null!;

        [Required(AllowEmptyStrings = false)]
        public string Sadrzaj { get; set; } = null!;

        public byte[] Slika { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string AdministratorID { get; set; }
    }
}
