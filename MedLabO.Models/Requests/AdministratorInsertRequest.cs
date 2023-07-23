﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models.Requests
{
    public class AdministratorInsertRequest
    {
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public bool IsKontakt { get; set; } = false;
        public string? KontaktInfo { get; set; }
        public string? UserName { get; set; }
        public string? Password { get; set; }
        public string? Email { get; set; }
        public string? PhoneNumber { get; set; }
    }
}
