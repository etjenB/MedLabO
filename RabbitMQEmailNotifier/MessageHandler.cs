using MedLabO.Models.PublishingObjects;
using Microsoft.Extensions.Logging;

namespace RabbitMQEmailNotifier
{
    public class MessageHandler
    {
        private readonly EmailService _emailService;
        private readonly ILogger<MessageHandler> _logger;

        public MessageHandler(EmailService emailService, ILogger<MessageHandler> logger)
        {
            _emailService = emailService;
            _logger = logger;
        }

        public async Task HandleMessage(TerminMail terminMail)
        {
            _logger.LogInformation($"Mail za termin poslan: {terminMail.MailKorisnika}, {terminMail.DTTermina}");
            await _emailService.SendEmailAsync(terminMail.MailKorisnika, "MedLabO Uspješno zakazan termin", $"Poštovani {terminMail.ImeKorisnika} {terminMail.PrezimeKorisnika}, uspješno ste zakazali termin u laboratoriju na dan: {terminMail.DTTermina}. Hvala što koristite naše usluge.");
        }
    }
}
