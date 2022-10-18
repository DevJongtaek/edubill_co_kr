<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->



<script language="JavaScript" type="text/JavaScript">
<!--
function insertcheck(frm) {
	if (frm.bfile1.value=="") {
		alert("파일을 선택하여 주시기바랍니다.") ;
		frm.bfile1.focus() ;
		return false ;
	}
	frm.submit() ;
}

<!-- 대분류 삭제 -->
function delcheck(form) {
	var msg;
	msg=confirm("정말 삭제하겠습니까?");
	if(msg) {
		form.dflag.value="1"
		form.submit() ;
		return false ;
	}
}

function editcheck(frm) {
	frm.submit() ;
}

//-->
</script>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td> &nbsp; <font color=blue size=3><B>[ 로고관리 ]</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>


<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>

<form action="writeok.asp" method=post name=form ENCTYPE="MULTIPART/FORM-DATA">

	<tr height=28 bgcolor=#F7F7FF align=center>
		<td #FFFFFF>신규추가 : 
			<input type=file name=bfile1 size=40>
			<input type=submit value="추가" onclick="return insertcheck(this.form)">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" width=100%>

<%
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select * "
	SQL = sql & " from tb_logo "
	SQL = sql & " order by idx desc"
	'rslist.PageSize=16
	rslist.Open sql, db, 1

	'if not rslist.bof then
	'	rslist.AbsolutePage=int(gotopage)
	'end if

	i=1
	'do until rslist.EOF or rslist.PageSize<i
	do until rslist.EOF

		imsinum = i mod 4
		if imsinum = 1 and i > 1 then
			response.write "</tr>"
              		response.write "<tr bgcolor=white>"
              		response.write "<td colspan=4>&nbsp;</td>"
			response.write "</tr>"
			response.write "<tr bgcolor=white>"
			response.write "<td height=1 colspan=4 background=/images/sub04/con_dot_line.gif></td>"
			response.write "</tr>"
			response.write "<tr bgcolor=white>"
			response.write "<td colspan=4>&nbsp;</td>"
			response.write "</tr>"
			response.write "<tr bgcolor=white>"
		end if
%>

<form action="writeok.asp" method=post name=form ENCTYPE="MULTIPART/FORM-DATA">
<input type=hidden name=gotopage value="<%=gotopage%>">
<input type=hidden name=idx value="<%=rslist("idx")%>">
<input type=hidden name=dflag>

                <td width="25%" align=center><img src="/fileupdown/<%=rslist("filename")%>" width="127" height="134"><BR><input type=submit value="삭제" onclick="return delcheck(this.form)"></td>

</form>

<%
	rslist.movenext
	i=i+1
	loop
	rslist.close
%>

	</tr>
</table>
				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>



<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->