using MedLabO.Models.CustomAttributes;
using System.ComponentModel.DataAnnotations;

namespace MedLabO.Models.Requests
{
    public class PacijentRegistrationRequest
    {
        [Required]
        [MaxLength(50, ErrorMessage = "Maksimalna dužina imena je 50 karaktera.")]
        public string? Ime { get; set; }

        [Required]
        [MaxLength(70, ErrorMessage = "Maksimalna dužina prezimena je 70 karaktera.")]
        public string? Prezime { get; set; }


        [MinimumDateTime(1920, 1, 1)]
        public DateTime? DatumRodjenja { get; set; }


        [MaxLength(70, ErrorMessage = "Maksimalna dužina adrese je 70 karaktera.")]
        public string? Adresa { get; set; }

        [Required]
        [GenderCheck]
        public int SpolID { get; set; }

        [Required]
        [MaxLength(30, ErrorMessage = "Maksimalna dužina korisničkog imena je 30 karaktera.")]
        public string UserName { get; set; }

        [Required]
        [MaxLength(30, ErrorMessage = "Maksimalna dužina lozinke je 30 karaktera.")]
        public string Password { get; set; }

        [Required]
        [MaxLength(70, ErrorMessage = "Maksimalna dužina email-a je 70 karaktera.")]
        public string Email { get; set; }

        [Required]
        [MaxLength(10, ErrorMessage = "Maksimalna dužina telefonskog broja je 10 karaktera.")]
        public string PhoneNumber { get; set; }
    }
}
