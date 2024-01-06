
namespace MedLabO.Models.SearchObjects
{
    public class PacijentSearchObject : SoftDeleteSearchObject
    {
        public string? ImePrezime { get; set; }
        public bool? IncludeSpol { get; set; }
    }
}
