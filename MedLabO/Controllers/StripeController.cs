using MedLabO.Models.Requests.Stripe;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Stripe;

namespace MedLabO.Controllers
{
    [Authorize]
    public class StripeController : ControllerBase
    {


        [HttpPost]
        [Route("CreatePaymentIntent")]
        public async Task<IActionResult> CreatePaymentIntent([FromBody] PaymentIntentCreateRequest request)
        {
            try
            {
                var paymentIntentService = new PaymentIntentService();
                var paymentIntent = await paymentIntentService.CreateAsync(new PaymentIntentCreateOptions
                {
                    Amount = request.Amount, // Amount in the smallest currency unit (e.g., 100 cents to charge $1.00)
                    Currency = "bam",
                                      // Add other options as needed, like receipt email, metadata, etc.
                });

                return Ok(new { ClientSecret = paymentIntent.ClientSecret });
            }
            catch (Exception e)
            {
                return BadRequest(new { error = e.Message });
            }
        }
    }
}
