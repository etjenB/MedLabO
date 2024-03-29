﻿using System.ComponentModel.DataAnnotations;

namespace MedLabO.Models.Requests.Termin
{
    public class TerminInsertRequest
    {
        [Required]
        public DateTime DTTermina { get; set; }

        [MaxLength(300, ErrorMessage = "Napomena ne može biti duža od 300 karaktera.")]
        public string? Napomena { get; set; }


        public List<int>? Usluge { get; set; } = new List<int>();
        public List<string>? Testovi { get; set; } = new List<string>();
    }
}
