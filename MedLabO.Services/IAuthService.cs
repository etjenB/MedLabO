using MedLabO.Models.Requests;

namespace MedLabO.Services
{
    public interface IAuthService
    {
        Task<string> Login(string username, string password);
        Task<string> PacijentRegistration(PacijentRegistrationRequest request);
    }
}
