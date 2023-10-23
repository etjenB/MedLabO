using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
        public string Spol { get; set; }

        [Required]
        public string ZvanjeID { get; set; }

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
