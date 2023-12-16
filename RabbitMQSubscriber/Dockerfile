# Build stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["RabbitMQEmailNotifier.csproj", "./"]
RUN dotnet restore "RabbitMQEmailNotifier.csproj"
COPY . .
RUN dotnet publish "RabbitMQEmailNotifier.csproj" -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/runtime:6.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "RabbitMQEmailNotifier.dll"]
