﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models
{
    public class Test
    {
        public string TestID { get; set; }
        public string Naziv { get; set; }
        public string Opis { get; set; }
        public decimal Cijena { get; set; }
        public string? NapomenaZaPripremu { get; set; }
        public string? TipUzorka { get; set; }
        public DateTime DTKreiranja { get; set; }
        public string? AdministratorID { get; set; }
        public virtual Administrator? Administrator { get; set; }
        public string? TestParametarID { get; set; }
        public virtual TestParametar? TestParametar { get; set; } = null!;
        //public Guid? RezultatID { get; set; }
        //public virtual Rezultat? Rezultat { get; set; }
    }
}
