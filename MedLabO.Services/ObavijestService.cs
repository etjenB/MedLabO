﻿using AutoMapper;
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
    public class ObavijestService : CRUDService<Models.Obavijest, Database.Obavijest, ObavijestSearchObject, ObavijestInsertRequest, ObavijestUpdateRequest, Guid>, IObavijestService
    {
        private readonly ILogger<ObavijestService> _logger;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public ObavijestService(MedLabOContext db, IMapper mapper, IHttpContextAccessor httpContextAccessor, ILogger<ObavijestService> logger) : base(db, mapper, logger)
        {
            _httpContextAccessor = httpContextAccessor;
            _logger = logger;
        }

        public override async Task BeforeInsert(Database.Obavijest entity, ObavijestInsertRequest insert)
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
                _logger.LogError(ex, "Error occurred while inserting Obavijest.");
                throw new UserException("Unable to insert Obavijest.");
            }
        }

        public override async Task BeforeUpdate(Database.Obavijest entity, ObavijestUpdateRequest update)
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
                _logger.LogError(ex, "Error occurred while updating Obavijest.");
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
