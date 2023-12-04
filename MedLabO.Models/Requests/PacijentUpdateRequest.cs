using MedLabO.Models.CustomAttributes;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models.Requests
{
    public class PacijentUpdateRequest
    {
        [Required]
        public Guid Id { get; set; }

        [Required]
        [MaxLength(50, ErrorMessage = "Maksimalna dužina imena je 50 karaktera.")]
        public string? Ime { get; set; }

        [Required]
        [MaxLength(70, ErrorMessage = "Maksimalna dužina prezimena je 70 karaktera.")]
        public string? Prezime { get; set; }

        [MinimumDateTime(1920, 1, 1)]
        public DateTime? DatumRodjenja { get; set; } = null;


        [MaxLength(70, ErrorMessage = "Maksimalna dužina adrese je 70 karaktera.")]
        public string? Adresa { get; set; }

        [Required]
        [GenderCheck]
        public int SpolID { get; set; }

        [Required]
        [MaxLength(30, ErrorMessage = "Maksimalna dužina korisničkog imena je 30 karaktera.")]
        public string UserName { get; set; }

        [Required]
        [MaxLength(70, ErrorMessage = "Maksimalna dužina email-a je 70 karaktera.")]
        public string Email { get; set; }

        [Required]
        [MaxLength(10, ErrorMessage = "Maksimalna dužina telefonskog broja je 10 karaktera.")]
        public string PhoneNumber { get; set; }
    }
}
