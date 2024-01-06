using System.ComponentModel.DataAnnotations;

namespace MedLabO.Models.Requests
{
    public class NovostUpdateRequest
    {
        [Required(AllowEmptyStrings = false)]
        [MinLength(1)]
        [MaxLength(100)]
        public string Naslov { get; set; }

        [Required(AllowEmptyStrings = false)]
        [MinLength(1)]
        public string Sadrzaj { get; set; }

        public byte[] Slika { get; set; }
    }
}
