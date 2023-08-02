using AutoMapper;
using MedLabO.Models;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Identity;
using Administrator = MedLabO.Services.Database.Administrator;

namespace MedLabO.Services
{
    public class AdministratorService : CRUDService<Models.Administrator, Database.Administrator, AdministratorSearchObject, AdministratorInsertRequest, AdministratorUpdateRequest>, IAdministratorService
    {
        private UserManager<IdentityUser> _userManager;

        public AdministratorService(MedLabOContext db, IMapper mapper, UserManager<IdentityUser> userManager) : base(db, mapper)
        {
            _userManager = userManager;
        }

        //public async Task<IList<Models.Administrator>> Get()
        //{
        //    var entityList = await _db.Administratori.ToListAsync();
        //    //var list = new List<Models.Administrator>();
        //    //foreach (var item in entityList)
        //    //{
        //    //    list.Add(new Models.Administrator() {
        //    //        Ime = item.Ime,
        //    //        Prezime = item.Prezime,
        //    //        IsKontakt = item.IsKontakt,
        //    //        KontaktInfo = item.KontaktInfo
        //    //    });
        //    //}
        //    //return list;

        //    return _mapper.Map<List<Models.Administrator>>(entityList);
        //}

        //public async Task<Models.Administrator> Insert(AdministratorInsertRequest administrator)
        //{
        //    var role = "Administrator";
        //    var entity = new Database.Administrator();
        //    //var korisnik = new Database.Administrator()
        //    //{
        //    //    UserName = administrator.UserName,
        //    //    Ime = administrator.Ime,
        //    //    Prezime = administrator.Prezime,
        //    //    Email = administrator.Email
        //    //};
        //    _mapper.Map(administrator, entity);

        //    try
        //    {
        //        var result = await _userManager.CreateAsync(entity, administrator.Password);
        //        await _userManager.AddToRoleAsync(entity, role);
        //        _db.Administratori.Add(entity);
        //        _db.SaveChanges();
        //        return _mapper.Map<Models.Administrator>(entity);
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        public override async Task BeforeInsert(Administrator entity, AdministratorInsertRequest insert)
        {
            var role = "Administrator";
            try
            {
                var result = await _userManager.CreateAsync(entity, insert.Password);
                await _userManager.AddToRoleAsync(entity, role);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //public async Task<Models.Administrator> Update(string Id, AdministratorUpdateRequest administrator)
        //{
        //    var entity = await _db.Administratori.FindAsync(Id);
        //    _mapper.Map(administrator, entity);
        //    await _db.SaveChangesAsync();
        //    return _mapper.Map<Models.Administrator>(entity);
        //}
    }
}