using AutoMapper;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services.Database;
using Microsoft.Extensions.Logging;

namespace MedLabO.Services
{
    public class TestParametarService : CRUDService<Models.TestParametar, Database.TestParametar, TestParametarSearchObject, TestParametarInsertRequest, TestParametarUpdateRequest, Guid>, ITestParametarService
    {
        private readonly ILogger<TestParametarService> _logger;
        public TestParametarService(MedLabOContext db, IMapper mapper, ILogger<TestParametarService> logger) : base(db, mapper, logger)
        {
            _logger = logger;
        }
    }
}
