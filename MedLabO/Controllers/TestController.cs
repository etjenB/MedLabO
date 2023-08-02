﻿using MedLabO.Models;
using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;
using MedLabO.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Storage;

namespace MedLabO.Controllers
{
    [ApiController]
    public class TestController : BaseCRUDController<Models.Test, TestSearchObject, TestInsertRequest, TestUpdateRequest>
    {
        public TestController(ILogger<BaseController<Test, TestSearchObject>> logger, ITestService service) : base(logger, service)
        {
        }
    }
}