using AutoMapper;
using MedLabO.Models;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public class CRUDService<T, TDb, TSearch, TInsert, TUpdate> : Service<T, TDb, TSearch> where T : class where TDb : class where TSearch : SearchObject
    {
        public CRUDService(MedLabOContext db, IMapper mapper) : base(db, mapper)
        {
        }

        public virtual async Task BeforeInsert(TDb entity, TInsert insert)
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
            set.Add(entity);
            
            await _db.SaveChangesAsync();
            return _mapper.Map<T>(entity);
        }

        public virtual async Task<T> Update(Guid id, TUpdate update)
        {
            var set = _db.Set<TDb>();
            var entity = await set.FindAsync(id);
            _mapper.Map(update, entity);
            try
            {
                await BeforeUpdate(entity, update);
            }
            catch
            {
                throw new UserException("Entity with that ID doesn't exist.");
            }
            await _db.SaveChangesAsync();
            return _mapper.Map<T>(entity);
        }
    }
}
