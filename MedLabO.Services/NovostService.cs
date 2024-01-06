using AutoMapper;
using MedLabO.Models.Exceptions;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System.Security.Claims;

namespace MedLabO.Services
{
    public class NovostService : CRUDService<Models.Novost, Database.Novost, NovostSearchObject, NovostInsertRequest, NovostUpdateRequest, Guid>, INovostService
    {
        private readonly ILogger<NovostService> _logger;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public NovostService(MedLabOContext db, IMapper mapper, IHttpContextAccessor httpContextAccessor, ILogger<NovostService> logger) : base(db, mapper, logger)
        {
            _httpContextAccessor = httpContextAccessor;
            _logger = logger;
        }

        public override async Task BeforeInsert(Database.Novost entity, NovostInsertRequest insert)
        {
            try
            {
                entity.DTKreiranja = DateTime.Now;
                string? currentUserId = _httpContextAccessor?.HttpContext?.User?.FindFirst(ClaimTypes.Name)?.Value;
                if (string.IsNullOrEmpty(currentUserId))
                {
                    throw new UserException("User ID not found.");
                }
                entity.AdministratorID = Guid.Parse(currentUserId);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error occurred while inserting Novost.");
                throw new UserException("Unable to insert Novost.");
            }
        }

        public override async Task BeforeUpdate(Database.Novost entity, NovostUpdateRequest update)
        {
            try
            {
                entity.DTZadnjeModifikacije = DateTime.Now;
                string? currentUserId = _httpContextAccessor?.HttpContext?.User?.FindFirst(ClaimTypes.Name)?.Value;
                if (string.IsNullOrEmpty(currentUserId))
                {
                    throw new UserException("User ID not found.");
                }
                entity.AdministratorID = Guid.Parse(currentUserId);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error occurred while updating Novost.");
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