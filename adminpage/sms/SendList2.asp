<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=tcnt%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right><a href="newexcell.asp?searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>"><img src="/images/admin/excel.gif" border=0></a></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=7%>코드</td>
		<td width=22%>체인점명</td>
		<td width=19%>전송일시</td>
		<td width=13%>핸드폰번호</td>
		<td width=10%>통신사</td>
		<td width=12%>전송결과</td>
		<td width=12%>메세지</td>
	</tr>

<%
if imsierrcnt>0 then
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i
  '2011.02.14 Null값 처리
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select comname from tb_company where flag='3' and bidxsub = '"& left(session("Ausercode"),5) &"' and tcode = '" & rslist("TR_ETC2") & "'"
	rs.Open sql, db, 1
	if not rs.eof then
		comname = rs(0)
	end if
	rs.close
	tr_net = ""
	Select Case rslist("TR_NET")
		Case "011" tr_net = "SKT"
		Case "016" tr_net = "KTF"
		Case "019" tr_net = "LGT"
		Case Else tr_net = ""
	End Select 
	tr_rslt = "실패"
	If rslist("TR_RSLTSTAT") = "06" Then 
		tr_rslt="성공"		
	End If 

	if(IsNull(rslist("TR_PHONE"))) then
  		tran_phone  = FunHPCut(replace(trim(0)," ",""))
 	else
 		tran_phone  = FunHPCut(replace(trim(rslist("TR_PHONE"))," ",""))
  end if

%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=rslist("TR_ETC2")%></td>
		<td><%=comname%></td>
		<td><%=rslist("TR_RSLTDATE")%></td>
		<td><%=tran_phone%></td>
		<td><%=tr_net%></td>
		<td><%=tr_rslt%></td>
		<td><a href="#" onclick="smsmsgpop('<%=replace(rslist("TR_MSG"),"""","$$")%>');"><font color=blue><B>보기</td>
	</tr>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop
end if
%>

</table>

<table border="0" cellspacing="0" cellpadding="0" width=100%>
	<tr height=30 align=center>
		<td>
<%if imsierrcnt>0 then%>
		<% blockPage=Int((GotoPage-1)/10)*10+1
			if blockPage = 1 Then
				Response.Write "<font color=#8B9494>이전10개</font> [ "
			Else 
		%>
				<a href="SendList.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">첫페이지</a>&nbsp;
				<a href="SendList.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="SendList.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="SendList.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">다음 10개</a>
				&nbsp;<a href="SendList.asp?GotoPage=<%=rslist.pagecount%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">마지막</a>
		<% 	End If %>
<%end if%>
		</td>
	</tr>
</table>