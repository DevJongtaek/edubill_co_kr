using System;
using System.Collections.Generic;
using System.Text;

namespace Edubill.YoShin.Common.ExceptionHandler
{
    public class RTLSAppException : System.ApplicationException
    {
        public RTLSAppException(string message)
            : base(message)
        {
        }

        public RTLSAppException(string message,string detail)
            : base(message)
        {
            base.Data.Add("detail", detail);
        }
    }
}
