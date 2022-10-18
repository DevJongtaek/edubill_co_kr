<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->








<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>



<table width="520"  border="0" cellspacing="0" cellpadding="0">

<SCRIPT langauge=javascript>
<!--//
function btnQuery_onClick() {
	var f = document.form;
	var mobile = f.mobile.value;
	    
	if (mobile.length >= 0) {
		if (mobile.length != 11 && mobile.length != 10 ) {
			alert("핸드폰 번호를 제대로 입력해 주세요. 예) 0182223333 ('-' 빼고 입력) ");
			f.mobile.focus();
			return;
		}
	}
	
    f.submit();
}
//-->
</SCRIPT>
<FORM name="form" method="POST" action="SendSMS_save.asp">

  <tr>
    <td width="11"><img src="/adminpage/sms/s_left_top.gif" width="11" height="10"></td>
    <td background="/adminpage/sms/s_top_bu.gif"></td>
    <td width="11"><img src="/adminpage/sms/s_right_top.gif" width="11" height="10"></td>
  </tr>
  <tr>
    <td background="/adminpage/sms/s_left_bg.gif">&nbsp;</td>
    <td align="center"><table width="80%"  border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td><img src="/adminpage/sms/s_title.gif" width="145" height="48"></td>
      </tr>
      <tr>
        <td><table width="100%"  border="0" cellpadding="0" cellspacing="1" bgcolor="DEDFDE">
          <tr>
            <td height="70" align="center" bgcolor="FFFBFF">핸드폰 번호를 입력하세요 : 
              <input type="text" name="mobile"></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="50" align="center"><A href="javascript:btnQuery_onClick()"><img src="/adminpage/sms/s_bu.gif" width="52" height="21" border=0></a></td>
      </tr>
    </table></td>
    <td background="/adminpage/sms/s_right_bg.gif">&nbsp;</td>
  </tr>
  <tr>
    <td><img src="/adminpage/sms/s_left_bot.gif" width="11" height="10"></td>
    <td background="/adminpage/sms/s_bot_bg.gif"></td>
    <td><img src="/adminpage/sms/s_right_bot.gif" width="11" height="10"></td>
  </tr>
</form>
</table>



				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<BR><BR>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->