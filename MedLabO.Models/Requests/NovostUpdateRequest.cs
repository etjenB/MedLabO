﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models.Requests
{
    public class NovostUpdateRequest
    {
        [Required(AllowEmptyStrings = false)]
        [MinLength(1)]
        [MaxLength(100)]
        public string Naslov { get; set; }

        [Required(AllowEmptyStrings = false)]
        [MinLength(1)]
        public string Sadrzaj { get; set; }

        public byte[] Slika { get; set; }
    }
}