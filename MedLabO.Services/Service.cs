﻿using AutoMapper;
using MedLabO.Models;
using MedLabO.Models.Exceptions;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.EntityFrameworkCore;

namespace MedLabO.Services
{
    public class Service<T, TDb, TSearch> : IService<T, TSearch> where TDb : class where T : class where TSearch : SearchObject
    {
        protected readonly MedLabOContext _db;
        protected IMapper _mapper;

        public Service(MedLabOContext db, IMapper mapper)
        {
            _db = db;
            _mapper = mapper;
        }

        public virtual async Task<PagedResult<T>> Get(TSearch? search = null)
        {
            var query = _db.Set<TDb>().AsQueryable();

            PagedResult<T> result = new PagedResult<T>();

            query = AddFilter(query, search);

            query = AddInclude(query, search);

            query = ApplyOrdering(query, search);

            result.Count = await query.CountAsync();

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Skip(search.Page.Value * search.PageSize.Value).Take(search.PageSize.Value);
            }

            if (search?.UseSplitQuery == true)
            {
                query = query.AsSplitQuery();
            }

            var list = await query.ToListAsync();

            result.Result = _mapper.Map<List<T>>(list);

            return result;
        }

        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch? search = null)
        {
            return query;
        }

        public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query, TSearch? search = null)
        {
            return query;
        }

        public virtual IQueryable<TDb> ApplyOrdering(IQueryable<TDb> query, TSearch? search)
        {
            return query;
        }

        public virtual async Task<T> GetById(Guid id)
        {
            var entity = await _db.Set<TDb>().FindAsync(id);
            if (entity is null) throw new EntityNotFoundException();
            return _mapper.Map<T>(entity);
        }

        public virtual async Task Delete(Guid id)
        {
            var entity = await _db.Set<TDb>().FindAsync(id);
            if (entity is null) throw new EntityNotFoundException();
            if (entity is Database.ApplicationUser) (entity as Database.ApplicationUser).isDeleted = true;
            else if (entity is Database.SoftDeleteEntity) (entity as Database.SoftDeleteEntity).isDeleted = true;
            else _db.Set<TDb>().Remove(entity);
            await _db.SaveChangesAsync();
        }
    }
}