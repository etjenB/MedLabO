using MedLabO.Models.Requests;
using MedLabO.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using MedLabO.Services;

namespace MedLabO.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly IAuthService _authService;

        public AuthController(IAuthService authService)
        {
            _authService = authService;
        }

        [HttpPost("Login")]
        public async Task<IActionResult> Login(LoginRequest request)
        {
            try
            {
                var token = await _authService.Login(request.Username, request.Password);
                if (!string.IsNullOrEmpty(token))
                {
                    return Ok(new { Token = token });
                }
                return BadRequest("Invalid login attempt.");
            }
            catch (UserException ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
