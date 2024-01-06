using MedLabO.Models.CustomAttributes;
using System.ComponentModel.DataAnnotations;

namespace MedLabO.Models.Requests
{
    public class MedicinskoOsobljeRegistrationRequest
    {
        [Required]
        [MaxLength(50)]
        public string? Ime { get; set; }

        [Required]
        [MaxLength(70)]
        public string? Prezime { get; set; }

        [Required]
        public bool IsActive { get; set; }

        [Required]
        [GenderCheck]
        public int SpolID { get; set; }

        [Required]
        public int ZvanjeID { get; set; }

        [Required]
        [MaxLength(30)]
        public string UserName { get; set; }

        [Required]
        [MaxLength(30)]
        public string Password { get; set; }

        public string Email { get; set; }
        public string PhoneNumber { get; set; }
    }
}
