<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	if searchc = "" then
		searchc = replace(left(now()-1,10),"-","")
	end if
	searchd = request("searchd")
	if searchd = "" then
		searchd = replace(left(now(),10),"-","")
	end if
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select fileflag,fileflaglevel,djflag "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = '" & left(session("Ausercode"),5) & "' and flag='1' "
	rslist.Open sql, db, 1
	imsifileflag = rslist(0)
	imsifileflaglevel = rslist(1)
	imsidjflag = rslist(2)
	rslist.close

	imsifileflag = "1"
	if imsifileflag="0" then
		imsiimsifileflag = "사용안함"
	elseif imsifileflag="1" then
		imsiimsifileflag = "Text 1 (에듀빌 포멧)"
	elseif imsifileflag="2" then
		imsiimsifileflag = "Text 2 (CJ 포멧, 주문일자)"
	elseif imsifileflag="3" then
		imsiimsifileflag = "Text 3 (CJ 포멧,배송일자/확인건)"
	elseif imsifileflag="4" then
		imsiimsifileflag = "Excel 1"
	elseif imsifileflag="5" then
		imsiimsifileflag = "Excel 2"
	elseif imsifileflag="6" then
		imsiimsifileflag = "Excel 3"
	elseif imsifileflag="7" then
		imsiimsifileflag = "Text4(에듀빌포멧,주문확인건만)"
	elseif imsifileflag="8" then
		imsiimsifileflag = "Text5(에듀빌포멧,배달요청일자)"
	elseif imsifileflag="9" then
		imsiimsifileflag = "Text6(CJ 포멧,배달요청일자)"
	elseif imsifileflag="a" then
		imsiimsifileflag = "Text7(에듀빌 포멧,화일생성코드)"
	end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select * "
	SQL = sql & " from tb_DepositDownload "
	SQL = sql & " where bidxsub = '" & left(session("Ausercode"),5) & "' and fileflag='1' "

	if session("Ausergubun")="3" then
		SQL = sql & " and usercode = '" & session("Ausercode") & "'"
	end if

	if searcha <> "" then
		SQL = sql & " and "& searcha &" like '"& searchb &"%' "
	end if
	SQL = sql & " order by idx desc"

	'RESPONSE.WRITE SQL
	rslist.PageSize=20
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if

	imsiregok="n"
	if imsifileflaglevel="1" then			'본사만생성
		if session("Ausergubun")="2" then	'본사
			imsiregok="y"
		end if
	else						'지사만생성
		if session("Ausergubun")="3" then	'지사
			if session("Auserwrite")="y" then	'쓰기권한이 있는 경우만
				imsiregok="y"
			end if
		end if
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
		<td><font color=blue size=3><B>[ 입금 다운로드 ]</td>
	</tr>
	<tr height="6">
		<td><font color=red size=2>※.'가상계좌' 입금 건을 지정한 화일형식(TEXT)으로 일괄 생성시켜주는 기능. <br>
		※. 생성완료 메시지가 뜨기 전에 페이지 이동할 경우 파일이 제대로 생성되지 않을 수 있습니다.</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="depositlist.asp" method="POST" name=findkindform>
<input type="hidden" name="master_code">
	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp; <B>다운로드 검색</td>
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

<%
if imsifileflag="7" then

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select bidx,bname "
	SQL = sql & " from tb_company_brand "
	SQL = sql & " where idx = '"& left(session("Ausercode"),5) &"' order by bname asc"
	rs.Open sql, db, 1
	if not rs.eof then
		imsibrandboxarry = rs.GetRows
		imsibrandboxarry_int = ubound(imsibrandboxarry,2)
	else
		imsibrandboxarry = ""
		imsibrandboxarry_int = ""
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select brandflag "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = '"& left(session("Ausercode"),5) &"' "
	rs.Open sql, db, 1
	imsibrandflag = rs(0)
	rs.close
%>


<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right></td>
	</tr>
</table>
<%else%>
<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right><%if session("Ausergubun")="2" then%><a href="depositfilemake.asp" onClick="CallJS('Demo1()')"><img src="/images/l_bu22.gif" border=0></a><%end if%></td>
	</tr>
</table>
<%end if%>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=7%>번호</td>
		<td width=35%>가상계좌 입금기간</td>
		<td width=10%>입금건수</td>
		<td width=22%>화일생성구분</td>
		<td width=17%>화일명</td>
		<td width=9%>집계</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i
	imsicount=1

	idx = Trim(rslist("idx"))
	start_date = Trim(rslist("startdate"))
	start_yy = left(start_date, 4)
	start_mm = mid(start_date, 5, 2)
	start_dd = right(start_date, 2)

	start_time = Trim(rslist("starttime"))
	start_h = left(start_time, 2)
	start_m = mid(start_time, 3, 2)
	start_s = right(start_time, 2)

	end_date = Trim(rslist("enddate"))
	end_yy = left(end_date, 4)
	end_mm = mid(end_date, 5, 2)
	end_dd = right(end_date, 2)

	end_time = Trim(rslist("endtime"))
	end_h = left(end_time, 2)
	end_m = mid(end_time, 3, 2)
	end_s = right(end_time, 2)

	start_date = start_yy & "/" & start_mm & "/" & start_dd
	start_time = start_h & ":" & start_m & ":" & start_s

	end_date = end_yy & "/" & end_mm & "/" & end_dd
	end_time = end_h & ":" & end_m & ":" & end_s
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=start_date%>&nbsp;<%=start_time%> - <%=end_date%>&nbsp;<%=end_time%></td>
		<td><%=rslist("countnum")%></td>
		<td><%=imsiimsifileflag%></td>
		<td><%If session("Ausergubun")="2" Then%><a href="depositdown.asp?fname=<%=rslist("filename")%>"><%End if%><%=rslist("filename")%></a></td>
		<td></td>
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
				<a href="depositlist.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>">첫페이지</a>&nbsp;
				<a href="depositlist.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="depositlist.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="depositlist.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>">다음 10개</a>
				&nbsp;<a href="depositlist.asp?GotoPage=<%=rslist.pagecount%>&&searcha=<%=searcha%>&searchb=<%=searchb%>">마지막</a>
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