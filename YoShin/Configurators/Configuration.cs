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
        /// �⺻ �������Դϴ�.
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
        /// ������Ʈ���κ��� �����͸� �о���ų� �ʱ�ȭ�մϴ�.
        /// </summary>
        public bool LoadFromRegistry()
        {
            if (!this.General.LoadFromRegistry()) return false;

            return true;
        }

        /// <summary>
        /// Ŭ������ ������ ������ ������Ʈ���� �ݿ��մϴ�.
        /// </summary>
        public bool SaveToRegistry()
        {
            if (!this.General.SaveToRegistry()) return false;

            return true;
        }
    }
}
