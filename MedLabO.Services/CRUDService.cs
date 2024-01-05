using AutoMapper;
using MedLabO.Models;
using MedLabO.Models.Exceptions;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public class CRUDService<T, TDb, TSearch, TInsert, TUpdate, TKey> : Service<T, TDb, TSearch> where T : class where TDb : class where TSearch : SearchObject where TKey : struct
    {
        private readonly ILogger<CRUDService<T, TDb, TSearch, TInsert, TUpdate, TKey>> _logger;

        public CRUDService(MedLabOContext db, IMapper mapper, ILogger<CRUDService<T, TDb, TSearch, TInsert, TUpdate, TKey>> logger)
            : base(db, mapper)
        {
            _logger = logger;
        }

        public virtual async Task BeforeInsert(TDb entity, TInsert insert)
        {

        }

        public virtual async Task AfterInsert(TDb entity, TInsert insert)
        {

        }

        public virtual async Task BeforeUpdate(TDb entity, TUpdate update)
        {

        }

        public virtual async Task<T> Insert(TInsert insert)
        {
            var set = _db.Set<TDb>();
            TDb entity = _mapper.Map<TDb>(insert);
            await BeforeInsert(entity, insert);
            if (_db.Entry(entity).State == EntityState.Detached)
            {
                set.Add(entity);
                try
                {
                    await _db.SaveChangesAsync();
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "An error occurred during Insert operation.");
                    throw new UserException(ex.Message);
                }
            }
            await AfterInsert(entity, insert);
            return _mapper.Map<T>(entity);
        }

        public virtual async Task<T> Update(TKey id, TUpdate update)
        {
            var set = _db.Set<TDb>();
            TDb entity;

            if (typeof(TKey) == typeof(int))
            {
                entity = await set.FindAsync(new object[] { (int)(object)id });
            }
            else if (typeof(TKey) == typeof(Guid))
            {
                entity = await set.FindAsync(new object[] { (Guid)(object)id });
            }
            else
            {
                throw new InvalidOperationException("Invalid key type.");
            }

            if (entity == null)
            {
                throw new EntityNotFoundException("Entity with that ID doesn't exist.");
            }

            _mapper.Map(update, entity);
            await BeforeUpdate(entity, update);
            if (_db.Entry(entity).State == EntityState.Modified)
            {
                try
                {

                    await _db.SaveChangesAsync();

                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, $"An error occurred during Update operation for ID: {id}");
                    throw new UserException(ex.Message);
                }
            }
            return _mapper.Map<T>(entity);
        }
    }
}
