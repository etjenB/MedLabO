﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models
{
    public class TestParametar
    {
        public string TestParametarID { get; set; }
        public float? MinVrijednost { get; set; }
        public float? MaxVrijednost { get; set; }
        public string? NormalnaVrijednost { get; set; }
        public string? Jedinica { get; set; }
        //public virtual Test Test { get; set; }
    }
}