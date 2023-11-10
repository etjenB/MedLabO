using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public interface ITerminService : ICRUDService<Models.Termin, TerminSearchObject, TerminInsertRequest, TerminUpdateRequest>
    {
    }
}
