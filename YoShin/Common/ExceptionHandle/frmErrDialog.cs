using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace Nextronics.RTLS20.Common.ExceptionHandle
{
    public partial class frmErrDialog : Form
    {
        public frmErrDialog()
        {
            InitializeComponent();
        }

        private void btnDetail_Click(object sender, EventArgs e)
        {
            if (this.ClientSize.Height > (btnDetail.Location.Y + btnDetail.Size.Height + 15))
            {
                int height = (this.Size.Height - this.ClientSize.Height) + btnDetail.Top + btnDetail.Size.Height + 15;
                this.Size = new Size(this.Size.Width, height);
            }
            else
            {
                this.Size = new Size(this.Size.Width, 334);
            }
        }

        private void btnOK_Click(object sender, EventArgs e)
        {
            ExceptionHandler.getInstance().InitErrInfo();
            this.Close();
        }

        private void frmErrDialog_Load(object sender, EventArgs e)
        {
            lblErrorMessage.Text = ExceptionHandler.getInstance().raisedException.Message;
            txtDetail.Text = ExceptionHandler.getInstance().Detail;

            if (txtDetail.Text == "")
                txtDetail.Text = ExceptionHandler.getInstance().raisedException.StackTrace;


            btnDetail.Enabled = (txtDetail.Text != "") ? true : false;
        }
    }
}