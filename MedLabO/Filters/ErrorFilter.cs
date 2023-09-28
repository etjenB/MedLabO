using MedLabO.Models.Exceptions;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System.Net;

namespace MedLabO.Filters
{
    public class ErrorFilter : ExceptionFilterAttribute
    {
        public override void OnException(ExceptionContext context)
        {
            switch (context.Exception)
            {
                case UserException:
                    context.ModelState.AddModelError("Error", context.Exception.Message);
                    context.HttpContext.Response.StatusCode = (int)HttpStatusCode.BadRequest;
                    break;
                case EntityNotFoundException:
                    context.ModelState.AddModelError("Error", context.Exception.Message);
                    context.HttpContext.Response.StatusCode = (int)HttpStatusCode.NotFound;
                    break;
                default:
                    context.ModelState.AddModelError("Error", "Server side error.");
                    context.HttpContext.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                    break;
            }

            var list = context.ModelState.Where(x => x.Value.Errors.Count() > 0)
                .ToDictionary(x => x.Key, y => y.Value.Errors.Select(z => z.ErrorMessage));

            context.Result = new JsonResult(new { errors = list });
        }
    }
}
