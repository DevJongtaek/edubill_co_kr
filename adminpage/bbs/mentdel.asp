<!--#include virtual="/include/top.asp" -->
<!--#include virtual="/db/db.asp" -->

<%
	midx = request("midx")
	searcha = request("searcha")
	searchb = request("searchb")
	GotoPage = Request("GotoPage")
	uid = request("uid")
	idx = request("idx")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT username,pwd FROM tb_ment where midx = "& midx
	rs.Open sql, db, 1
	imsiusername = rs(0)
	imsipwd = rs(1)
	rs.close
	select case  uid
		case "customer"
			imsibbstitle = "����Ÿ"
		case "dicaqna"
			imsibbstitle = "��ī Q&A"
		case "info"
			imsibbstitle = "��������"
		case "old"
			imsibbstitle = "�߰�Ÿ�"
		case "gbbs"
			imsibbstitle = "������"
		case "sbbs"
			imsibbstitle = "���û���"
	end select

%>

<table width="100%" border=0 cellpadding="0" cellspacing="0">
	<tr height="30">
		<td>&nbsp;
			<img src="/images/btn_m.gif">&nbsp; <a href="/">HOME</a> > <B><%=imsibbstitle%>
		</td>
	</tr>
	<tr height="1">
		<td background="/images/menubg.gif"></td>
	</tr>
	<tr height="20">
		<td></td>
	</tr>
</table>

<table width="400" height="100%" border="0" cellpadding="0" cellspacing="0" class="unnamed2" align=center>
	<tr> 
		<td align=center>

<table width="573" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>	* �ۼ��� : <%=imsiusername%><br>
			* �̱��� �����մϴ�. ��й�ȣ�� �Է��� �ֽʽÿ�.
		</td>
	</tr>
</table>

<table width="573" border="0" cellspacing="0" cellpadding="0">

<script language="javascript">
<!--
function sendit() 
{
	if (eumsearch.pwd.value=="") {
		alert("Password�� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		eumsearch.pwd.focus() ;
		return false ;
	}
	document.all("btn1").disabled = true;
	eumsearch.submit() ;
}
//-->
</script>

<form name="eumsearch" method="post" action="deleteok2.asp" onsubmit="return sendit();">
<input type=hidden name=gotopage value="<%=gotopage%>">
<input type=hidden name=uid value="<%=uid%>">
<input type=hidden name=searcha value="<%=searcha%>">
<input type=hidden name=searchb value="<%=searchb%>">
<input type="hidden" name="idx" value="<%=Request("idx")%>">
<input type="hidden" name="midx" value="<%=Request("midx")%>">

  <tr> 
    <td colspan=3 height="1" bgcolor="#B7B7B7"></td>
  </tr>
  <tr> 
    <td width="100" height="31" align="right" bgcolor="#E8E8E8" class="write"><B>Password&nbsp;</td>
    <td width="100" bgcolor="#E8E8E8"><input name="pwd" maxlength=10 type="password" class="writebox" id="tittle" style='width:100px; height:19px;border:1px solid #AFAFAF;' <%if session("Auserid")<>"" then%>value="<%=imsipwd%>"<%end if%>></td>
    <td width="200" bgcolor="#E8E8E8"><input type=image src="/images/board/bt_del.gif" border=0 hspace=-3 name=btn1></td>
  </tr>
  <tr> 
    <td colspan=3 height="1" bgcolor="#B7B7B7"></td>
  </tr>

</form>

</table>

		</td>
	</tr>
</table>

<!--#include virtual="/include/bottom.asp" -->