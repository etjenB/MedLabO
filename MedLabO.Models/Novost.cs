namespace MedLabO.Models
{
    public class Novost
    {
        public string NovostID { get; set; }
        public string Naslov { get; set; }
        public string Sadrzaj { get; set; }
        public DateTime DTKreiranja { get; set; }
        public DateTime? DTZadnjeModifikacije { get; set; }
        public byte[] Slika { get; set; }
        public string? AdministratorID { get; set; }
        public virtual Administrator? Administrator { get; set; }
    }
}
