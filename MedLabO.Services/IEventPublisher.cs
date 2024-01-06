
namespace MedLabO.Services
{
    public interface IEventPublisher
    {
        public void PublishObject<T>(T obj);
    }
}
