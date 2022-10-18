using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.ServiceProcess;
using System.Text;

using Edubill.YoShin.Common;
using Edubill.YoShin.Common.DataBase;
using Edubill.YoShin.Common.ExceptionHandler;
using Edubill.YoShin.YoShinService.Configurations;
using Edubill.YoShin.YoShinService.Model;

namespace Edubill.YoShin.YoShinService
{
    public partial class ServiceLoader : ServiceBase
    {
        private Configuration mConfig = null;
        private CoreService mCore = new CoreService();

        public ServiceLoader()
        {
            InitializeComponent();

            mConfig = Configuration.getInstance();
            mConfig.LoadFromRegistry();
            mConfig.SaveToRegistry();

            //---------------------------------------------------------------------------------------------
            //EVENT MAPPING
            //---------------------------------------------------------------------------------------------
            mCore.OnClose += new CoreService.CloseEventHandler(mCore_OnClose);
            mCore.OnConnect += new CoreService.ConnectEventHandler(mCore_OnConnect);
            mCore.OnMisuData += new CoreService.MisuDataEventHandler(mCore_OnMisuData);
            mCore.OnReceive += new CoreService.ReceiveEventHandler(mCore_OnReceive);
            mCore.OnSend += new CoreService.SendEventHandler(mCore_OnSend);
            ExceptionHandler.getInstance().OnError += new ExceptionHandler.Error(ConsoleLoader_OnError);
            LogEventer.getInstance().OnLogEvent += new LogEventer.LogEvent_EventHandler(ConsoleLoader_OnLogEvent);

            LogEventer.getInstance().OnLogEvent += new LogEventer.LogEvent_EventHandler(ConsoleLoader_OnLogEvent);

            mCore.ListenPort = mConfig.General.ListenPort;

            LogWriter.getInstance().pathLog = mConfig.General.LogPath;
            LogWriter.getInstance().fileNamePrefix = "YoShinService";
        }

        void mCore_OnSend(string IPAddr, string strPacket)
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("## Packet Sended");
            sb.AppendLine(" - TYPE : INFOMATION");
            sb.AppendLine(" - IP : " + IPAddr);
            sb.AppendLine(" - PACKET : " + strPacket);

            LogWriter.getInstance().writeLog(sb.ToString(), "EVENT");
        }

        void mCore_OnReceive(string IPAddr, string strPacket)
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("## Packet Received");
            sb.AppendLine(" - TYPE : INFOMATION");
            sb.AppendLine(" - IP : " + IPAddr);
            sb.AppendLine(" - PACKET : " + strPacket);

            LogWriter.getInstance().writeLog(sb.ToString(), "EVENT");
        }

        void mCore_OnMisuData(string mainCode, string subCode, long yoshin, long misu, bool apply)
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("## 미수금정보");
            sb.AppendLine(" - TYPE : INFOMATION");
            sb.AppendLine(" - 적용여부 : " + apply);
            sb.AppendLine(" - 업체코드 : " + mainCode);
            sb.AppendLine(" - 체인코드 : " + subCode);
            sb.AppendLine(" - 여신금액 : " + yoshin.ToString("#,##0"));
            sb.AppendLine(" - 미수금액 : " + misu.ToString("#,##0"));

            LogWriter.getInstance().writeLog(sb.ToString(), "EVENT");
        }

        void mCore_OnConnect(string IPAddr)
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("## Client Connected");
            sb.AppendLine(" - TYPE : INFOMATION");
            sb.AppendLine(" - IP : " + IPAddr);

            LogWriter.getInstance().writeLog(sb.ToString(), "EVENT");
        }

        void mCore_OnClose(string IPAddr)
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("## Connection Close");
            sb.AppendLine(" - TYPE : INFOMATION");
            sb.AppendLine(" - IP : " + IPAddr);

            LogWriter.getInstance().writeLog(sb.ToString(), "EVENT");
        }

        protected override void OnStart(string[] args)
        {
            mCore.Enabled = true;

            StringBuilder sb = new StringBuilder();

            sb.AppendLine("## Service Started");
            sb.AppendLine(" - MESSAGE : 여신서비스가 시작되었습니다.");
            sb.AppendLine(" - Listen Port : " + mCore.ListenPort);
            sb.AppendLine(" - Connection String : " + Configuration.getInstance().General.ConnectionString);
            sb.AppendLine(" - Lot Path : " + LogWriter.getInstance().pathLog);

            LogWriter.getInstance().writeLog(sb.ToString());
        }

        protected override void OnStop()
        {
            mCore.Enabled = false;

            StringBuilder sb = new StringBuilder();

            sb.AppendLine("## Service Started");
            sb.AppendLine(" - MESSAGE : 여신서비스가 중지되었습니다.");

            LogWriter.getInstance().writeLog(sb.ToString());
        }

        void ConsoleLoader_OnError(Exception e, string detail)
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("## ERROR ocured");
            sb.AppendLine(" - TYPE : ERROR");
            sb.AppendLine(" - MESSAGE : " + e.Message);
            if (detail != "")
                sb.AppendLine(" - DETAIL : " + detail);
            else
                sb.AppendLine(" - STACK : " + e.StackTrace);

            LogWriter.getInstance().writeLog(sb.ToString(),"ERROR");
        }

        void ConsoleLoader_OnLogEvent(string type, string msg)
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("## EVENT ocured");
            sb.AppendLine(" - TYPE : EVENT");
            sb.AppendLine(" - EVENT TYPE : " + type);
            sb.AppendLine(" - MESSAGE : " + msg);

            LogWriter.getInstance().writeLog(sb.ToString());
        }
    }
}
