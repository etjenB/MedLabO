using AutoMapper;
using MedLabO.Models;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace MedLabO.Services
{
    public class NovostService : CRUDService<Models.Novost, Database.Novost, NovostSearchObject, NovostInsertRequest, NovostUpdateRequest>, INovostService
    {
        public NovostService(MedLabOContext db, IMapper mapper) : base(db, mapper)
        {
        }

        public override async Task BeforeInsert(Database.Novost entity, NovostInsertRequest insert)
        {
            try
            {
                //TODO: Implement this to be able to take userID and put it into AdministratorID as in
                //administrator that created this Novost
                entity.DTKreiranja = DateTime.Now;
            }
            catch
            {
                throw new UserException("Unable to insert Novost.");
            }
        }

        public override async Task BeforeUpdate(Database.Novost entity, NovostUpdateRequest update)
        {
            try
            {
                //TODO: Implement this to be able to take userID and put it into AdministratorID as in
                //administrator that modified this Novost
                entity.DTZadnjeModifikacije = DateTime.Now;
            }
            catch
            {
                throw new UserException("Unable to update Novost.");
            }
        }

        public override IQueryable<Database.Novost> AddFilter(IQueryable<Database.Novost> query, NovostSearchObject? search = null)
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

        public override IQueryable<Database.Novost> AddInclude(IQueryable<Database.Novost> query, NovostSearchObject? search = null)
        {
            if (search?.IncludeAdministrator == true)
            {
                query = query.Include("Administrator");
            }

            return base.AddInclude(query, search);
        }
    }
}