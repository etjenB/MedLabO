﻿using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore.Migrations;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models
{
    public class Administrator
    {
        public string Id { get; set; }
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public bool IsKontakt { get; set; } = false;
        public string? KontaktInfo { get; set; }
    }
}
