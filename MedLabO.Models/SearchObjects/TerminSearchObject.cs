namespace MedLabO.Models.SearchObjects
{
    public class TerminSearchObject : SearchObject
    {
        public string? FTS { get; set; }
        public bool Obavljen { get; set; } = false;
        public bool Finaliziran { get; set; } = false;
        public bool UObradi { get; set; } = false;
        public bool Odobren { get; set; } = false;
        public bool NaCekanju { get; set; } = false;
        public bool TerminiInFuture { get; set; } = false;
        public bool TerminiToday { get; set; } = false;
        public bool TerminiBefore { get; set; } = false; 
        public bool OrderByDTTermina { get; set; } = false;
        public bool IncludeTerminTestovi { get; set; } = false;
        public bool IncludeTerminUsluge { get; set; } = false;
        public bool IncludeTerminTestoviRezultati { get; set; } = false;
        public bool IncludeTerminTestoviTestovi { get; set; } = false;
        public bool IncludeTerminUslugeTestovi { get; set; } = false;
        public bool IncludeTerminPacijent { get; set; } = false;
        public bool IncludeTerminPacijentSpol { get; set; } = false;
        public bool IncludeTerminMedicinskoOsoblje { get; set; } = false;
        public bool IncludeTerminMedicinskoOsobljeZvanje { get; set; } = false;
        public bool IncludeTerminRacun { get; set; } = false;
        public bool IncludeTerminZakljucak { get; set; } = false;
    }
}
