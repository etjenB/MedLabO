using AutoMapper;
using MedLabO.Models.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Database.Administrator, Models.Administrator>();
            CreateMap<AdministratorInsertRequest, Database.Administrator > ();
            CreateMap<AdministratorUpdateRequest, Database.Administrator>();
            CreateMap<Database.Test, Models.Test>();
            CreateMap<Database.TestParametar, Models.TestParametar>();
        }
    }
}
