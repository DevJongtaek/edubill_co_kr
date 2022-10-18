using System;
using System.Collections.Generic;
using System.Text;

using Edubill.YoShin.Common;
using Edubill.YoShin.Common.DataBase;
using Edubill.YoShin.Common.ExceptionHandler;
using Edubill.YoShin.YoShinService.Model;
using Edubill.YoShin.YoShinService.Configurations;

namespace Edubill.YoShin.YoShinService.DebugLoader
{
    public class ConsoleLoader
    {
        private Configuration mConfig = null;
        private CoreService mCore = new CoreService();

        public ConsoleLoader() : this(false)
        {

        }

        public ConsoleLoader(bool ignoreSerial)
        {
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

            mCore.ListenPort = mConfig.General.ListenPort;
            mCore.Enabled = true;
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("## Service Started");
            sb.AppendLine(" - MESSAGE : 여신서비스가 시작되었습니다.");
            sb.AppendLine(" - Listen Port : " + mCore.ListenPort);
            sb.AppendLine(" - Connection String : " + Configuration.getInstance().General.ConnectionString);
            sb.AppendLine(" - Lot Path : " + LogWriter.getInstance().pathLog);
            Console.WriteLine(sb.ToString());

            string cmd = "";
            while ((cmd = Console.ReadLine()) != "exit")
            {
            }
            mCore.Enabled = false;

            sb = new StringBuilder();
            sb.AppendLine("## Service Started");
            sb.AppendLine(" - MESSAGE : 여신서비스가 중지되었습니다.");
            Console.WriteLine(sb.ToString());
        }

        void mCore_OnSend(string IPAddr, string strPacket)
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("[" + DateTime.Now.ToString("MM/dd HH:mm:ss") + "] Send");
            sb.AppendLine(" - IP : " + IPAddr);
            sb.AppendLine(" - Data : " + strPacket);

            Console.WriteLine(sb.ToString());
        }

        void mCore_OnReceive(string IPAddr, string strPacket)
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("[" + DateTime.Now.ToString("MM/dd HH:mm:ss") + "] Receive");
            sb.AppendLine(" - IP : " + IPAddr);
            sb.AppendLine(" - Data : " + strPacket);

            Console.WriteLine(sb.ToString());
        }

        void mCore_OnMisuData(string mainCode, string subCode, long yoshin, long misu, bool apply)
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("[" + DateTime.Now.ToString("MM/dd HH:mm:ss") + "] 미수금 데이터");
            sb.AppendLine(" - 적용여부 : " + apply);
            sb.AppendLine(" - 업체코드 : " + mainCode);
            sb.AppendLine(" - 체인코드 : " + subCode);
            sb.AppendLine(" - 여신금액 : " + yoshin.ToString("#,##0"));
            sb.AppendLine(" - 미수금액 : " + misu.ToString("#,##0"));

            Console.WriteLine(sb.ToString());
        }

        void mCore_OnConnect(string IPAddr)
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("[" + DateTime.Now.ToString("MM/dd HH:mm:ss") + "] Connect EVENT ocured");
            sb.AppendLine(" - IP : " + IPAddr);

            Console.WriteLine(sb.ToString());
        }

        void mCore_OnClose(string IPAddr)
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("[" + DateTime.Now.ToString("MM/dd HH:mm:ss") + "] Close EVENT ocured");
            sb.AppendLine(" - IP : " + IPAddr);

            Console.WriteLine(sb.ToString());
        }

        void ConsoleLoader_OnError(Exception e, string detail)
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("[" + DateTime.Now.ToString("MM/dd HH:mm:ss") + "] ERROR ocured");
            sb.AppendLine(" - TYPE : ERROR");
            sb.AppendLine(" - MESSAGE : " + e.Message);
            if(detail != "" )
                sb.AppendLine(" - DETAIL : " + detail);
            else
                sb.AppendLine(" - STACK : " + e.StackTrace);

            Console.WriteLine(sb.ToString());
        }

        void ConsoleLoader_OnLogEvent(string type, string msg)
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("[" + DateTime.Now.ToString("MM/dd HH:mm:ss") + "] EVENT ocured");
            sb.AppendLine(" - TYPE : EVENT");
            sb.AppendLine(" - EVENT TYPE : " + type);
            sb.AppendLine(" - MESSAGE : " + msg);

            Console.WriteLine(sb.ToString());
        }
    }
}
