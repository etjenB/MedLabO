
namespace MedLabO.Models.SearchObjects
{
    public class SoftDeleteSearchObject : SearchObject
    {
        public bool IncludeSoftDeleted { get; set; } = false;
    }
}
