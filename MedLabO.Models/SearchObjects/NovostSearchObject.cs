namespace MedLabO.Models.SearchObjects
{
    public class NovostSearchObject : SearchObject
    {
        public string? Naslov { get; set; }
        public string? FTS { get; set; }
        public bool? IncludeAdministrator { get; set; }
    }
}
