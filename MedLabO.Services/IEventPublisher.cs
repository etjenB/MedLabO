using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedLabO.Services
{
    public interface IEventPublisher
    {
        public void PublishObject<T>(T obj);
    }
}
