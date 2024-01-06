using MedLabO.Models.Enums;
using System.ComponentModel.DataAnnotations;

namespace MedLabO.Models.CustomAttributes
{
    public class GenderCheckAttribute : ValidationAttribute
    {
        public GenderCheckAttribute()
        {
            ErrorMessage = $"Spol ne postoji.";
        }

        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            if (value is int spolValue && Enum.IsDefined(typeof(SpolEnum), spolValue))
            {
                return ValidationResult.Success;
            }

            return new ValidationResult(ErrorMessage);
        }
    }
}
