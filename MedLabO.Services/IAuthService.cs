﻿namespace MedLabO.Services
{
    public interface IAuthService
    {
        Task<string> Login(string username, string password);
    }
}
