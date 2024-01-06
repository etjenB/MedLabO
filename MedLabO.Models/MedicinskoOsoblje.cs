
namespace MedLabO.Models
{
    public class MedicinskoOsoblje : ApplicationUser
    {
        public string? Ime { get; set; }
        public string? Prezime { get; set; }
        public bool IsActive { get; set; }
        public DateTime DTZaposlenja { get; set; }
        public DateTime? DTPrekidRadnogOdnosa { get; set; }
        public int? SpolID { get; set; }
        public virtual Spol? Spol { get; set; }
        public int? ZvanjeID { get; set; }
        public virtual Zvanje? Zvanje { get; set; }
    }
}
