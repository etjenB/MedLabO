using AutoMapper;
using MedLabO.Models.Requests;

namespace MedLabO.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Database.Administrator, Models.Administrator>();
            CreateMap<AdministratorInsertRequest, Database.Administrator>();
            CreateMap<AdministratorUpdateRequest, Database.Administrator>();
            CreateMap<TestInsertRequest, Database.Test>();
            CreateMap<TestUpdateRequest, Database.Test>();
            CreateMap<Database.Test, Models.Test>();
            CreateMap<Database.TestParametar, Models.TestParametar>();
            CreateMap<Database.Rezultat, Models.Rezultat>();
            CreateMap<Database.Termin, Models.Termin>();
            CreateMap<Database.TerminTest, Models.TerminTest>();
            CreateMap<NovostInsertRequest, Database.Novost>();
            CreateMap<NovostUpdateRequest, Database.Novost>();
            CreateMap<Database.Novost, Models.Novost>();
            CreateMap<ObavijestInsertRequest, Database.Obavijest>();
            CreateMap<ObavijestUpdateRequest, Database.Obavijest>();
            CreateMap<Database.Obavijest, Models.Obavijest>();
        }
    }
}