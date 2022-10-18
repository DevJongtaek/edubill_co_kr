using System;
using System.IO;
using System.Text;

namespace Edubill.YoShin.Common
{
    /// <summary>
    /// Class1에 대한 요약 설명입니다.
    /// </summary>
    public class LogWriter
    {
        #region 생성자 및 Member변수(Singleton)
        //--------------------------------------------------------
        //region 생성자 및 Member변수(Singleton)
        //--------------------------------------------------------
        private static LogWriter instance = new LogWriter();

        private string _pathLog = "";
        private string _fileNamePrefix = "";
        private string _currentFileName = "";
        private long _maxFileSize = 0;

        private LogWriter()
        {
            // set default path
            string sDir = System.IO.Path.GetDirectoryName(
                                            System.Reflection.Assembly.GetExecutingAssembly().Location
                                                            );
            sDir += "\\log";
            this.pathLog = sDir;

            _fileNamePrefix = "RTLS";			    // default prefix
            maxFileSize = 4 * 1024 * 1024;			// default max size

        }

        public static LogWriter getInstance()
        {
            return instance;
        }
        #endregion

        #region Property 구현
        //--------------------------------------------------------
        //region Property 구현
        //--------------------------------------------------------
        public string pathLog
        {
            get { return _pathLog; }
            set
            {
                _pathLog = value;
                if(value != "")
                    System.IO.Directory.CreateDirectory(value);
            }
        }

        public string fileNamePrefix
        {
            get { return _fileNamePrefix; }
            set { _fileNamePrefix = value; }
        }

        public long maxFileSize
        {
            get { return _maxFileSize; }
            set { _maxFileSize = value; }
        }

        #endregion

        #region Method 구현
        //--------------------------------------------------------
        //region Method 구현
        //--------------------------------------------------------

        public bool writeLog(string logMessage, string logtype)
        {
            StringBuilder sbMsg = new StringBuilder();
            try
            {
                // FileName 검사
                if (_currentFileName == "" || getFileSize(_pathLog + "\\" + _currentFileName) > _maxFileSize)
                    _currentFileName = getLogFileName();

                StreamWriter sw = File.AppendText(_pathLog + "\\" + _currentFileName);

                sbMsg.Append("[" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "]");
                sbMsg.Append("[" + logtype + "]");
                sbMsg.Append(logMessage);
                sw.WriteLine(sbMsg.ToString());
                sw.Close();

                return true;
            }
            catch
            {
                return false;
            }
        }
        public bool writeLog(string logMessage)
        {
            return writeLog(logMessage, "info");
        }
        #endregion

        #region ETC
        //--------------------------------------------------------
        //region ETC
        //--------------------------------------------------------
        private string getLogFileName()
        {
            return _fileNamePrefix + DateTime.Now.ToString("yyyyMMddHHmmss") + ".log";
        }

        private long getFileSize(string fileName)
        {
            try
            {
                return new FileInfo(fileName).Length;
            }
            catch
            {
                return 0;
            }
        }
        #endregion
    }
}
