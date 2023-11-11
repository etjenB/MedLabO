namespace MedLabO.Models.SearchObjects
{
    public class TerminSearchObject : SearchObject
    {
        public string? FTS { get; set; }
        public bool Obavljen { get; set; } = false;
        public bool IncludeTerminTestovi { get; set; } = false;
        public bool IncludeTerminUsluge { get; set; } = false;
        public bool IncludeTerminTestoviRezultati { get; set; } = false;
        public bool IncludeTerminTestoviTestovi { get; set; } = false;
        public bool IncludeTerminUslugeTestovi { get; set; } = false;
        public bool IncludeTerminPacijent { get; set; } = false;
        public bool IncludeTerminPacijentSpol { get; set; } = false;
        public bool IncludeTerminMedicinskoOsoblje { get; set; } = false;
        public bool IncludeTerminRacun { get; set; } = false;
        public bool IncludeTerminZakljucak { get; set; } = false;
    }
}
