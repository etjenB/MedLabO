﻿using MedLabO.Models;
using MedLabO.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public interface IAdministratorService
    {
        IList<Models.Administrator> Get();
    }
}
