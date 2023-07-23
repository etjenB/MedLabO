using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models.Requests
{
    public class AdministratorUpdateRequest
    {
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public bool IsKontakt { get; set; } = false;
        public string? KontaktInfo { get; set; }
        public string? Email { get; set; }
        public string? PhoneNumber { get; set; }
    }
}
