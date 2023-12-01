using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Models.Requests.Stripe
{
    public class PaymentIntentCreateRequest
    {
        public long Amount { get; set; }
    }
}
