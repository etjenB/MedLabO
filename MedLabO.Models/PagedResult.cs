namespace MedLabO.Models
{
    public class PagedResult<T>
    {
        public List<T> Result { get; set; }
        public int? Count { get; set; }
    }
}