using MedLabO.Models;
using MedLabO.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Migrations.Operations;

namespace MedLabO.Controllers
{
    [Route("[controller]")]
    public class BaseCRUDController<T, TSearch, TInsert, TUpdate, TKey> : BaseController<T, TSearch> where T : class where TSearch : class where TKey : struct
    {
        protected new readonly ICRUDService<T, TSearch, TInsert, TUpdate, TKey> _service;
        protected readonly ILogger<BaseController<T, TSearch>> _logger;

        public BaseCRUDController(ILogger<BaseController<T, TSearch>> logger, ICRUDService<T, TSearch, TInsert, TUpdate, TKey> service)
            : base(logger, service)
        {
            _logger = logger;
            _service = service;
        }

        [HttpPost]
        public virtual async Task<T> Insert([FromBody]TInsert insert)
        {
            return await _service.Insert(insert);
        }

        [HttpPut("{id}")]
        public virtual async Task<T> Update(TKey id, [FromBody]TUpdate update)
        {
            return await _service.Update(id, update);
        }
    }
}
