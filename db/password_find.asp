<!--#include virtual="/db/db.asp" -->
<%
	gubun = request("gubun")
	m_name = request("m_name")
	m_jumin = request("m_jumin")
	m_jumin = left(m_jumin,6)&"-"&right(m_jumin,7)
	m_email = request("m_email")

	select case gubun
		case "1"

			sql = "SELECT count(idx) FROM tb_member WHERE m_name = '"& m_name &"' and m_jumin = '"& m_jumin &"' and m_email = '"& m_email &"' "
			Set Rs = Db.Execute(sql)
			imsicount = rs(0)
			rs.close

			select case imsicount
				case 0
%>
					<script language="javascript">
						alert("�ش������� �����ϴ�.\n\n�ٽ� ��Ȯ�ϰ� �Է��Ͽ� �ֽʽÿ�.")
						history.go(-1);
					</script>
<%

				case 1

					sql = "SELECT m_id,m_pwd FROM tb_member WHERE m_name = '"& m_name &"' and m_jumin = '"& m_jumin &"' and m_email = '"& m_email &"' "
					Set Rs = Db.Execute(sql)
					imsim_id = rs(0)
					imsim_pwd = rs(1)
					rs.close


					set mailsend = server.CreateObject("cdonts.newmail")

html = "<html>"
html = html &" <head>"
html = html &" <title>::: �̸��Ͼȳ� :::</title>"
html = html &" </head>"
html = html &" <link href=http://www.tpsmall.co.kr/css/dog.css rel=stylesheet type=text/css>"
html = html &" <body bgcolor=ffffff>"
html = html &" <center>"
html = html &" <table width=632 border=0 cellpadding=0 cellspacing=0>"
html = html &" <tr>"
html = html &" <td height=3></td>"
html = html &" </tr>"
html = html &" </table>"
html = html &" <table width=632 border=0 cellpadding=0 cellspacing=0 bgcolor=#E4E4E4>"
html = html &" <tr>"
html = html &" <td height=50>&nbsp&nbsp<B><font color=#5A5A5A>::: COOLDICA.CO.KR ���̵� �� ��й�ȣ �ȳ��Դϴ�. :::</td>"
html = html &" </tr>"
html = html &" </table>"
html = html &" <table width=632 border=0 cellpadding=0 cellspacing=0>"
html = html &" <tr>"
html = html &" <td height=20></td>"
html = html &" </tr>"
html = html &" </table>"
html = html &" <table width=400 border=0 cellpadding=1 cellspacing=1 bgcolor=#5A5A5A>"
html = html &" <tr height=25>"
html = html &" <td width=150 align=center bgcolor=#E4E4E4>����</td>"
html = html &" <td width=250 bgcolor=white>&nbsp;"&m_name&"</td>"
html = html &" </tr>"
html = html &" <tr height=25>"
html = html &" <td align=center bgcolor=#E4E4E4>���̵�</td>"
html = html &" <td bgcolor=white>&nbsp;"&imsim_id&"</td>"
html = html &" </tr>"
html = html &" <tr height=25>"
html = html &" <td align=center bgcolor=#E4E4E4>��й�ȣ</td>"
html = html &" <td bgcolor=white>&nbsp;"&imsim_pwd&"</td>"
html = html &" </tr>"
html = html &" </table>"
html = html &" <table width=632 border=0 cellpadding=0 cellspacing=0>"
html = html &" <tr>"
html = html &" <td height=20></td>"
html = html &" </tr>"
html = html &" </table>"
html = html &" <table width=632 border=0 cellpadding=0 cellspacing=0 bgcolor=#E4E4E4>"
html = html &" <tr>"
html = html &" <td height=80><Br><font color=#5A5A5A>"
html = html &" &nbsp;&nbsp;&nbsp;�ּ� : ��⵵ �ǿս� ������ 100 ����� �������Ʈ 118�� 2003ȣ �ϲ�<BR>"
html = html &" &nbsp;&nbsp;&nbsp;���� ��ȭ : �� 02-000-0000   FAX : 02-000-0000<BR>"
html = html &" &nbsp;&nbsp;&nbsp;COOLDICA ��ǥ : �ƹ���<BR>"
html = html &" &nbsp;&nbsp;&nbsp;Copyright ��2003 COOLDICA All rights reserved.<BR>&nbsp;"
html = html &" </td>"
html = html &" </tr>"
html = html &" </table>"
html = html &" </body>"
html = html &" </html>"

					sendman= "cooldica@cooldica.co.kr"
					toman= m_email
					mailsend.From = sendman
					mailsend.To = toman
					mailsend.Subject = "COOLDICA���� ���̵� �� ��й�ȣ �ȳ� �����Դϴ�."
					Mailsend.BodyFormat = 0
					Mailsend.MailFormat = 0 
					mailsend.Body = html
					mailsend.Send
					set mailsend = nothing
%>

					<script language="javascript">
						alert("ȸ�����Խ� �Է��Ͻ� �̸��Ϸ� ��й�ȣ�� ������Ƚ��ϴ�.\nȮ���� ���ʽÿ�.")
						window.close();
					</script>

<%
			
			end select

		case ""
%>

<html>
<head>
<title>::: ���̵�&��й�ȣ ã�� :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../css/music_css.css" rel="stylesheet" type="text/css">
</head>

<script Language="JavaScript">
<!-- 
function checkValue() {
	if (form.m_name.value=="") {
		alert("�̸��� �Է��Ͽ� �ֽʽÿ�.") ;
		form.m_name.focus() ;
		return false ;
	} if (form.m_jumin.value=="") {
		alert("�ֹι�ȣ�� �Է��Ͽ� �ֽʽÿ�.") ;
		form.m_jumin.focus() ;
		return false ;
	} if (form.m_email.value=="") {
		alert("�̸����� �Է��Ͽ� �ֽʽÿ�.") ;
		form.m_email.focus() ;
		return false ;
	}
	form.submit() ;
	return false ;
}

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="300" height="200" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="50"><img src="/db/images/member_13.gif" width="300" height="50"></td>
  </tr>
  <tr> 
    <td height="126">
<table width="270" height="96" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#DEDEDE">

<form action=password_find.asp name=form method=post>
<input type=hidden name=gubun value="1">

        <tr> 
          <td bgcolor="#FFFFFF"><table width="276" height="96" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td width="80"><div align="right">�̸� : </div></td>
                <td width="196"> &nbsp; 
                  <input name="m_name" type="text" size="16" maxlength="16" style="background-color:#ffffff;border:1 solid #999999; width:130px"></td>
              </tr>
              <tr> 
                <td width="80"><div align="right">�ֹι�ȣ : </div></td>
                <td width="196">&nbsp; <input name="m_jumin" type="text" size="13" maxlength="13" style="background-color:#ffffff;border:1 solid #999999; width:130px"></td>
              </tr>
              <tr> 
                <td width="80"><div align="right">�̸����ּ� : </div></td>
                <td width="196">&nbsp; <input name="m_email" type="text" size="25" maxlength="50" style="background-color:#ffffff;border:1 solid #999999; width:180px"></td>
              </tr>
              <tr> 
                <td colspan="2"><div align="center"><input type=image src="/db/images/member_09.gif" width="71" height="21" border=0 onclick="javascript:return checkValue()"></div></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>

</form>

  <tr>
    <td height="24" bgcolor="#DEDEDE"><div align="center"><a href="javascript:window.close();"><img src="/db/images/member_06.gif" width="57" height="24" border="0"></a></div></td>
  </tr>
</table>
</body>
</html>

<%end select%>
