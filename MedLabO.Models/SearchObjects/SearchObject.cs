namespace MedLabO.Models.SearchObjects
{
    public class SearchObject
    {
        public int? Page { get; set; }
        public int? PageSize { get; set; }
        public bool UseSplitQuery { get; set; } = false;
    }
}