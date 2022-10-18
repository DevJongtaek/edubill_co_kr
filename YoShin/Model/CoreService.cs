using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using System.IO.Ports;
using System.Threading;
using System.Net.Sockets;

using Edubill.YoShin.Common;
using Edubill.YoShin.Common.DataBase;
using Edubill.YoShin.Common.ExceptionHandler;
using Edubill.YoShin.YoShinService.Configurations;
using Edubill.YoShin.YoShinService.Model.Sockets;

namespace Edubill.YoShin.YoShinService.Model
{
    public class CoreService
    {
        // �̺�Ʈ ����
        //-------------------------------------------------------------------------
        public delegate void ReceiveEventHandler(string IPAddr,string strPacket);
        public delegate void SendEventHandler(string IPAddr, string strPacket);
        public delegate void ConnectEventHandler(string IPAddr);
        public delegate void CloseEventHandler(string IPAddr);
        public delegate void MisuDataEventHandler(string mainCode, string subCode, long yoshin, long misu,bool apply);

        public event ReceiveEventHandler OnReceive;
        public event SendEventHandler OnSend;
        public event ConnectEventHandler OnConnect;
        public event CloseEventHandler OnClose;
        public event MisuDataEventHandler OnMisuData;
        //-------------------------------------------------------------------------
        
        // Listen Socket
        ListenSocket mListenSocket = new ListenSocket();

        private Collection<ClientSocket> mSockets = new Collection<ClientSocket>();
        
        public CoreService()
        {
            mListenSocket.OnAccept += new ListenSocket.AcceptEventHandler(mListenSocket_OnAccept);
            mListenSocket.OnError += new ListenSocket.ErrorEventHandler(mListenSocket_OnError);
        }

        void mListenSocket_OnError(Exception E)
        {
            
        }

        void mListenSocket_OnAccept(TcpClient tcpClient)
        {
            // Client Socket ����
            ClientSocket socket = new ClientSocket(this, tcpClient);

            // Accept�� �����ϸ� Array�� �߰�
            mSockets.Add(socket);

            if (OnConnect != null)
                OnConnect(socket.RemoteIP);
        }

        public bool Enabled
        {
            get { return mListenSocket.Enabled; }
            set
            {
                try
                {
                    mListenSocket.Enabled = value;
                    if (!value)
                    {
                        try
                        {
                            foreach (ClientSocket socket in mSockets)
                            {
                                socket.Close();
                            }
                            mSockets.Clear();
                        }
                        catch { }
                    }
                }
                catch (Exception E)
                {
                    ExceptionHandler.getInstance().ErrEvent(E);
                }
            }
        }

        public int ListenPort
        {
            get { return mListenSocket.ListenPort; }
            set 
            {
                mListenSocket.ListenPort = value;
            }
        }

        // Client�κ��� Data ���Ž�
        internal void ClientReceive(string IP, string strPacket)
        {
            if (OnReceive != null)
                OnReceive(IP,strPacket);
        }

        // Client�� Data �۽Ž�
        internal void ClientSend(string IP, string strPacket)
        {
            if (OnSend != null)
                OnSend(IP, strPacket);
        }

        // Client�� ������ Close �� ���,
        internal void ClientClose(ClientSocket socket)
        {
            string ipAddr = socket.RemoteIP;

            if (mSockets.Contains(socket))
            {
                mSockets.Remove(socket);

            }

            if (OnClose != null)
                OnClose(ipAddr);
        }

        // Client�� ������ Close �� ���,
        internal void ClientMisu(string mainCode,string subCode,long yoshin,long misu,bool apply)
        {
            if (OnMisuData != null)
                OnMisuData(mainCode, subCode, yoshin, misu, apply);
        }
    }
}
