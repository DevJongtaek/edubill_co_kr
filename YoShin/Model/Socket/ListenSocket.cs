//using System;
//using System.Collections.Generic;
//using System.Text;
//using rainiac.NetLib;
//using Edubill.YoShin.YoShinService.Model;

//namespace Edubill.YoShin.YoShinService.Model.Socket
//{
//    /// <summary>
//    /// Listen Socket�� ���� Class
//    /// Listen Socket�� �Ʒ��� ���� ���·� ���۵ȴ�.
//    /// </summary>
//    public class ListenSocket : rainiac.NetLib.Socket
//    {
//        public ListenSocket(CoreService coreService)
//        {
//            mCoreService = coreService;
//        }

//        // Event �߻� ��, Event �߻��� �˸� Main Class
//        private CoreService mCoreService;

//        // Connect ��û�� �߻�
//        protected override void OnAccept()
//        {
//            // Connect ��û��, Main Class���� �̸� �˷��� Main Class�� ó���ϵ��� ��
//            mCoreService.ClientAccept();
//        }
//    }
//}

using System;
using System.Collections.Generic;
using System.Text;
using System.Net;
using System.Net.Sockets;
using System.Threading;
using Edubill.YoShin.YoShinService.Model;

namespace Edubill.YoShin.YoShinService.Model.Sockets
{
    /// <summary>
    /// Listen Socket�� ���� Class
    /// Listen Socket�� �Ʒ��� ���� ���·� ���۵ȴ�.
    /// </summary>
    public class ListenSocket
    {
        TcpListener mListener = null;
        int mListenPort = 0;
        bool mEnabled = false;
        Thread thRun = null;

        public delegate void ErrorEventHandler(Exception E);
        public delegate void AcceptEventHandler(TcpClient tcpClient);

        public event ErrorEventHandler OnError;
        public event AcceptEventHandler OnAccept;

        public ListenSocket()
        {
        }

        public int ListenPort
        {
            get { return mListenPort; }
            set { mListenPort = value; }
        }

        public bool Enabled
        {
            get { return mEnabled; }
            set 
            {
                try
                {
                    if (value)
                    {
                        mListener = new TcpListener(IPAddress.Any,mListenPort);
                        thRun = new Thread(new ThreadStart(procListen));
                        thRun.Start();
                    }
                    else
                    {
                        try
                        {
                            thRun.Abort();
                        }
                        catch { }

                        if(mListener != null)
                            mListener.Stop();
                    }
                    mEnabled = value;
                }
                catch(Exception E)
                {
                    mEnabled = false;
                    if (OnError != null) OnError(E);
                }
            }
        }

        private void procListen()
        {
            try
            {
                mListener.Start(100);
                while (mEnabled)
                {
                    TcpClient tcpClient = mListener.AcceptTcpClient();
                    if (OnAccept != null)
                        OnAccept(tcpClient);
                }
            }
            catch (Exception E)
            { 
                mEnabled = false;
                if (OnError != null) OnError(E);
            }
        }
    }
}
