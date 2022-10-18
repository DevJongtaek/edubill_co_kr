using System;
using System.Security.Permissions;
using Microsoft.Win32;
using System.IO;

[assembly: RegistryPermissionAttribute(SecurityAction.RequestMinimum, ViewAndModify = "HKEY_LOCAL_MACHINE")]
namespace Edubill.YoShin.YoShinService.Configurations
{
    [System.Xml.Serialization.XmlTypeAttribute(Namespace = "urn:Edubill:YoShin:Service:Manager")]
    public class GeneralConfiguration
    {
        private int mListenPort = 21101;
        private string mLogPath = "";
        private string mConnectionString = "UID=erp;PWD=65083642;DATABASE=edubill_co_kr;SERVER=61.98.130.211";

        [System.Xml.Serialization.XmlElementAttribute("LogPath", typeof(string))]
        public string LogPath
        {
            get
            {
                if (mLogPath == "") return mLogPath;

                try
                {
                    if (!File.Exists(mLogPath))
                        Directory.CreateDirectory(mLogPath);
                }
                catch { }

                return mLogPath;
            }
            set { mLogPath = value; }
        }

        [System.Xml.Serialization.XmlElementAttribute("ListenPort", typeof(int))]
        public int ListenPort
        {
            get { return mListenPort; }
            set { mListenPort = value; }
        }

        [System.Xml.Serialization.XmlElementAttribute("ConnectionString", typeof(string))]
        public string ConnectionString
        {
            get { return mConnectionString; }
            set { mConnectionString = value; }
        }

        public bool LoadFromRegistry()
        {
            string strTemp = "";
            RegistryKey edaRegistryKey = Registry.LocalMachine.CreateSubKey("Software").CreateSubKey("Edubill").CreateSubKey("YoShinService");

            // E134 :Data Collection Management에서 필요한 정보 설정 및 셋팅
            using (RegistryKey generalRegistryKey = edaRegistryKey.CreateSubKey("General"))
            {
                strTemp = (string)generalRegistryKey.GetValue("LogPath");
                if (strTemp != null)
                {
                    this.LogPath = strTemp;
                }

                if (generalRegistryKey.GetValue("ListenPort") != null)
                {
                    this.ListenPort = (int)generalRegistryKey.GetValue("ListenPort");
                }

                if (generalRegistryKey.GetValue("ConnectionString") != null)
                {
                    this.ConnectionString = (string)generalRegistryKey.GetValue("ConnectionString");
                }
            }

            return true;
        }

        public bool SaveToRegistry()
        {
            RegistryKey edaRegistryKey = Registry.LocalMachine.CreateSubKey("Software").CreateSubKey("Edubill").CreateSubKey("YoShinService");
            using (RegistryKey generalRegistryKey = edaRegistryKey.CreateSubKey("General"))
            {
                generalRegistryKey.SetValue("LogPath", this.LogPath);
                generalRegistryKey.SetValue("ListenPort", this.ListenPort);
                generalRegistryKey.SetValue("ConnectionString", this.ConnectionString);
            }

            return true;
        }
    }
}
