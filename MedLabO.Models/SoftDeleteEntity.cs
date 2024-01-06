
namespace MedLabO.Models
{
    public abstract class SoftDeleteEntity
    {
        public bool isDeleted { get; set; } = false;
    }
}
