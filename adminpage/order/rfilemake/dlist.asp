<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")

	searcha = replace(left(now()-1,10),"-","")
	searchc = replace(left(now(),10),"-","")
	searchb = "000000"
	searchd = "000000"

	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select fileflag,fileflaglevel "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = '" & left(session("Ausercode"),5) & "' and flag='1' "
	rslist.Open sql, db, 1
	imsifileflag = rslist(0)
	imsifileflaglevel = rslist(1)
	rslist.close

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
	end if

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
		imsiimsifileflag = "Text7(에듀빌포멧,화일생성코드)"
	elseif imsifileflag="b" then
		imsiimsifileflag = "Text8(주문후 입금액 비교생성 )"
	elseif imsifileflag="c" then
			imsiimsifileflag = "Text9(에듀빌 포맷,세트메뉴분할)"
    elseif imsifileflag="d" then
	imsiimsifileflag = "Excel 4 (화일생성코드, 호차추가,주문확인건)"
       elseif imsifileflag="e" then
	imsiimsifileflag = "Excel 5 (CJ 포멧, 배송일자/확인건)"

	end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select * "
	SQL = sql & " from tb_download "
	SQL = sql & " where bidxsub = '" & left(session("Ausercode"),5) & "' and fileflag='2' "
	if session("Ausergubun")="3" then
		SQL = sql & " and usercode = '" & session("Ausercode") & "'"
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
			imsiregok="y"
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
		<td><font color=blue size=3><B>[ 다운로드 재생성 ]</td>
	</tr>
	<tr height="6">
		<td><font color=red size=2>※.'다운로드'에서 생성한 주문 건 중, 주문한 '년월일시분초'을 지정하여 화일을 재생성하는 기능.('삭제' 클릭->해당 건만 지움)</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="dnfilemake.asp" method="POST" name=findkindform>
<input type="hidden" name="master_code">
<input type="hidden" name="imsifileflag" value="<%=imsifileflag%>">

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp; <B>재생성 일시</td>
		<td nowrap width="84%" bgcolor="#FFFFFF">
        	년월일<input type="Text" name="searcha" size="8" maxlength="8" class="box_work" value="<%=searcha%>">
        	시분초<input type="Text" name="searchb" size="6" maxlength="6" class="box_work" value="<%=searchb%>">
		~
        	년월일<input type="Text" name="searchc" size="8" maxlength="8" class="box_work" value="<%=searchc%>">
        	시분초<input type="Text" name="searchd" size="6" maxlength="6" class="box_work" value="<%=searchd%>">
        	<input type="button" name="재생성" value="재생성" class="box_work"' onclick="javascript:CallJS('Demo()');kindsearchok(this.form);">
		<%if imsifileflag="7" and imsiregok="y" then%>
			<BR>
			브랜드 <select name=cbrandchoice <%if imsibrandflag="n" then%>disabled<%end if%>>
				<option value="0">
				<%if imsibrandflag="y" then%>
					<%if imsibrandboxarry_int<>"" then%>
						<%for i=0 to imsibrandboxarry_int%>
							<option value="<%=imsibrandboxarry(0,i)%>" <%if cstr(imsibrandboxarry(0,i))=cstr(imsicbrandchoice) then%>selected<%end if%>><%=imsibrandboxarry(1,i)%>
						<%next%>
					<%end if%>
				<%end if%>
				<!--<option value="">전체상품-->
			</select>
		<%end if%>
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=8%>번호</td>
		<td width=34%>주문기간</td>
		<td width=10%>주문건수</td>
		<td width=23%>화일생성구분</td>
		<td width=19%>화일명</td>
		<td width=6%>구분</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i
	imsicount=1

	idx = Trim(rslist("idx"))
	start_date = Trim(rslist("start_date"))
	start_yy = left(start_date, 4)
	start_mm = mid(start_date, 5, 2)
	start_dd = right(start_date, 2)

	start_time = Trim(rslist("start_time"))
	start_h = left(start_time, 2)
	start_m = mid(start_time, 3, 2)
	start_s = right(start_time, 2)

	end_date = Trim(rslist("end_date"))
	end_yy = left(end_date, 4)
	end_mm = mid(end_date, 5, 2)
	end_dd = right(end_date, 2)

	end_time = Trim(rslist("end_time"))
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
		<td><%=rslist("count_num")%></td>
		<td><%=imsiimsifileflag%></td>
		<td><a href="down.asp?filename=<%=rslist("filename")%>"><%=rslist("filename")%></a></td>
		<td><a href="redlistdel.asp?idx=<%=rslist("idx")%>&gotopage=<%=gotopage%>">삭제</a></td>
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
				<a href="redlist.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>">첫페이지</a>&nbsp;
				<a href="redlist.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="redlist.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="redlist.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>">다음 10개</a>
				&nbsp;<a href="redlist.asp?GotoPage=<%=rslist.pagecount%>&&searcha=<%=searcha%>&searchb=<%=searchb%>">마지막</a>
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