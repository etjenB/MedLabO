namespace MedLabO.Models.SearchObjects
{
    public class TerminSearchObject : SearchObject
    {
        public bool Obavljen { get; set; } = false;
        public bool IncludeTerminTestovi { get; set; } = false;
        public bool IncludeTerminUsluge { get; set; } = false;
        public bool IncludeTerminTestoviRezultati { get; set; } = false;
        public bool IncludeTerminUslugeTestovi { get; set; } = false;
        //public bool? IncludeAdministrator { get; set; }
        //public bool? IncludeTestParametar { get; set; }
        //public bool? IncludeRezultat { get; set; }
    }
}
