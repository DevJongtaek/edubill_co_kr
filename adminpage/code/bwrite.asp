<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	idx = request("idx")
	if idx<>"" then
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select bidx,idx,bname "
		SQL = sql & " from tb_company_brand "
		SQL = sql & " where idx = "& idx
		rs.Open sql, db, 1
	end if

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<title>브랜드관리</title>

<script language="JavaScript">
<!--
function bkindwrite(frm) {
	if (frm.bname.value=="") {
		alert("브랜드명을 입력하여 주시기바랍니다.") ;
		frm.bname.focus() ;
		return false ;
	}
	frm.submit() ;
}

function bkindwrite2(form) {
	var msg;
	msg=confirm("정말 삭제하겠습니까?");
	if(msg) {
		form.dflag.value="1"
		form.submit() ;
		return false ;
	}
}
//-->
</script>
</head>

<body leftmargin="0" topmargin="0">

<table width="470" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 브랜드관리 ]</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=20%><B>코드번호</td>
		<td width=30%><B>브랜드명</td>
		<td width=50%><B>구분</td>
	</tr>
<%
if idx<>"" then
do until rs.EOF
%>

<form action="bwriteok.asp" method=post name=form>
<input type=hidden name=bidx value="<%=rs("bidx")%>">
<input type=hidden name=idx value="<%=idx%>">
<input type=hidden name=dflag>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=rs("bidx")%></td>
		<td><input type=text name=bname value="<%=rs("bname")%>" size=13></td>
		<td><input type="button" value="수 정" style='background-color:#C1C184;' style="width:49%;" onclick="return bkindwrite(this.form);"> <input type="button" value="삭 제" style='background-color:#C1C184;' style="width:49%;" onclick="return bkindwrite2(this.form);"></td>
	</tr>

</form>

<%
rs.MoveNext 
loop 
end if
%>

<form action="bwriteok.asp" method=post name=form2>
<input type=hidden name=idx value="<%=idx%>">

	<tr height=22 bgcolor=#F7F7FF align=center align=center>
		<td>신규브랜드입력</td>
		<td><input type=text name=bname size=13></td>
		<td><input type="button" value="추 가" style='background-color:#C1C184;' style="width:49%;" onclick="return bkindwrite(this.form);"></td>
	</tr>

</form>

</table>


				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

</body>
</html>