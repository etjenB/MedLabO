using MedLabO.Models.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
