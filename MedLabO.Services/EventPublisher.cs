using EasyNetQ;

namespace MedLabO.Services
{
    public class EventPublisher : IEventPublisher
    {
        private readonly string _host = Environment.GetEnvironmentVariable("RABBITMQ_HOSTNAME") ?? "rabbitmq";
        private readonly string _username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest";
        private readonly string _password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest";
        private readonly string _virtualhost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

        public void PublishObject<T>(T obj)
        {
            try
            {
                var host = _host;
                var username = _username;
                var password = _password;
                var virtualhost = _virtualhost;
                Console.WriteLine($"host={host};virtualHost={virtualhost};username={username};password={password}");

                using var bus = RabbitHutch.CreateBus($"host={host};virtualHost={virtualhost};username={username};password={password}");
                bus.PubSub.Publish(obj);
                Console.WriteLine("Message published successfully.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error in publishing message: {ex.Message}");
            }
        }
    }
}
