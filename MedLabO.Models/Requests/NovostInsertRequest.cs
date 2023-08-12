﻿using System.ComponentModel.DataAnnotations;

namespace MedLabO.Models.Requests
{
    public class NovostInsertRequest
    {
        [Required(AllowEmptyStrings = false)]
        [MinLength(1)]
        [MaxLength(100)]
        public string Naslov { get; set; }

        [Required(AllowEmptyStrings = false)]
        [MinLength(1)]
        public string Sadrzaj { get; set; }

        public byte[] Slika { get; set; }

        [Required(AllowEmptyStrings = false)]
        public string AdministratorID { get; set; }
    }
}
