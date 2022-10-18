
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select a.idx, a.sms_date, a.sms_time, b.userid, b.username "
	SQL = sql & " from tb_sms_master a, tb_adminuser b "
	SQL = sql & " where a.comp_id = b.usercode"
	SQL = sql & " and usercode = '10273' "

	if searcha <> "" then
		SQL = sql & " and "& searcha &" like '"& searchb &"%' "
	end if

	SQL = sql & " order by a.idx desc"
	rslist.PageSize=20
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
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

<form action="smslist_master.asp" method="POST" name=findkindform>
<input type="hidden" name="master_code">
	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp; <B>USRL 전송 검색</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		<select name="searcha" size="1" class="box_work">
          		<option value="">전체리스트</option>
          		<option value="a.idx" <%if searcha = "a.idx" then%>selected<%end if%>>전송코드</option>
          		<option value="a.sms_date" <%if searcha = "a.sms_date" then%>selected<%end if%>>전송일자</option>
        	</select>
        	<input type="Text" name="searchb" size="20" maxlength="20" class="box_work" value="<%=searchb%>">
        	<input type="button" name="검 색" value="검 색 " class="box_work"' onclick="javascript:kindsearchok(this.form);">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right><%if session("Ausergubun")="2" then%><%if session("Auserwrite")="y" then%><a href="cwrite.asp"><img src="/images/admin/l_bu14.gif" border=0></a><%end if%><%end if%></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=15%>전송코드</td>
		<td width=15%>아이디</td>
		<td width=15%>사용자명</td>
		<td width=15%>전송일자</td>
		<td width=10%>전송시간</td>
	</tr>

<%
i=1
'j=(gotopage*10)-9
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i

	imsicount=0
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'" onClick="viewslave('<%=Trim(rslist("idx"))%>')">
		<td><%=rslist("idx")%></td>
		<td><%=rslist("userid")%></td>
		<td><%=rslist("username")%></td>
		<td><%=rslist("sms_date")%></td>
		<td><%=rslist("sms_time")%></td>
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

<table border="0" cellspacing="0" cellpadding="0" width=100%>
	<tr height=30 align=center>
		<td>

		<% blockPage=Int((GotoPage-1)/10)*10+1
			if blockPage = 1 Then
				Response.Write "<font color=#8B9494>이전10개</font> [ "
			Else 
		%>
				<a href="smslist_master.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>">첫페이지</a>&nbsp;
				<a href="smslist_master.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="smslist_master.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="smslist_master.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>">다음 10개</a>
				&nbsp;<a href="smslist_master.asp?GotoPage=<%=rslist.pagecount%>&&searcha=<%=searcha%>&searchb=<%=searchb%>">마지막</a>
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