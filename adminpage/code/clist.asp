<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select dcenterflag from tb_company where idx = "& int(session("Ausercode")) &" "
	rs2.Open sql, db, 1
	if not rs2.eof then
		imsidcenterflag = rs2(0)
	end if
	rs2.close

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,dcarno,dcarname,tel1,tel2,tel3,carno,carkind,caryflag,dcenteridx "
	SQL = sql & " from tb_car "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "

	if searcha <> "" then
		SQL = sql & " and "& searcha &" like '"& searchb &"%' "
	end if

	'if imsidcenterflag="y" then
		SQL = sql & " order by dcarno asc"
	'else
	'	SQL = sql & " order by wdate desc"
	'end if
	rslist.PageSize=20
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if
%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 호차관리 ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="clist.asp" method="POST" name=findkindform>

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp; <B>호차정보 검색</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		<select name="searcha" size="1" class="box_work">
          		<option value="">전체리스트</option>
          		<option value="dcarno" <%if searcha = "dcarno" then%>selected<%end if%>>호차</option>
          		<option value="dcarname" <%if searcha = "dcarname" then%>selected<%end if%>>기사명</option>
          		<option value="carkind" <%if searcha = "carkind" then%>selected<%end if%>>차종</option>
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

<%if imsidcenterflag="y" then%>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=12%>물류센터명</td>
		<td width=10%>호차</td>
		<td width=15%>기사명</td>
		<td width=15%>핸드폰번호</td>
		<td width=8%>체인점수</td>
		<td width=10%>차량번호</td>
		<td width=15%>차종</td>
		<td width=10%>호차코드</td>
	</tr>

<%
i=1
'j=(gotopage*10)-9
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i
	bname = ""
	if not isnull(rslist("dcenteridx")) then
		dcenteridx = rslist("dcenteridx")
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select bname,bidx from tb_company_dcenter where bidx = "& dcenteridx
		rs.Open sql, db, 1
if not rs.eof then
		bname = rs(0)
   
end if
		rs.close
	end if

	imsicount=0
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select count(idx) "
	SQL = sql & " from tb_company "
	SQL = sql & " where flag = '3' "
	SQL = sql & " and bidxsub = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " and dcarno = "& rslist("idx") &" "
	rs.Open sql, db, 1
	imsicount = rs(0)
	rs.close
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=bname%></td>
		<td><a href="cwrite.asp?gotopage=<%=gotopage%>&idx=<%=rslist("idx")%>&searcha=<%=searcha%>&searchb=<%=searchb%>"><b><%=rslist("dcarno")%>호차</a></td>
		<td><%=rslist("dcarname")%></td>
		<td><%=rslist("tel1")%>-<%=rslist("tel2")%>-<%=rslist("tel3")%></td>
		<td><%=imsicount%></td>
		<td><%=rslist("carno")%></td>
		<td><%=rslist("carkind")%></td>
		<td><%=rslist("idx")%></td>
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

<%else%>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=10%>호차</td>
		<td width=15%>기사명</td>
		<td width=15%>핸드폰번호</td>
		<td width=8%>체인점수</td>
		<td width=20%>차량번호</td>
		<td width=17%>차종</td>
		<td width=10%>호차코드</td>
	</tr>

<%
i=1
'j=(gotopage*10)-9
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i

	imsicount=0
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select count(idx) "
	SQL = sql & " from tb_company "
	SQL = sql & " where flag = '3' "
	SQL = sql & " and bidxsub = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " and dcarno = "& rslist("idx") &" "
	rs.Open sql, db, 1
	imsicount = rs(0)
	rs.close
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><a href="cwrite.asp?gotopage=<%=gotopage%>&idx=<%=rslist("idx")%>&searcha=<%=searcha%>&searchb=<%=searchb%>"><b><%=rslist("dcarno")%>호차</a></td>
		<td><%=rslist("dcarname")%></td>
		<td><%=rslist("tel1")%>-<%=rslist("tel2")%>-<%=rslist("tel3")%></td>
		<td><%=imsicount%></td>
		<td><%=rslist("carno")%></td>
		<td><%=rslist("carkind")%></td>
		<td><%=rslist("idx")%></td>
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

<%end if%>


<table border="0" cellspacing="0" cellpadding="0" width=100%>
	<tr height=30 align=center>
		<td>

		<% blockPage=Int((GotoPage-1)/10)*10+1
			if blockPage = 1 Then
				Response.Write "<font color=#8B9494>이전10개</font> [ "
			Else 
		%>
				<a href="clist.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>">첫페이지</a>&nbsp;
				<a href="clist.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="clist.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="clist.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>">다음 10개</a>
				&nbsp;<a href="clist.asp?GotoPage=<%=rslist.pagecount%>&&searcha=<%=searcha%>&searchb=<%=searchb%>">마지막</a>
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