<html>
<head>
<title>[에듀빌에 오신것을 환영합니다.]</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="css/dog.css" type="text/css">
</head>

<body topmargin="0" leftmargin="0" onLoad="login.mid.focus();">
<table width="800"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="22" align="right" valign="bottom"><table  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><a href="/"><img src="images/main/top_menu01.gif" width="62" height="17" border="0"></a></td>
        <td><a href="customer/customer03.asp"><img src="images/main/top_menu02.gif" width="91" height="17" border="0"></a></td>
        <td><a href="customer/customer08.asp"><img src="images/main/top_menu03.gif" width="75" height="17" border="0"></a></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="210" align="center" valign="top"><a href="/"><img src="images/main/logo.gif" width="118" height="53" border="0"></a></td>
        <td align="right"><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="603" height="71">
          <param name="movie" value="images/main/menu_top.swf">
          <param name="quality" value="high">
          <embed src="images/main/menu_top.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="603" height="71"></embed>
        </object></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="800" height="188">
      <param name="movie" value="images/main/main.swf">
      <param name="quality" value="high">
      <embed src="images/main/main.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="800" height="188"></embed>
    </object></td>
  </tr>
  <tr><td height="15"></td>
  </tr>
  <tr>
    <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="190" align="center"><table width="100"  border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td bgcolor="A5D7DE"><table width="172"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="images/main/mem_title.gif" width="172" height="43"></td>
              </tr>
              <tr>
                <td><table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">

<script language="JavaScript" type="text/JavaScript">
<!--
function logincheck() {
	if (login.mid.value=="") {
		alert("아이디를 입력하여 주시기바랍니다.") ;
		login.mid.focus() ;
		return false ;
	}if (login.mpwd.value=="") {
		alert("비밀번호를 입력하여 주시기바랍니다.") ;
		login.mpwd.focus() ;
		return false ;
	}
	login.submit() ;
	return false ;
}
//-->
</script>
<form action="/adminpage/loginok.asp" name=login onsubmit="return logincheck();">

                  <tr>
                    <td width="59"><img src="images/main/mem_id.gif" width="59" height="23"></td>
                    <td width="51">
<input type="text" name="mid" tabindex=1 style="BORDER-RIGHT: #999999 1px solid; BORDER-TOP: #999999 1px solid; BORDER-LEFT: #999999 1px solid; BORDER-BOTTOM: #999999 1px solid; HEIGHT: 18px; BACKGROUND-COLOR: #ffffff;width:64px;" maxlength=10></td>
                    <td width="62" rowspan="2" align="center"><input type=image tabindex=3 src="images/main/mem_login.gif" width="41" height="41" border=0></td>
                  </tr>
                  <tr>
                    <td><img src="images/main/mem_pw.gif" width="59" height="23"></td>
                    <td>
<input type="password" name="mpwd" tabindex=2 style="BORDER-RIGHT: #999999 1px solid; BORDER-TOP: #999999 1px solid; BORDER-LEFT: #999999 1px solid; BORDER-BOTTOM: #999999 1px solid; HEIGHT: 18px; BACKGROUND-COLOR: #ffffff;width:64px;" maxlength=10></td>
                    </tr>

</form>

                </table></td>
              </tr>
              <tr>
                <td height="13"><img src="images/main/login_bo.gif" width="172" height="13"></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td height="110"><img src="images/main/left_img.gif" width="172" height="84"></td>
          </tr>
          <tr>
            <td><img src="images/main/banner02.gif" width="172" height="45"></td>
          </tr>
          <tr>
            <td height=10></td>
          </tr>
        </table></td>
        <td valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="50%" valign=top><table width="95%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="images/main/notice_title.gif" width="100" height="20"></td>
                <td align="right"><a href="/bbs/list.asp?uid=gongi"><img src="images/main/more_bu.gif" width="31" height="10" border="0"></a></td>
              </tr>
              <tr bgcolor="ADC3C6"><td height="1" colspan="2"></td></tr>
              <tr><td height="10" colspan="2"></td></tr>

<!--#include virtual="/db/db.asp" -->
<%
	set rs = server.CreateObject("ADODB.Recordset")
	sql= "select top 5 * from tb_pds where uid='gongi' order by idx desc"
	rs.Open sql, Db, 1

	do until rs.eof
		if len(rs("title")) >= 18 then
			imsititle = left(rs("title"),16)&".."
		else
			imsititle = rs("title")
		end if
%>


              <tr>
                <td height="23" colspan="2" class=boardlist><img src="images/main/notice_f_icon.gif" width="3" height="5">&nbsp;<a href="/bbs/content.asp?uid=gongi&idx=<%=rs("idx")%>">[<%=left(rs("nows"),10)%>] <%=imsititle%></font></a></td>
              </tr>

<%
	rs.movenext
	loop
	rs.close
%>

              <tr>
                <td></td>
              </tr>
            </table></td>
            <td align="right" valign=top><table width="95%"  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="images/main/news_title.gif" width="77" height="20"></td>
                <td align="right"><a href="/bbs/list.asp?uid=news"><img src="images/main/more_bu.gif" width="31" height="10" border="0"></a></td>
              </tr>
              <tr bgcolor="ADC3C6">
                <td height="1" colspan="2"></td>
              </tr>
              <tr><td height="10" colspan="2"></td></tr>

<%
	set rs = server.CreateObject("ADODB.Recordset")
	sql= "select top 5 * from tb_pds where uid='news' order by idx desc"
	rs.Open sql, Db, 1

	do until rs.eof
		if len(rs("title")) >= 18 then
			imsititle = left(rs("title"),16)&".."
		else
			imsititle = rs("title")
		end if
%>

              <tr>
                <td height="23" colspan="2" class=boardlist><img src="images/main/notice_f_icon.gif" width="3" height="5">&nbsp;<a href="/bbs/content.asp?uid=news&idx=<%=rs("idx")%>">[<%=left(rs("nows"),10)%>] <%=imsititle%></a></td>
              </tr>

<%
	rs.movenext
	loop
	rs.close
%>


              <tr>
                <td></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td height="8" colspan="2"></td>
            </tr>
          <tr>
            <td><table  border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="124"><a href="/adminpage"><img src="images/main/quick_title.gif" width="124" height="106" border=0></a></td>
                <td width="88"><a href="customer/customer01.asp"><img src="images/main/quick_img01.gif" width="88" height="106" border="0"></a></td>
                <td><a href="customer/customer06.asp"><img src="images/main/quick_img02.gif" width="96" height="106" border="0"></a></td>
              </tr>
            </table></td>
            <td align="right"><img src="images/main/cus_img.gif" width="285" height="106"></td>
          </tr>
        </table></td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="1" bgcolor="E7E7E7"></td>
      </tr>
      <tr>
        <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="160" height="30">&nbsp;</td>
            <td width="48"><a href="customer/customer07.asp"><img src="images/main/bot_menu01.gif" width="48" height="14" border="0"></a></td>
            <td width="58"><a href="/service/service07.asp"><img src="images/main/bot_menu02.gif" width="58" height="14" border="0"></a></td>
            <td><a href="customer/customer03.asp"><img src="images/main/bot_menu04.gif" width="57" height="14" border="0"></a></td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td height="1" bgcolor="E7E7E7"></td>
      </tr>
      <tr>
        <td><table width="100%"  border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="160" align="right"><img src="images/main/bot_logo.gif" width="129" height="42"></td>
            <td height="55"><img src="images/main/bot_txt.gif" width="356" height="42"></td>
            <td align="right"><img src="images/main/banner01.gif" width="172" height="45"></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
