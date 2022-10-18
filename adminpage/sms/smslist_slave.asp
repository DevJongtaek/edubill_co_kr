
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha1 = request("searcha1")
	searchb1 = request("searchb1")
	GotoPage = Request("GotoPage")
	master_code = Request("master_code")
	xlsMode = request("xlsMode")

	if GotoPage = "" then
		GotoPage = 1
	end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select * "
	SQL = sql & " from tb_sms_slave "
	SQL = sql & " where idx = '" & master_code & "'"

	if searcha1 <> "" then
		SQL = sql & " and "& searcha1 &" like '"& searchb1 &"%' "
	end if

	SQL = sql & " order by idx_sub"

	'response.write SQL
	rslist.PageSize=20
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if

	if xlsMode="1" then	'// excel download
	
		' Excel 저장시 header title
		dim xlsMode, xlsFileName, xlsHeader, xlsFields
		xlsFileName = "sms.xls"
		xlsHeader = "체인점코드|체인점명|핸드폰번호|이통사"
		
		SQL = " select code, code_name, mobile, mobile_company "
		SQL = SQL & " from tb_sms_slave "
		SQL = SQL & " where idx = '" & master_code & "'"
		SQL = SQL & " and result = 'F'"
	
		SET rs1 = db.execute(SQL)

		if err.number <> 0 then
			response.write "조회 오류입니다 : " & err.description 
		else
			response.clear		
%>
			<!--#include FILE="dnExcel.asp"-->
<%
		end if
		
		rs1.close : set rs1=nothing
		response.end
	end if
%>
<SCRIPT langauge=javascript>
<!--//
function viewslave(master_code) {
    var f = document.findkindform;
    if (master_code == "") return;
    f.master_code.value = master_code;
    f.action="smslist_slave.asp";
    f.submit();
}
function btnExcel_onClick() {
	var f = document.findkindform;
	f.xlsMode.value="1"
	f.submit();
}
//-->
</SCRIPT>
<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ URL 전송 ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="smslist_slave.asp" method="POST" name=findkindform>
<input type="hidden" name="master_code" value="<%=master_code%>">
<INPUT type="hidden" name=xlsMode>
	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp; <B>USRL 전송 검색</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		<select name="searcha1" size="1" class="box_work">
          		<option value="">전체리스트</option>
          		<option value="code" <%if searcha1 = "code" then%>selected<%end if%>>코드</option>
          		<option value="code_name" <%if searcha1 = "code_name" then%>selected<%end if%>>코드이름</option>
          		<option value="mobile" <%if searcha1 = "mobile" then%>selected<%end if%>>핸드폰번호</option>
          		<option value="mobile_company" <%if searcha1 = "mobile_company" then%>selected<%end if%>>이통사</option>
          		<option value="result" <%if searcha1= "result" then%>selected<%end if%>>결과</option>
        	</select>
        	<input type="Text" name="searchb1" size="20" maxlength="20" class="box_work" value="<%=searchb1%>">
        	<input type="button" name="검 색" value="검 색 " class="box_work"' onclick="javascript:kindsearchok1(this.form);">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right><a href="smslist_update.asp?idx=<%=master_code%>">전송결과 Update</a></td>
	</tr>
</table>
<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=15%>코드</td>
		<td width=20%>코드이름</td>
		<td width=15%>핸드폰번호</td>
		<td width=15%>이통사</td>
		<td width=10%>결과</td>
	</tr>

<%
i=1
'j=(gotopage*10)-9
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i

	imsicount=0
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=rslist("idx_sub")%></td>
		<td><%=rslist("code")%></td>
		<td><%=rslist("code_name")%></td>
		<td><%=rslist("mobile")%></td>
		<td><%=rslist("mobile_company")%></td>
		<td><%=rslist("result")%></td>
	</tr>

</form>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop
%>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%></td>
		<td width=30% align=right><a href="javascript:btnExcel_onClick()"><img src="http://220.73.136.50:8080//images/admin/excel.gif" border="0"> 미전송건 엑셀 다운로드</a></td>
	</tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width=100%>
	<tr height=30 align=center>
		<td>

		<% blockPage=Int((GotoPage-1)/10)*10+1
			if blockPage = 1 Then
				Response.Write "<font color=#8B9494>이전10개</font> [ "
			Else 
		%>
				<a href="smslist_slave.asp?GotoPage=1&searcha1=<%=searcha1%>&searchb1=<%=searchb1%>">첫페이지</a>&nbsp;
				<a href="smslist_slave.asp?GotoPage=<%=blockPage-10%>&searcha1=<%=searcha1%>&searchb1=<%=searchb1%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="smslist_slave.asp?GotoPage=<%=blockPage%>&searcha1=<%=searcha1%>&searchb1=<%=searchb1%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="smslist_slave.asp?GotoPage=<%=blockPage%>&searcha1=<%=searcha1%>&searchb1=<%=searchb1%>">다음 10개</a>
				&nbsp;<a href="smslist_slave.asp?GotoPage=<%=rslist.pagecount%>&&searcha1=<%=searcha1%>&searchb1=<%=searchb1%>">마지막</a>
		<% 	End If %>

		</td>
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