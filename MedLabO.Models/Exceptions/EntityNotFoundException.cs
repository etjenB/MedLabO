
namespace MedLabO.Models.Exceptions
{
    public class EntityNotFoundException : Exception
    {
        public EntityNotFoundException(string message = "Entitet nije pronađen.") : base(message)
        {

        }
    }
}
