﻿using MedLabO.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public interface IUslugaService
    {
        Task<IList<Usluga>> Get();
    }
}
