﻿using MedLabO.Models.Constants;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using MedLabO.Services.Database;
using Microsoft.Extensions.Configuration;
using MedLabO.Models.Exceptions;
using Microsoft.EntityFrameworkCore;
using MedLabO.Models.Requests;
using AutoMapper;
using Microsoft.Extensions.Logging;

namespace MedLabO.Services
{
    public class AuthService : IAuthService
    {
        private readonly ILogger<AuthService> _logger;
        private UserManager<Database.ApplicationUser> _userManager;
        private readonly IConfiguration _configuration;
        private readonly MedLabOContext _db;
        private IMapper _mapper;

        public AuthService(ILogger<AuthService> logger, UserManager<Database.ApplicationUser> userManager, IConfiguration configuration, MedLabOContext db, IMapper mapper)
        {
            _logger = logger;
            _userManager = userManager;
            _configuration = configuration;
            _db = db;
            _mapper = mapper;
        }

        public async Task<string> Login(string username, string password)
        {
            //Microsoft Identity kada traži usera u bazi po username-u je case insensitive
            var user = await _userManager.FindByNameAsync(username);

            if (user == null || !await _userManager.CheckPasswordAsync(user, password))
            {
                throw new UserException("Invalid login attempt.");
            }

            if (user is Database.MedicinskoOsoblje && (user as Database.MedicinskoOsoblje)?.IsActive == false)
            {
                throw new UserException("User's account is not active.");
            }

            if (user is Database.ApplicationUser && (user as Database.ApplicationUser)?.isDeleted == true)
            {
                throw new UserException("User's account is deleted.");
            }

            var role = await DetermineUserRole(user);

            if (string.IsNullOrEmpty(role))
            {
                throw new UserException("User doesn't have a role.");
            }

            return GenerateToken(user, role);
        }

        public async Task<string> PacijentRegistration(PacijentRegistrationRequest request)
        {
            //Microsoft Identity kada traži usera u bazi po username-u je case insensitive
            var existingUser = await _userManager.FindByNameAsync(request.UserName);
            if (existingUser != null)
            {
                throw new UserException("Korisnicko ime vec postoji.");
            }

            var existingUserByEmail = await _userManager.FindByEmailAsync(request.Email);
            if (existingUserByEmail != null)
            {
                throw new UserException("E-mail se vec koristi od strane drugog korisnika.");
            }

            try
            {
                var pacijent = _mapper.Map<Database.Pacijent>(request);
                await _userManager.CreateAsync(pacijent, request.Password);
                await _userManager.AddToRoleAsync(pacijent, RoleNames.Pacijent);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unable to register Pacijent.");
                throw new UserException("Unable to register Pacijent.");
            }

            var user = await _userManager.FindByNameAsync(request.UserName);
            if (user == null)
            {
                throw new UserException("User registration failed.");
            }

            var role = await DetermineUserRole(user);

            if (string.IsNullOrEmpty(role))
            {
                throw new UserException("User doesn't have a role.");
            }

            return GenerateToken(user, role);
        }

        #region private
        private async Task<string> DetermineUserRole(Database.ApplicationUser user)
        {
            var roles = await _userManager.GetRolesAsync(user);
            return roles.FirstOrDefault(r => RoleNames.AllRoles.Contains(r));
        }

        private string GenerateToken(Database.ApplicationUser user, string role)
        {
            var keyString = _configuration["JwtSettings:Key"];

            if (string.IsNullOrEmpty(keyString))
            {
                throw new Exception("JWT key is missing from configuration.");
            }

            var key = Encoding.ASCII.GetBytes(keyString);

            var tokenHandler = new JwtSecurityTokenHandler();
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, user.Id.ToString()),
                    new Claim(ClaimTypes.Role, role)
                }),
                Expires = DateTime.UtcNow.AddMinutes(Convert.ToInt32(_configuration["JwtSettings:DurationInMinutes"])),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }

        #endregion
    }
}
