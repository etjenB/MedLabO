using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
