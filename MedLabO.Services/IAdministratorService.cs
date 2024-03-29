﻿using MedLabO.Models.Requests;
using MedLabO.Models.SearchObjects;

namespace MedLabO.Services
{
    public interface IAdministratorService : ICRUDService<Models.Administrator, AdministratorSearchObject, AdministratorInsertRequest, AdministratorUpdateRequest, Guid>
    {
        Task ChangePassword(ChangePasswordRequest request);
    }
}