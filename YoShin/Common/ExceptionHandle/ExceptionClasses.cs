using System;
using System.Collections.Generic;
using System.Text;

namespace Nextronics.RTLS20.Common.ExceptionHandle
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
