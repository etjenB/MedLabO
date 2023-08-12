using MedLabO.Filters;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers(x =>
{
    x.Filters.Add<ErrorFilter>();
});

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

//Dependency injection
builder.Services.AddTransient<IAuthService, AuthService>();
builder.Services.AddTransient<IUslugaService, UslugaService>();
builder.Services.AddTransient<IAdministratorService, AdministratorService>();
builder.Services.AddTransient<ITestService, TestService>();
builder.Services.AddTransient<INovostService, NovostService>();
builder.Services.AddTransient<IObavijestService, ObavijestService>();

//builder.Services.AddTransient<ITestService, TestService>();
builder.Services.AddTransient<IService<MedLabO.Models.Test, TestSearchObject>, TestService>();

builder.Services.AddTransient<IService<MedLabO.Models.TestParametar, SearchObject>, Service<MedLabO.Models.TestParametar, MedLabO.Services.Database.TestParametar, SearchObject>>();

builder.Services.AddTransient<IService<MedLabO.Models.Administrator, AdministratorSearchObject>, AdministratorService>();

builder.Services.AddTransient<IService<MedLabO.Models.Termin, TerminSearchObject>, TerminService>();

builder.Services.AddTransient<IService<MedLabO.Models.Novost, NovostSearchObject>, NovostService>();

builder.Services.AddTransient<IService<MedLabO.Models.Obavijest, ObavijestSearchObject>, ObavijestService>();

//Inject DbContext
//NuGet Potrebno Microsoft.EntityFrameworkCore.SqlServer
builder.Services.AddDbContext<MedLabOContext>(options =>
options.UseSqlServer(builder.Configuration.GetConnectionString("MedLabOContextConnectionString")));

builder.Services.AddAutoMapper(typeof(IAdministratorService));

//Dodavanje DefaultIdentity
//NuGet Potrebno Microsoft.AspNetCore.Identity.UI
builder.Services.AddDefaultIdentity<ApplicationUser>()
    .AddRoles<IdentityRole<Guid>>()
    .AddEntityFrameworkStores<MedLabOContext>();

//Odrediti kakav password je potreban
builder.Services.Configure<IdentityOptions>(options =>
{
    options.Password.RequireDigit = true;
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequireLowercase = true;
    options.Password.RequireUppercase = true;
    options.Password.RequiredLength = 8;
});

// Add JWT Authentication
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = builder.Configuration["JwtSettings:Issuer"],
        ValidAudience = builder.Configuration["JwtSettings:Audience"],
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["JwtSettings:Key"]))
    };
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