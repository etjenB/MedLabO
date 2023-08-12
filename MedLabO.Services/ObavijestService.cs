using AutoMapper;
using MedLabO.Models;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.EntityFrameworkCore;

namespace MedLabO.Services
{
    public class ObavijestService : CRUDService<Models.Obavijest, Database.Obavijest, ObavijestSearchObject, ObavijestInsertRequest, ObavijestUpdateRequest>, IObavijestService
    {
        public ObavijestService(MedLabOContext db, IMapper mapper) : base(db, mapper)
        {
        }

        public override async Task BeforeInsert(Database.Obavijest entity, ObavijestInsertRequest insert)
        {
            try
            {
                //TODO: Implement this to be able to take userID and put it into AdministratorID as in
                //administrator that created this Obavijest
                entity.DTKreiranja = DateTime.Now;
            }
            catch
            {
                throw new UserException("Unable to insert Obavijest.");
            }
        }

        public override async Task BeforeUpdate(Database.Obavijest entity, ObavijestUpdateRequest update)
        {
            try
            {
                //TODO: Implement this to be able to take userID and put it into AdministratorID as in
                //administrator that modified this Obavijest
                entity.DTZadnjeModifikacije = DateTime.Now;
            }
            catch
            {
                throw new UserException("Unable to update Obavijest.");
            }
        }

        public override IQueryable<Database.Obavijest> AddFilter(IQueryable<Database.Obavijest> query, ObavijestSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.Naslov))
            {
                query = query.Where(t => t.Naslov.StartsWith(search.Naslov));
            }

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                query = query.Where(t => t.Naslov.Contains(search.FTS));
            }

            return base.AddFilter(query, search);
        }

        public override IQueryable<Database.Obavijest> AddInclude(IQueryable<Database.Obavijest> query, ObavijestSearchObject? search = null)
        {
            if (search?.IncludeAdministrator == true)
            {
                query = query.Include("Administrator");
            }

            return base.AddInclude(query, search);
        }
    }
}
