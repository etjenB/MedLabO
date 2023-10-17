using AutoMapper;
using MedLabO.Models.Requests;

namespace MedLabO.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Database.Administrator, Models.Administrator>().ReverseMap();
            CreateMap<AdministratorInsertRequest, Database.Administrator>().ReverseMap();
            CreateMap<AdministratorUpdateRequest, Database.Administrator>().ReverseMap();
            CreateMap<TestInsertRequest, Database.Test>().ReverseMap();
            CreateMap<TestUpdateRequest, Database.Test>().ReverseMap();
            CreateMap<Database.Test, Models.Test>().ReverseMap();
            CreateMap<TestParametarInsertRequest, Database.TestParametar>().ReverseMap();
            CreateMap<TestParametarUpdateRequest, Database.TestParametar>().ReverseMap();
            CreateMap<Database.TestParametar, Models.TestParametar>().ReverseMap();
            CreateMap<Database.Rezultat, Models.Rezultat>().ReverseMap();
            CreateMap<Database.Termin, Models.Termin>().ReverseMap();
            CreateMap<Database.TerminTest, Models.TerminTest>().ReverseMap();
            CreateMap<NovostInsertRequest, Database.Novost>().ReverseMap();
            CreateMap<NovostUpdateRequest, Database.Novost>().ReverseMap();
            CreateMap<Database.Novost, Models.Novost>().ReverseMap();
            CreateMap<ObavijestInsertRequest, Database.Obavijest>().ReverseMap();
            CreateMap<ObavijestUpdateRequest, Database.Obavijest>().ReverseMap();
            CreateMap<Database.Obavijest, Models.Obavijest>().ReverseMap();
            CreateMap<UslugaInsertRequest, Database.Usluga>().ReverseMap();
            CreateMap<UslugaUpdateRequest, Database.Usluga>().ReverseMap();
            CreateMap<Database.Usluga, Models.Usluga>().ReverseMap();
        }
    }
}