using MedLabO.Services;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

//Dependency injection za Usluga
builder.Services.AddTransient<IUslugaService, UslugaService>();

//Inject DbContext
//NuGet Potrebno Microsoft.EntityFrameworkCore.SqlServer
builder.Services.AddDbContext<MedLabOContext>(options =>
options.UseSqlServer(builder.Configuration.GetConnectionString("MedLabOContextConnectionString")));

//Dodavanje DefaultIdentity
//NuGet Potrebno Microsoft.AspNetCore.Identity.UI
builder.Services.AddDefaultIdentity<IdentityUser>()
    .AddRoles<IdentityRole>()
    .AddEntityFrameworkStores<MedLabOContext>();

//Odrediti kakav password je potreban
builder.Services.Configure<IdentityOptions>(options =>
{
    options.Password.RequireDigit = false;
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequireLowercase = false;
    options.Password.RequireUppercase = false;
    options.Password.RequiredLength = 4;
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
