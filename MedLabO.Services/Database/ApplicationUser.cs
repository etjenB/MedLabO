using Microsoft.AspNetCore.Identity;

namespace MedLabO.Services.Database
{
    public class ApplicationUser : IdentityUser<Guid>
    {
        public bool isDeleted { get; set; } = false;
    }
}
