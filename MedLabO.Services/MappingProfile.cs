using AutoMapper;
using MedLabO.Models.Pacijent;
using MedLabO.Models.Requests;
using MedLabO.Models.Requests.Termin;
using MedLabO.Models.Termin;
using MedLabO.Models.Test;
using MedLabO.Models.Usluga;

namespace MedLabO.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Database.Administrator, Models.Administrator>().ReverseMap();
            CreateMap<AdministratorInsertRequest, Database.Administrator>().ReverseMap();
            CreateMap<AdministratorUpdateRequest, Database.Administrator>().ReverseMap();
            CreateMap<Database.MedicinskoOsoblje, Models.MedicinskoOsoblje>().ReverseMap();
            CreateMap<MedicinskoOsobljeRegistrationRequest, Database.MedicinskoOsoblje>().ReverseMap();
            CreateMap<MedicinskoOsobljeUpdateRequest, Database.MedicinskoOsoblje>().ReverseMap();
            CreateMap<Database.Pacijent, Pacijent>().ReverseMap();
            CreateMap<Database.Pacijent, PacijentWithoutTermini>().ReverseMap();
            CreateMap<PacijentRegistrationRequest, Database.Pacijent>().ReverseMap();
            CreateMap<Database.Spol, Models.Spol>().ReverseMap();
            CreateMap<Database.Zvanje, Models.Zvanje>().ReverseMap();
            CreateMap<TestInsertRequest, Database.Test>().ReverseMap();
            CreateMap<TestUpdateRequest, Database.Test>().ReverseMap();
            CreateMap<Database.Test, Test>().ReverseMap();
            CreateMap<Database.Test, TestWithoutTerminTestovi>().ReverseMap();
            CreateMap<Database.Test, TestBasicData>().ReverseMap();
            CreateMap<TestParametarInsertRequest, Database.TestParametar>().ReverseMap();
            CreateMap<TestParametarUpdateRequest, Database.TestParametar>().ReverseMap();
            CreateMap<Database.TestParametar, Models.TestParametar>().ReverseMap();
            CreateMap<Database.Rezultat, Models.Rezultat>().ReverseMap();
            CreateMap<Database.Termin, Termin>().ReverseMap();
            CreateMap<Database.Termin, TerminMinimal>().ReverseMap();
            CreateMap<TerminInsertRequest, Database.Termin>().ReverseMap();
            CreateMap<TerminUpdateRequest, Database.Termin>().ReverseMap();
            CreateMap<Database.TerminTest, Models.TerminTest>().ReverseMap();
            CreateMap<Database.Racun, Models.Racun>().ReverseMap();
            CreateMap<Database.Zakljucak, Models.Zakljucak>().ReverseMap();
            CreateMap<NovostInsertRequest, Database.Novost>().ReverseMap();
            CreateMap<NovostUpdateRequest, Database.Novost>().ReverseMap();
            CreateMap<Database.Novost, Models.Novost>().ReverseMap();
            CreateMap<ObavijestInsertRequest, Database.Obavijest>().ReverseMap();
            CreateMap<ObavijestUpdateRequest, Database.Obavijest>().ReverseMap();
            CreateMap<Database.Obavijest, Models.Obavijest>().ReverseMap();
            CreateMap<UslugaInsertRequest, Database.Usluga>().ReverseMap();
            CreateMap<UslugaUpdateRequest, Database.Usluga>().ReverseMap();
            CreateMap<Database.Usluga, Usluga>().ReverseMap();
            CreateMap<Database.Usluga, UslugaBasicData>().ReverseMap();
        }
    }
}