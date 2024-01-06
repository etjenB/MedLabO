
namespace MedLabO.Models.SearchObjects
{
    public class UslugaSearchObject : SearchObject
    {
        public string? Naziv { get; set; }
        public bool? IncludeTestovi { get; set; }
        public bool? IncludeAdministrator { get; set; }
    }
}
