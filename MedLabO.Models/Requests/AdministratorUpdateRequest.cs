using System.ComponentModel.DataAnnotations;

namespace MedLabO.Models.Requests
{
    public class AdministratorUpdateRequest
    {
        [Required]
        [MaxLength(50)]
        public string? Ime { get; set; }

        [Required]
        [MaxLength(70)]
        public string? Prezime { get; set; }

        [Required]
        public bool IsKontakt { get; set; } = false;

        [Required]
        [MaxLength(70)]
        public string? KontaktInfo { get; set; }

        [Required]
        [MaxLength(30)]
        public string UserName { get; set; }

        [EmailAddress]
        public string Email { get; set; }

        [Phone]
        public string PhoneNumber { get; set; }
    }
}
