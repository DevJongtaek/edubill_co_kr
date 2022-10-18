using System;
using System.Collections.Generic;
using System.Text;

namespace Edubill.YoShin.Common
{
    public class LogEventer
    {
        #region ±¸Çö : Sinleton 
        //-------------------------------------------------
        private static LogEventer instance = new LogEventer();
        private LogEventer() { }
        public static LogEventer getInstance()
        {
            return instance;
        }
        //-------------------------------------------------
        #endregion

        public delegate void LogEvent_EventHandler(string type,string msg);
        public event LogEvent_EventHandler OnLogEvent;

        public void LogEvent(string type,string msg)
        {
            if (OnLogEvent != null)
                OnLogEvent(type,msg);
        }
    }
}
