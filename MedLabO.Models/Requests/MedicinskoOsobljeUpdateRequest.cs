using System.ComponentModel.DataAnnotations;

namespace MedLabO.Models.Requests
{
    public class MedicinskoOsobljeUpdateRequest
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        [MaxLength(50)]
        public string? Ime { get; set; }

        [Required]
        [MaxLength(70)]
        public string? Prezime { get; set; }

        [Required]
        public bool IsActive { get; set; }

        [Required]
        public int SpolID { get; set; }

        [Required]
        public int ZvanjeID { get; set; }

        [Required]
        [MaxLength(30)]
        public string UserName { get; set; }

        [EmailAddress]
        public string Email { get; set; }

        [Phone]
        public string PhoneNumber { get; set; }
    }
}
