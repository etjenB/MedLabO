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
    static async Task Main(string[] args)
    {
        var services = new ServiceCollection();
        var configuration = LoadConfiguration();
        ConfigureServices(services, configuration);

        using (var serviceProvider = services.BuildServiceProvider())
        {
            var messageHandler = serviceProvider.GetService<MessageHandler>();
            var rabbitMQOptions = serviceProvider.GetService<IOptions<RabbitMQConfiguration>>().Value;
            var rabbitMQConnection = GetRabbitMQConnectionString(rabbitMQOptions);

            Console.WriteLine(rabbitMQConnection);

            await WaitForRabbitMQ(rabbitMQConnection);

            using (var bus = RabbitHutch.CreateBus(rabbitMQConnection))
            {
                await bus.PubSub.SubscribeAsync<TerminMail>("new_appointments", message => messageHandler.HandleMessage(message));
                Console.WriteLine("Listening for messages...");
                await Task.Delay(Timeout.Infinite);
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
        return $"host={rabbitMQOptions.HostName};" +
               $"virtualHost={rabbitMQOptions.VirtualHost};" +
               $"username={rabbitMQOptions.Username};" +
               $"password={rabbitMQOptions.Password}";
    }

    private static async Task WaitForRabbitMQ(string connectionString)
    {
        while (true)
        {
            try
            {
                using (var bus = RabbitHutch.CreateBus(connectionString))
                {
                    var queue = bus.Advanced.QueueDeclare("dummy_queue");
                    bus.Advanced.QueueDelete("dummy_queue");
                    break;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Failed to connect to RabbitMQ: {ex.Message}. Retrying in 2 seconds...");
                await Task.Delay(2000);
            }
        }
        Console.WriteLine("Connected to RabbitMQ.");
    }
}
