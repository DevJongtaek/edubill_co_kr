<!--#include virtual="/adminpage/incfile/mtop2.asp"-->
<script Language="JavaScript">
<!-- 
function checkValue222() {
	if (form.order_cmt.value=="") {
		alert("남기고 싶은 말을 입력하여 주시기바랍니다.") ;
		form.order_cmt.focus() ;
		return false ;
	}
	form.submit() ;
	return false ;
}

function pop_win(){
	popWindow.style.display="none";
}
function pop_win2(){
	popWindow2.style.display="none";
}
//-->
</script>

		<table width="310" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">

<form action="commentok.asp" name=form method=post onsubmit="return checkValue222(this.form);">

			<tr height="47">
				<td>

<!--#include virtual="/db/db.asp" -->
<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	gongi = request("gongi")
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select brandflag,brandbox,isnull(com_notice,''),isnull(chk_gongi1,''),isnull(chk_gongi2,''),tcode,proflag2,noticeflag,conSeeflag,yesin_memo "
	SQL = SQL & " from tb_company "
	SQL = SQL & " where idx = '"& left(session("AAusercode"),5) &"' "
	rs.Open sql, db, 1
	imsibrandflag  = rs(0)
	imsibrandbox   = rs(1)
	imsicom_notice = rs(2)
	imsicom_notice = Replace(imsicom_notice,chr(13),"<br>")
	imsichk_gongi1 = Replace(rs(3),chr(13),"<br>")
	imsichk_gongi2 = Replace(rs(4),chr(13),"<br>")
	imsitcode = rs(5)
	proflag2 = rs(6)
	noticeflag = rs(7)	'1:체인점2:지사a:전체
	conSeeflag = rs(8)
	yesin_memo = rs(9)  '2011.04.12 여신메모 visible
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select cbrandchoice,isnull(ch_gongi,''),orderflag "
	SQL = SQL & " from tb_company "
	SQL = SQL & " where idx = '"& right(session("AAusercode"),5) &"' "
	rs.Open sql, db, 1
	imsicbrandchoice = replace(rs(0)," ","")
	imsich_gongi = Replace(rs(1),chr(13),"<br>")
	flagorderflag = rs(2)
	rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select tel1,tel2,tel3 from tb_company where idx = "& left(session("AAusercode"),5) &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imistel1 = rs(0)
		imistel2 = rs(1)
		imistel3 = rs(2)
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select mi_money,ye_money,virtual_acnt,virtual_acnt_bank from tb_company where idx = "& right(session("AAusercode"),5) &" "
	rs.Open sql, db, 1
	if not rs.eof then
		mi_money = rs(0)
		ye_money = rs(1)
		virtual_acnt = rs(2)
		virtual_acnt_bank = rs(3)
	end if
	rs.close
%>

<table width=310 border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 외상한도금액 및 미수금액 내역 ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width=310 border=0 bgcolor=#BDCBE7>
	<tr bgcolor=white height=22 align=left>
		<td colspan=2 height=100>

<%if mi_money > ye_money then%><font color=red><%end if%>
	&nbsp;  <b>미수금액</b>이 <b>외상한도금액</b>을 초과하여 주문을 하실 수 없습니다.<BR>
	&nbsp;  체인본부(물류센터)에서 지정한 '계좌번호' 혹은 '가상계좌'로 입금하신 후, 다시 주문 바랍니다.<font color=blue>( 문의사항 : <%=imistel1%>-<%=imistel2%>-<%=imistel3%> )</font> <BR>
<%if mi_money > ye_money then%></font><%end if%>
	&nbsp;&nbsp;&nbsp; * 가상계좌번호 : <%=virtual_acnt_bank%>은행 - <%=virtual_acnt%><BR>
<%if ye_money >= 0 then%>
	&nbsp;&nbsp;&nbsp; * 외상한도금액 : \<%=mid(FormatCurrency(ye_money),2)%> 원<BR>
<%else%>
	&nbsp;&nbsp;&nbsp; * 외상한도금액 : \-<%=mid(FormatCurrency(ye_money),3)%> 원<BR>
<%end if%>

<%if mi_money >= 0 then%>
	&nbsp;&nbsp;&nbsp; * -총-미수금액 : \<%=mid(FormatCurrency(mi_money),2)%> 원<BR>
<%else%>
	&nbsp;&nbsp;&nbsp; * -총-미수금액 : \-<%=mid(FormatCurrency(mi_money),3)%> 원<BR>
<%end if%>

		</td>
	</tr>
	<%If yesin_memo = "y" Then %>
	<tr bgcolor=#F7F7FF height=22 align=left>
		<td width=20% align=center><font color=red>*</font><B>남기고<br>싶은말</td>
		<td width=80% bgcolor=white height=100>
			<textarea name="order_cmt" style="width:100%;height:100%;BORDER-RIGHT: #BDBEBD 1px solid; BORDER-TOP: #BDBEBD 1px solid; BORDER-LEFT: #BDBEBD 1px solid; BORDER-BOTTOM: #BDBEBD 1px solid"></textarea>
		</td>
	</tr>
	<%End If%>
</table>

<table width=310  border="0" cellspacing="0" cellpadding="0">
	<tr>
              	<td>&nbsp;<font color=blue><B>☞ 반드시 "등록" 버튼을 누르셔야만 주문이 완료 됩니다.!!</td>
	</tr>
	<tr>
              	<td align=center height=35>
			<%if conSeeflag="y" and yesin_memo = "y" then%><input type="image" src="/images/admin/l_bu01.gif" border=0><%end if%>
			<a href="#" onclick="javascript:window.close();"><img src="/images/admin/l_bu07.gif" border=0></a>
		</td>
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

<%if request("popnot")="" then%>
<%if gongi="1" and imsicom_notice<>"" and (noticeflag="1" or noticeflag="a") then%>
<!--------레이어 팝업---------->
<div id="popWindow" style="position:absolute; left:0px; top:170px; z-index:0; visibility;" onSelectStart="return false" isInfoWin="true">
<table width="310" height=100 cellpadding="0" cellspacing="0" border="0" bgcolor=white>
	<tr>
		<td height=25 bgcolor=#2A75B6 width=70%>&nbsp; <font color=white><b>* 전체 공지사항</td>
		<td height=25 bgcolor=#2A75B6 width=30% align=right><a href="#" onclick="pop_win()"><font color=white><B>[ 창 닫 기 ]</a>&nbsp; </td>
	</tr>
	<tr>
		<td valign=top bgcolor=#F4FB9F align=center colspan=2>

		<table width="97%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td><font color=black><B><%=imsicom_notice%></td>
			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td colspan=2 height=20 bgcolor=#2A75B6 align=right></td>
	</tr>
</table>
</div>
<!--//팝업-->
<%end if%>

<%if imsich_gongi<>"" then%>
<!--------레이어 팝업---------->
<div id="popWindow2" style="position:absolute; left:0px; top:270px; z-index:0; visibility;" onSelectStart="return false" isInfoWin="true">
<table width="310" height=100 cellpadding="0" cellspacing="0" border="0" bgcolor=white>
	<tr>
		<td height=25 bgcolor=#2A75B6 width=70%>&nbsp; <font color=white><b>* <%=imsigtitle%></td>
		<td height=25 bgcolor=#2A75B6 width=30% align=right><a href="#" onclick="pop_win2()"><font color=white><B>[ 창 닫 기 ]</a>&nbsp; </td>
	</tr>
	<tr>
		<td valign=top bgcolor=#F4FB9F align=center colspan=2>

		<table width="97%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td><font color=black><B><%=imsich_gongi%></td>
			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td colspan=2 height=20 bgcolor=#2A75B6 align=right></td>
	</tr>
</table>
</div>
<!--//팝업-->
<%end if%>
<%end if%>

<!--#include virtual="/adminpage/incfile/mbottom2.asp"-->