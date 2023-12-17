using Microsoft.Extensions.Options;
using System.Net.Mail;
using System.Net;
using RabbitMQEmailNotifier.ConfigurationModels;

namespace RabbitMQEmailNotifier
{
    public class EmailService : IEmailService
    {
        private readonly EmailConfiguration _emailOptions;

        public EmailService(IOptions<EmailConfiguration> emailOptions)
        {
            _emailOptions = emailOptions.Value;
        }

        public Task SendEmailAsync(string email, string subject, string message)
        {
            var client = new SmtpClient(_emailOptions.SmtpServer, _emailOptions.SmtpPort)
            {
                EnableSsl = true,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(_emailOptions.Email, _emailOptions.Password)
            };

            return client.SendMailAsync(
                new MailMessage(from: _emailOptions.Email,
                                to: email,
                                subject,
                                message
                                ));
        }
    }
}
