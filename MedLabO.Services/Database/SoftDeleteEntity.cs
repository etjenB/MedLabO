
namespace MedLabO.Services.Database
{
    public abstract class SoftDeleteEntity
    {
        public bool isDeleted { get; set; } = false;
    }
}
