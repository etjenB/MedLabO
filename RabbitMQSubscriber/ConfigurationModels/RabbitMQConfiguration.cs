
namespace RabbitMQEmailNotifier.ConfigurationModels
{
    public class RabbitMQConfiguration
    {
        public string HostName { get; set; }
        public string VirtualHost { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
    }
}
