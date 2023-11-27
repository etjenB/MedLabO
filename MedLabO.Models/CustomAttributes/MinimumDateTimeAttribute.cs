using System.ComponentModel.DataAnnotations;

public class MinimumDateTimeAttribute : ValidationAttribute
{
    private readonly DateTime _minimumDateTime;

    public MinimumDateTimeAttribute(int year = 1900, int month = 1, int day = 1)
    {
        _minimumDateTime = new DateTime(year, month, day);
        ErrorMessage = $"Minimalni datum je '{_minimumDateTime:yyyy-MM-dd}'.";
    }

    protected override ValidationResult IsValid(object value, ValidationContext validationContext)
    {
        if (value is DateTime dateTimeValue && dateTimeValue >= _minimumDateTime)
        {
            return ValidationResult.Success;
        }
        else if (value == null)
        {
            return ValidationResult.Success;
        }

        return new ValidationResult(ErrorMessage);
    }
}
