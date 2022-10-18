using System;
using System.Collections.Generic;
using System.Text;

namespace Nextronics.RTLS20.Common.ExceptionHandle
{
    /// <summary>
    /// ErrorHandlerSingleton에 대한 요약 설명입니다.
    /// </summary>
    public class ExceptionHandler
    {
        #region 예외Class의 static 처리
        private static ExceptionHandler instance = new ExceptionHandler();

        public static ExceptionHandler getInstance()
        {
            return instance;
        }
        #endregion

        private struct errInfo
        {
            public string detail;
            public Exception e;
        }
        private errInfo err;

        public delegate void Error(Exception e, string detail);
        public event Error OnError;

        public void InitErrInfo()
        {
            err.e = null;
            err.detail = "";
        }

        public void ErrEvent(Exception e)
        {
            string strDetail = "";
            if (e.Data.Contains("detail"))
                strDetail = (string)e.Data["detail"];

            ErrEvent(e, strDetail);
        }

        public void ErrEvent(Exception e, string detail)
        {
            if (err.e == null)
            {
                err.e = e;
                err.detail = detail;
            }

            if (OnError != null) OnError(e, detail);
            InitErrInfo();
        }

        public Exception raisedException
        {
            get { return err.e; }
        }

        public string Detail
        {
            get { return err.detail; }
        }

        public void raiseError(string message)
        {
            raiseError(new RTLSAppException(message), "");
        }

        public void raiseError(Exception e)
        {
            raiseError(e, "");
        }

        public void raiseError(Exception e, string detail)
        {
            if (err.e == null)
            {
                err.e = e;
                err.detail = detail;
            }

            throw err.e;
        }

        public void saveError(Exception e)
        {
            string detail = "";

            if (e.Data.Contains("detail"))
                detail = (string)e.Data["detail"];
            
            saveError(e, detail);
        }

        public void saveError(Exception e, string detail)
        {
            if (err.e == null)
            {
                err.e = e;

                err.detail = detail;
            }
        }

        public void displayError(Exception e, string detail)
        {
            saveError(e, detail);
            displayError();
        }

        public void displayError(Exception e)
        {
            string detail = "";

            if (e.Data.Contains("detail"))
                detail = (string)e.Data["detail"];

            displayError(e, detail);
        }

        public void displayError()
        {
            frmErrDialog errorForm = new frmErrDialog();
            errorForm.ShowDialog();
        }
    }
}
