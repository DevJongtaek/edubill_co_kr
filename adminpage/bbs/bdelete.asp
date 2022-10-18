<!--#include virtual="/adminpage/bbs/top.asp" -->
<!--#include virtual="/db/Noticedb.asp" -->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	GotoPage = Request("GotoPage")
	uid = request("uid")
	idx = request("idx")

  	tablename = " tb_rhdwltkgkf "

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT title,pwd FROM "& tablename &" where idx = "& idx
	rs.Open sql, noticedb, 1
	imsititle = rs(0)
	imsipwd = rs(1)
	rs.close
%>

<table width="744" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="right">&nbsp;</td>
	</tr>
	<tr>
		<td>

		<table width="744" border="0" cellspacing="0" cellpadding="0">
			<tr>
                          	<td height="300" colspan="3" valign=top >

<table width="573" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>	* 제목 : <%=imsititle%><br>
			* 이글을 삭제합니다. 비밀번호를 입력해 주십시요.
		</td>
	</tr>
</table>

<table width="573" border="0" cellspacing="0" cellpadding="0">

<script language="javascript">
<!--
function sendit() 
{
	if (eumsearch.pwd.value=="") {
		alert("Password을 입력하여 주시기바랍니다.") ;
		eumsearch.pwd.focus() ;
		return false ;
	}
	document.all("btn1").disabled = true;
	eumsearch.submit() ;
}
//-->
</script>

<form name="eumsearch" method="post" action="deleteok.asp" onsubmit="return sendit();">
<input type=hidden name=gotopage value="<%=gotopage%>">
<input type=hidden name=uid value="<%=uid%>">
<input type=hidden name=searcha value="<%=searcha%>">
<input type=hidden name=searchb value="<%=searchb%>">
<input type="hidden" name="idx" value="<%=Request("idx")%>">

  <tr> 
    <td colspan=3 height="1" bgcolor="#D2D6AE"></td>
  </tr>
  <tr> 
    <td width="100" height="31" align="right" bgcolor="#E9EDC1" class="write"><B>Password&nbsp;</td>
    <td width="100" bgcolor="#E9EDC1"><input name="pwd" value="<%if uid<>"agencyboard" then%>farm<%end if%>" maxlength=10 type="password" class="writebox" id="tittle" style='width:100px; height:19px;border:1px solid #AFAFAF;'></td>
    <td width="200" bgcolor="#E9EDC1"><input name=btn1 type=image src="/images/cus/del_ok.gif" alt="삭제" width="51" height="16" hspace=-3 border=0> 
    <a href="javascript:history.back();"><img src="/images/cus/del_can.gif" alt="돌아가기" width="67" height="16" border=0></a></td>
  </tr>
  <tr> 
    <td colspan=3 height="1" bgcolor="#D2D6AE"></td>
  </tr>

</form>

</table>


				</td>
			</tr>	
		</table>

		</td>
	</tr>
</table>

<!--#include virtual="/adminpage/bbs/bottom.asp" -->