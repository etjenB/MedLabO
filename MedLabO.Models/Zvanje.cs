﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models
{
    public class Zvanje
    {
        public int? ZvanjeID { get; set; }
        public string? Naziv { get; set; }
        public string? Opis { get; set; }
    }
}