using MedLabO.Models.Constants;
using MedLabO.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using MedLabO.Services.Database;
using Microsoft.Extensions.Configuration;

namespace MedLabO.Services
{
    public class AuthService : IAuthService
    {
        private UserManager<ApplicationUser> _userManager;
        private readonly IConfiguration _configuration;

        public AuthService(UserManager<ApplicationUser> userManager, IConfiguration configuration)
        {
            _userManager = userManager;
            _configuration = configuration;
        }

        public async Task<string> Login(string username, string password)
        {
            var user = await _userManager.FindByNameAsync(username);

            if (user == null || !await _userManager.CheckPasswordAsync(user, password))
            {
                throw new UserException("Invalid login attempt.");
            }

            var role = await DetermineUserRole(user);

            if (string.IsNullOrEmpty(role))
            {
                throw new UserException("User doesn't have a role.");
            }

            return GenerateToken(user, role);
        }

        private async Task<string> DetermineUserRole(ApplicationUser user)
        {
            var roles = await _userManager.GetRolesAsync(user);
            return roles.FirstOrDefault(r => RoleNames.AllRoles.Contains(r));
        }

        private string GenerateToken(ApplicationUser user, string role)
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

        //public async Task<string> Login(string username, string password)
        //{
        //    var user = await _userManager.FindByNameAsync(username);

        //    if (user != null && await _userManager.CheckPasswordAsync(user, password))
        //    {
        //        string Role = null;

        //        if (await _userManager.IsInRoleAsync(user, RoleNames.Administrator))
        //        {
        //            Role = RoleNames.Administrator;
        //        }else if(await _userManager.IsInRoleAsync(user, RoleNames.MedicinskoOsoblje))
        //        {
        //            Role = RoleNames.MedicinskoOsoblje;
        //        }else if (await _userManager.IsInRoleAsync(user, RoleNames.Pacijent))
        //        {
        //            Role = RoleNames.Pacijent;
        //        }

        //        if (Role!=null)
        //        {
        //            var tokenHandler = new JwtSecurityTokenHandler();
        //            var key = Encoding.ASCII.GetBytes(_configuration["JwtSettings:Key"]);
        //            var tokenDescriptor = new SecurityTokenDescriptor
        //            {
        //                Subject = new ClaimsIdentity(new Claim[]
        //                {
        //                    new Claim(ClaimTypes.Name, user.Id.ToString()),
        //                    new Claim(ClaimTypes.Role, Role)
        //                }),
        //                Expires = DateTime.UtcNow.AddMinutes(Convert.ToInt32(_configuration["JwtSettings:DurationInMinutes"])),
        //                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
        //            };
        //            var token = tokenHandler.CreateToken(tokenDescriptor);
        //            return tokenHandler.WriteToken(token);
        //        }
        //        else
        //        {
        //            throw new UserException("User doesn't have a role.");
        //        }
        //    }

        //    throw new UserException("Invalid login attempt.");
        //}
    }
}
