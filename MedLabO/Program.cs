using MedLabO.Filters;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using MedLabO.Services.Database;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using Microsoft.OpenApi.Models;
using Stripe;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers(x =>
{
    x.Filters.Add<ErrorFilter>();
});

// Add HttpContextAccessor
builder.Services.AddHttpContextAccessor();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo { Title = "MedLabO API", Version = "v1" });

    // Begin - JWT Bearer token authentication setup
    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Description = "JWT Authorization header using the Bearer scheme. Enter 'Bearer' [space] and then your token in the text input below.",
        Name = "Authorization",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.ApiKey,
        Scheme = "Bearer"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
          new OpenApiSecurityScheme
          {
              Reference = new OpenApiReference
              {
                  Type = ReferenceType.SecurityScheme,
                  Id = "Bearer"
              }
          },
          new string[] {}
        }
    });
});

//Dependency injection
builder.Services.AddTransient<IAuthService, AuthService>();
builder.Services.AddTransient<IAdministratorService, AdministratorService>();
builder.Services.AddTransient<IMedicinskoOsobljeService, MedicinskoOsobljeService>();
builder.Services.AddTransient<IPacijentService, PacijentService>();
builder.Services.AddTransient<ITestService, TestService>();
builder.Services.AddTransient<ITestParametarService, TestParametarService>();
builder.Services.AddTransient<IUslugaService, UslugaService>();
builder.Services.AddTransient<ITerminService, TerminService>();
builder.Services.AddTransient<INovostService, NovostService>();
builder.Services.AddTransient<IObavijestService, ObavijestService>();
builder.Services.AddTransient<IRacunService, RacunService>();
builder.Services.AddTransient<IZakljucakService, ZakljucakService>();

//builder.Services.AddTransient<ITestService, TestService>();
builder.Services.AddTransient<IService<MedLabO.Models.Test.Test, TestSearchObject>, TestService>();

builder.Services.AddTransient<IService<MedLabO.Models.TestParametar, TestParametarSearchObject>, TestParametarService>();

builder.Services.AddTransient<IService<MedLabO.Models.Administrator, AdministratorSearchObject>, AdministratorService>();

builder.Services.AddTransient<IService<MedLabO.Models.MedicinskoOsoblje, MedicinskoOsobljeSearchObject>, MedicinskoOsobljeService>();

builder.Services.AddTransient<IService<MedLabO.Models.Pacijent.PacijentWithoutTermini, PacijentSearchObject>, PacijentService>();

builder.Services.AddTransient<IService<MedLabO.Models.Termin.Termin, TerminSearchObject>, TerminService>();

builder.Services.AddTransient<IService<MedLabO.Models.Novost, NovostSearchObject>, NovostService>();

builder.Services.AddTransient<IService<MedLabO.Models.Obavijest, ObavijestSearchObject>, ObavijestService>();

builder.Services.AddTransient<IService<MedLabO.Models.Usluga.Usluga, UslugaSearchObject>, UslugaService>();

builder.Services.AddTransient<IService<MedLabO.Models.Racun, RacunSearchObject>, RacunService>();

builder.Services.AddTransient<IService<MedLabO.Models.Zakljucak, ZakljucakSearchObject>, ZakljucakService>();

//Inject DbContext
//NuGet Potrebno Microsoft.EntityFrameworkCore.SqlServer
builder.Services.AddDbContext<MedLabOContext>(options =>
options.UseSqlServer(builder.Configuration.GetConnectionString("MedLabOContextConnectionString")));

builder.Services.AddAutoMapper(typeof(MappingProfile));

//Dodavanje DefaultIdentity
//NuGet Potrebno Microsoft.AspNetCore.Identity.UI
builder.Services.AddDefaultIdentity<ApplicationUser>()
    .AddRoles<IdentityRole<Guid>>()
    .AddEntityFrameworkStores<MedLabOContext>();

StripeConfiguration.ApiKey = builder.Configuration["Stripe:Key"];

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
        //For testing, if not testing ValidateIssuer and ValidateAudience should be set to true
        ValidateIssuer = false,
        ValidateAudience = false,
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

using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<MedLabOContext>();
    var conn = dataContext.Database.GetConnectionString();
    dataContext.Database.Migrate();
}

app.Run();