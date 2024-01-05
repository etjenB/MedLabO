using MedLabO.Models.Requests;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using MedLabO.Services;
using MedLabO.Models.Exceptions;

namespace MedLabO.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly ILogger<AuthController> _logger;
        private readonly IAuthService _authService;

        public AuthController(IAuthService authService, ILogger<AuthController> logger)
        {
            _authService = authService;
            _logger = logger;
        }

        [HttpPost("Login")]
        public async Task<IActionResult> Login(LoginRequest request)
        {
            try
            {
                var token = await _authService.Login(request.Username, request.Password);
                if (!string.IsNullOrEmpty(token))
                {
                    _logger.LogInformation($"User {request.Username} logged in successfully.");
                    return Ok(new { Token = token });
                }

                _logger.LogWarning($"Login failed for user {request.Username}.");
                return BadRequest("Invalid login attempt.");
            }
            catch (UserException ex)
            {
                _logger.LogError(ex, $"Login failed for user {request.Username} with exception.");
                return BadRequest(ex.Message);
            }
        }

        [HttpPost("PacijentRegistration")]
        public async Task<IActionResult> PacijentRegistration(PacijentRegistrationRequest request)
        {
            try
            {
                var token = await _authService.PacijentRegistration(request);
                if (!string.IsNullOrEmpty(token))
                {
                    _logger.LogInformation($"New patient registered: {request.UserName}");
                    return Ok(new { Token = token });
                }

                _logger.LogWarning($"Registration failed for patient {request.UserName}.");
                return BadRequest("Invalid registration attempt.");
            }
            catch (UserException ex)
            {
                _logger.LogError(ex, $"Registration failed for patient {request.UserName} with exception.");
                return BadRequest(ex.Message);
            }
        }
    }
}
