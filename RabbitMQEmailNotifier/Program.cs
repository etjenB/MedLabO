using EasyNetQ;
using MedLabO.Models.PublishingObjects;
using RabbitMQEmailNotifier;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration;
using RabbitMQEmailNotifier.ConfigurationModels;
using System;
using System.IO;
using Microsoft.Extensions.Options;

class Program
{
    static void Main(string[] args)
    {
        var services = new ServiceCollection();
        var configuration = LoadConfiguration();
        ConfigureServices(services, configuration);

        using (var serviceProvider = services.BuildServiceProvider())
        {
            var messageHandler = serviceProvider.GetService<MessageHandler>();
            var rabbitMQOptions = serviceProvider.GetService<IOptions<RabbitMQConfiguration>>().Value;

            var rabbitMQConnection = GetRabbitMQConnectionString(rabbitMQOptions);

            using (var bus = RabbitHutch.CreateBus(rabbitMQConnection))
            {
                bus.PubSub.Subscribe<TerminMail>("new_appointments", message => messageHandler.HandleMessage(message).Wait());
                Console.WriteLine("Slušam poruke...");
                Console.ReadLine();
            }
        }
    }

    private static void ConfigureServices(IServiceCollection services, IConfiguration configuration)
    {
        services.AddLogging(configure => configure.AddConsole());

        services.Configure<EmailConfiguration>(configuration.GetSection("Outlook"));
        services.AddTransient<EmailService>();
        services.AddTransient<MessageHandler>();

        services.Configure<RabbitMQConfiguration>(configuration.GetSection("RabbitMQ"));
    }

    private static IConfiguration LoadConfiguration()
    {
        return new ConfigurationBuilder()
            .SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
            .AddEnvironmentVariables()
            .Build();
    }

    private static string GetRabbitMQConnectionString(RabbitMQConfiguration rabbitMQOptions)
    {
        return $"host={rabbitMQOptions.Host};" +
               $"virtualHost={rabbitMQOptions.VirtualHost};" +
               $"username={rabbitMQOptions.Username};" +
               $"password={rabbitMQOptions.Password}";
    }
}
