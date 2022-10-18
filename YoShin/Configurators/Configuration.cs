using System;
using System.Collections.Generic;
using System.Text;
using System.Security.Permissions;
using Microsoft.Win32;

[assembly: RegistryPermissionAttribute(SecurityAction.RequestMinimum, ViewAndModify = "HKEY_LOCAL_MACHINE")]
namespace Edubill.YoShin.YoShinService.Configurations
{
    [System.Xml.Serialization.XmlTypeAttribute(Namespace = "urn:Edubill:YoShin:Service:Manager")]
    public class Configuration
    {
        private GeneralConfiguration mGeneral;
        private static Configuration instance = new Configuration();

        /// <summary>
        /// 기본 생성자입니다.
        /// </summary>
        private Configuration()
        {
            this.General = new GeneralConfiguration();
            LoadFromRegistry();
        }

        public static Configuration getInstance()
        {
            return instance;
        }

        [System.Xml.Serialization.XmlElementAttribute("General", typeof(GeneralConfiguration))]
        public GeneralConfiguration General
        {
            get
            {
                return mGeneral;
            }
            set
            {
                mGeneral = value;
            }
        }

        /// <summary>
        /// 레지스트리로부터 데이터를 읽어오거나 초기화합니다.
        /// </summary>
        public bool LoadFromRegistry()
        {
            if (!this.General.LoadFromRegistry()) return false;

            return true;
        }

        /// <summary>
        /// 클래스에 설정된 정보를 레지스트리에 반영합니다.
        /// </summary>
        public bool SaveToRegistry()
        {
            if (!this.General.SaveToRegistry()) return false;

            return true;
        }
    }
}
