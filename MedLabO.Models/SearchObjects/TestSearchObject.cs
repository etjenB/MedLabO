namespace MedLabO.Models.SearchObjects
{
    public class TestSearchObject : SearchObject
    {
        public string? Naziv { get; set; }
        public string? FTS { get; set; }
        public bool? IncludeAdministrator { get; set; }
        public bool? IncludeTestParametar { get; set; }
        public bool? IncludeRezultat { get; set; }
    }
}