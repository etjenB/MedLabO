using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public interface IUslugaService : ICRUDService<Models.Usluga, UslugaSearchObject, UslugaInsertRequest, UslugaUpdateRequest>
    {
    }
}
