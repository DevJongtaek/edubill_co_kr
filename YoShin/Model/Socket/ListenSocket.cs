//using System;
//using System.Collections.Generic;
//using System.Text;
//using rainiac.NetLib;
//using Edubill.YoShin.YoShinService.Model;

//namespace Edubill.YoShin.YoShinService.Model.Socket
//{
//    /// <summary>
//    /// Listen Socket을 위한 Class
//    /// Listen Socket은 아래와 같은 형태로 제작된다.
//    /// </summary>
//    public class ListenSocket : rainiac.NetLib.Socket
//    {
//        public ListenSocket(CoreService coreService)
//        {
//            mCoreService = coreService;
//        }

//        // Event 발생 시, Event 발생을 알릴 Main Class
//        private CoreService mCoreService;

//        // Connect 요청시 발생
//        protected override void OnAccept()
//        {
//            // Connect 요청시, Main Class에게 이를 알려서 Main Class가 처리하도록 함
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
    /// Listen Socket을 위한 Class
    /// Listen Socket은 아래와 같은 형태로 제작된다.
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
