<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<%
	if session("Ausergubun")="3" or session("Ausergubun")="4" then
		response.write "<Script language=javascript>"
		response.write "	alert(""지사 아이디로는 이용권한이 없습니다."");"
		response.write "	history.go(-1);"
		response.write "</Script>"
		response.end
	end if
%>

<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,pcode,pname,pprice,ptitle,gubun,bigo,cbrandchoice,proout,dcenterchoice,prochoice,sname "
	SQL = sql & " from v_product "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "

	if searcha <> "" then
		SQL = sql & " and "& searcha &" like '%"& searchb &"%' "
	end if

	if searchc <> "" then
		SQL = sql & " and (cbrandchoice like '%"& searchc &"%' or cbrandchoice like '%00000%')"
	end if

	SQL = sql & " order by pcode asc"
	rslist.PageSize=20
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select bidx,bname from tb_company_brand "
	SQL = sql & " where idx = "& left(session("Ausercode"),5) &" order by bname asc "
	rs.Open sql, db, 1
	if not rs.eof then
		brand_array    = rs.GetRows
		brand_arraynum = ubound(brand_array,2)
	else
		brand_array    = ""
		brand_arraynum = ""
	end if
	rs.close
%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ 상품관리 ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="plist.asp" method="POST" name=findkindform>

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B> 상품정보 검색</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		<select name="searchc" size="1" class="box_work">
          		<option value="">브랜드전체</option>
			<%if brand_arraynum<>"" then%>
				<%for i=0 to brand_arraynum%>
		          		<option value="<%=brand_array(0,i)%>" <%if searchc = cstr(brand_array(0,i)) then%>selected<%end if%>><%=brand_array(1,i)%></option>
				<%next%>
			<%end if%>
        	</select>

		<select name="searcha" size="1" class="box_work">
          		<option value="">전체리스트</option>
          		<option value="pname" <%if searcha = "pname" then%>selected<%end if%>>상품명</option>
          		<option value="pcode" <%if searcha = "pcode" then%>selected<%end if%>>상품코드</option>
          		<option value="gubun" <%if searcha = "gubun" then%>selected<%end if%>>구분</option>
          		<option value="bigo"  <%if searcha = "bigo"  then%>selected<%end if%>>비고</option>
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
		<td width=30% align=right><%if session("Ausergubun")="2" then%><%if session("Auserwrite")="y" then%><a href="pwrite.asp"><img src="/images/admin/l_bu13.gif" border=0></a><%end if%><%end if%> <a href="excell.asp?searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>"><img src="/images/admin/excel.gif" border=0></a></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=8%>상품코드</td>
		<td width=20%>상품명</td>
		<td width=16%>규격</td>
		<td width=11%>단가</td>
		<td width=13%>서브매뉴</td>
		<td width=11%>브랜드명</td>
		<td width=11%>물류센터명</td>
		<td width=10%>품절</td>
	</tr>

<%
i=1
'j=(gotopage*10)-9
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i

	imsibname = ""
	if rslist("cbrandchoice")<>"" then
		if left(rslist("cbrandchoice"),5) = "00000" then
			imsibname = ""
		else
			imsicbrandchoice = split(rslist("cbrandchoice"),",")
			imsicbrandchoice_int = ubound(imsicbrandchoice)
			for k=0 to imsicbrandchoice_int
				set rs = server.CreateObject("ADODB.Recordset")
				SQL = " select bname from tb_company_brand "
				SQL = sql & " where bidx = "& imsicbrandchoice(k) &" "
				rs.Open sql, db, 1
				if not rs.eof then
					if imsibname="" then
						if imsicbrandchoice_int>0 then
							imsibname = left(rs(0),1)
						else
							imsibname = rs(0)
						end if
					else
						if imsicbrandchoice_int>0 then
							imsibname = imsibname&","&left(rs(0),1)
						else
							imsibname = imsibname&","&rs(0)
						end if
					end if
				else
					imsibname = imsibname
				end if
				rs.close
			next
		end if

	else
		imsibname = ""
	end if
	if rslist("proout")="y" then
		imsiproout = "주문가능"
		proout_fcolor = ""
	else
		imsiproout = "품절"
		proout_fcolor = "<font color=red>"
	end if

	imsidcenterchoice = ""
	if rslist("dcenterchoice")="" or rslist("dcenterchoice")="0" then
		imsidcenterchoice = ""
	else
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select bname from tb_company_dcenter "
		SQL = sql & " where bidx = "& int(rslist("dcenterchoice")) &" "
		rs.Open sql, db, 1
		if not rs.eof then
			imsidcenterchoice = rs(0)
		end if
		rs.close
	end if

'	if rslist("prochoice")="" or isnull(rslist("dcenterchoice")) then
'		prochoice = ""
'	else
'		set rs = server.CreateObject("ADODB.Recordset")
'		SQL = " select sname from tb_product_submenu "
'		SQL = sql & " where sidx = "& int(rslist("prochoice")) &" "
'		rs.Open sql, db, 1
'response.write sql
'		if not rs.eof then
'			prochoice = rs(0)
'		end if
'		rs.close
'	end if
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><a href="pwrite.asp?gotopage=<%=gotopage%>&idx=<%=rslist("idx")%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>"><b><%=proout_fcolor%><%=rslist("pcode")%></a></td>
		<td align=left> &nbsp; <%=proout_fcolor%><%=rslist("pname")%></td>
		<td align=left> &nbsp; <%=proout_fcolor%><%=rslist("ptitle")%></td>
		<td align=right><%=proout_fcolor%><%=FormatCurrency(rslist("pprice"))%> &nbsp; </td>
		<td><%=proout_fcolor%><%=rslist("sname")%></td>
		<td><%=proout_fcolor%><%=imsibname%></td>
		<td><%=proout_fcolor%><%=imsidcenterchoice%></td>
		<td><%=proout_fcolor%><%=imsiproout%></td>
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
				<a href="plist.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>">첫페이지</a>&nbsp;
				<a href="plist.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="plist.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="plist.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>">다음 10개</a>
				&nbsp;<a href="plist.asp?GotoPage=<%=rslist.pagecount%>&&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>">마지막</a>
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