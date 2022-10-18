using System;
using System.Collections.Generic;
using System.Text;
using System.Net.Sockets;
using System.Net;
using System.Threading;
using Edubill.YoShin.YoShinService.Model;
using Edubill.YoShin.Common;
using Edubill.YoShin.Common.DataBase;
using Edubill.YoShin.Common.ExceptionHandler;
using Edubill.YoShin.YoShinService.Configurations;

namespace Edubill.YoShin.YoShinService.Model.Sockets
{
    public class ClientSocket
    {
        private TcpClient mTcpClient = null;
        private string mRemoteIP = "";
        private string mConnectionString = "";

        public const byte COMM_STX = 0x02;
        public const byte COMM_ETX = 0x03;

        public ClientSocket(CoreService coreService,TcpClient tcpClient)
        {
            mCoreService = coreService;
            mTcpClient = tcpClient;
            mConnectionString = Configuration.getInstance().General.ConnectionString;

            mRemoteIP = ((IPEndPoint)mTcpClient.Client.RemoteEndPoint).Address.ToString();

            Thread thRun = new Thread(new ThreadStart(Receive));
            thRun.Start();
        }

        // Event 발생 시, Event 발생을 알릴 Main Class
        private CoreService mCoreService;

        private string getString(byte[] buf, int size)
        {
            return Encoding.Default.GetString(buf, 0, size);
        }

        private byte[] getByteArray(string data)
        {
            return Encoding.Default.GetBytes(data);
        }

        public string RemoteIP
        {
            get { return mRemoteIP;}
        }

        // Receive 시
        protected void Receive()
        {
            // Receive시, Main Class에게 이를 알려서 Main Class가 처리하도록 함
            // Main Class는 다수의 Client Socket 객체를 관리하므로, 
            // 어떤 객체에서 발생한 Event인지 구별할 수 있도록 하기 위하여,
            // this를 Parameter로 전달
            //mCoreService.ClientReceive(this);

            // string 형식으로 추출
            byte[] buf = new byte[1024];
            StringBuilder sbBuf = new StringBuilder();
            NetworkStream ns = mTcpClient.GetStream();
            string strPacket = "";
            string ipAddr = "";
            int readByte = 0;

            try
            {
                ns.ReadTimeout = 30000;

                while ((readByte = ns.ReadByte()) >= 0)
                {
                    sbBuf.Append((char)readByte);

                    if (((byte)readByte) == COMM_ETX)
                        break;
                }
                strPacket = sbBuf.ToString();

                if (strPacket != "")
                {
                    // rcv Log
                    mCoreService.ClientReceive(mRemoteIP, strPacket);

                    CompareCommand(strPacket);
                }
            }
            catch (Exception E)
            {
                ExceptionHandler.getInstance().ErrEvent(E);
                if(mTcpClient.Connected)
                    SendResponse("002", "999");
            }
            finally
            {
                if (mTcpClient != null)
                {
                    this.Close();
                }
            }
        }

        private void CompareCommand(string strPacket)
        {
            if (strPacket == "") return;

            string cmdCode = "";
            string resCode = "";
            byte[] abPacket = Encoding.Default.GetBytes(strPacket);
            
            //STX체크
            if (abPacket[0] != COMM_STX)    
                resCode = "023";

            //ETX체크
            if (abPacket[abPacket.Length-1] != COMM_ETX)
                resCode = "024";

            //Length체크
            if (int.Parse(strPacket.Substring(1, 4)) != abPacket.Length)
                resCode = "022";

            cmdCode = strPacket.Substring(5, 3);

            if (resCode != "")
            {
                SendResponse(cmdCode.Substring(0, 2) + "2", resCode);
                return;
            }

            switch (cmdCode)
            {
                case "001":     //여신금입력
                    resCode = procCommand001(strPacket);
                    break;
                default:
                    resCode = "025";
                    break;
            }

            SendResponse(cmdCode.Substring(0, 2) + "2", resCode);
        }

        public void Close()
        {
            if (mTcpClient.Connected)
            {
                mTcpClient.GetStream().Flush();
                mTcpClient.GetStream().Close(100);
            }
            mTcpClient.Close();
            OnClose();
        }

        private string procCommand001(string strPacket)
        {
            string mainCode = "";
            string subCode = "";
            long YoShinMoney = 0;
            long MisuMoney = 0;
            string sql = "";
            string resCode = "000";
            bool apply = false;
            try
            {
                mainCode = strPacket.Substring(11, 20).Trim();
                subCode = strPacket.Substring(31, 20).Trim();
                YoShinMoney = long.Parse(strPacket.Substring(51, 12));
                MisuMoney = long.Parse(strPacket.Substring(63, 12));

                DbManager dbManager = new DbManager("MSSQL", mConnectionString);

                sql = "";
                sql += "\r\n SELECT a.idx,b.idx,a.myflag ";
                sql += "\r\n FROM tb_company a, tb_company b";
                sql += "\r\n WHERE a.idx = b.bidxsub";
                sql += "\r\n AND a.flag='1' ";
                sql += "\r\n AND b.flag = '3' ";
                sql += "\r\n AND a.tcode = '" + mainCode + "'";
                sql += "\r\n AND b.tcode = '" + subCode + "' ";
                sql += "\r\n AND a.myflag = 'y' ";

                string[,] rs = dbManager.GetRecordSet(sql);

                //데이터 없음
                if (rs != null)
                {
                    sql = "";
                    sql += "\r\n UPDATE tb_company ";
                    sql += "\r\n SET ye_money = " + YoShinMoney.ToString() + ", ";
                    sql += "\r\n     mi_money = " + MisuMoney.ToString() + " ";
                    sql += "\r\n WHERE idx = " + rs[1, 0];
                    apply = dbManager.DBExecute(sql);

                    if (!apply)
                        resCode = "999";
                }

                mCoreService.ClientMisu(mainCode, subCode, YoShinMoney, MisuMoney,apply);
                return resCode;
            }
            catch (Exception E)
            {
                ExceptionHandler.getInstance().ErrEvent(E);
                return "999";
            }
        }

        // Client Close 시
        protected void OnClose()
        {
            // Close시, Main Class에게 이를 알려서 Main Class가 처리하도록 함
            mCoreService.ClientClose(this);
        }

        private string fixedString(string target,int size)
        {
            if (target.Length > size)
                target = target.Remove(size);
            else if (target.Length < size)
                target = target.PadRight(size, ' ');

            return target;
        }

        private void SendResponse(string cmdCode, string resCode)
        {
            int packetLength = 0;
            StringBuilder sbSend = new StringBuilder();
            string strPacket = "";

            if (!mTcpClient.Connected) return;

            cmdCode = fixedString(cmdCode, 3);
            resCode = fixedString(resCode, 3);

            sbSend.Append((char)COMM_STX);
            sbSend.Append("0000");      //Length(나중에 계산);
            sbSend.Append(cmdCode);     //Command Code
            sbSend.Append(resCode);     //응답코드
            sbSend.Append((char)COMM_ETX);

            strPacket = sbSend.ToString();
            packetLength = getByteArray(strPacket).Length;
            strPacket = strPacket.Substring(0, 1) + packetLength.ToString("0000") + strPacket.Substring(5);

            NetworkStream ns = mTcpClient.GetStream();
            byte[] buf = getByteArray(strPacket);
            ns.Write(buf,0,buf.Length);
            ns.Flush();
            
            // send Log
            mCoreService.ClientSend(RemoteIP, strPacket);
        }
    }
}
