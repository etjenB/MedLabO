using MedLabO.Models;
using MedLabO.Models.Exceptions;
using MedLabO.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace MedLabO.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class BaseController<T, TSearch> : ControllerBase where T : class where TSearch : class
    {
        protected readonly IService<T, TSearch> _service;
        protected readonly ILogger<BaseController<T, TSearch>> _logger;
        private ILogger<BaseController<T, TSearch>> logger;
        private ICRUDService<T, TSearch, object, object> service;

        public BaseController(ILogger<BaseController<T, TSearch>> logger, IService<T, TSearch> service)
        {
            _logger = logger;
            _service = service;
        }

        [HttpGet]
        public async Task<IActionResult> Get([FromQuery] TSearch? search = null)
        {
            var pagedResult = await _service.Get(search);
            if (pagedResult == null || (pagedResult.Result != null && !pagedResult.Result.Any()))
            {
                return Ok(new PagedResult<T> { Result = new List<T>(), Count = 0 });
            }
            return Ok(pagedResult);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(Guid id)
        {
            var entity = await _service.GetById(id);
            if (entity == null)
            {
                return NotFound();
            }
            return Ok(entity);
        }

        [HttpDelete("{id}")]
        public virtual async Task<IActionResult> Delete(Guid id)
        {
            try
            {
                await _service.Delete(id);
                return NoContent();
            }
            catch (EntityNotFoundException)
            {
                return NotFound();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error deleting entity with ID {Id}", id);
                return StatusCode(500, "Internal server error");
            }
        }
    }
}