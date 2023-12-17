using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RabbitMQEmailNotifier.ConfigurationModels
{
    public class EmailConfiguration
    {
        public string Email { get; set; }
        public string Password { get; set; }
        public string SmtpServer { get; set; }
        public int SmtpPort { get; set; }
    }
}
