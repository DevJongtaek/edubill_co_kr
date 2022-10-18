<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="list.asp" method="POST" name=findkindform>
<input type=hidden name=flag value="<%=flag%>">

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>지사(점)개설일자<BR> &nbsp;<B>지사(점)정보검색</td>
		<td nowrap width="84%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			예)20040928 ~ 20041004
			<BR>
			<select name="searcha" size="1" class="box_work">
          			<option value="">전체리스트</option>
          			<option value="tcode" <%if searcha = "tcode" then%>selected<%end if%>>지사코드</option>
          			<option value="comname" <%if searcha = "comname" then%>selected<%end if%>>지사명</option>
          			<option value="name" <%if searcha = "name" then%>selected<%end if%>>대표자명</option>
    	      			<option value="tel" <%if searcha = "tel3" then%>selected<%end if%>>전화번호</option>
        		</select>
        		<input type="Text" name="searchb" size="10" maxlength="20" class="box_work" value="<%=searchb%>">
	        	<input type="button" name="검 색" value="검 색" class="box_work"' onclick="javascript:kindsearchok(this.form);">
	        	<input type="button" name="초기화" value="초기화" class="box_work"' onclick="javascript:frmzerocheck(this.form,'list.asp?flag=2');">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right><%if session("Ausergubun")="2" then%><%if session("Auserwrite")="y" then%><a href="write.asp?flag=<%=flag%>"><img src="/images/admin/l_bu09.gif" border=0></a><%end if%><%end if%></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>번호</td>
		<td width=10%>지사(점)코드</td>
		<td width=25%>지사(점)명</td>
		<td width=15%>물류센터명</td>
		<td width=10%>대표자</td>
		<td width=15%>전화번호</td>
		<td width=10%>체인점수</td>
		<td width=10%>호차</td>
	</tr>

<%
i=1
'j=(gotopage*10)-9
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i

	imsidcarno = ""
	imsiusername = ""

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select dcarno from tb_car where idx = "& rslist("dcarno")
	rs.Open sql, db, 1
	if not rs.eof then
		imsidcarno = rs(0)
	end if
	rs.close

	imsicnt2=0
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select isnull(count(idx),0) from tb_company where flag='3' and idxsub = "& rslist("idx")
	rs.Open sql, db, 1
	if not rs.eof then
		imsicnt2 = rs(0)
	end if
	rs.close

	choiceDcenter = rslist("choiceDcenter")
	if choiceDcenter="0" or choiceDcenter="" or isnull(choiceDcenter) then
		choiceDcenter = ""
	else
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select bname from tb_company_dcenter where bidx = "& choiceDcenter
		rs.Open sql, db, 1
		if not rs.eof then
			imsichoiceDcenter = rs(0)
		else
			imsichoiceDcenter = ""
		end if
		rs.close
		choiceDcenter = imsichoiceDcenter
	end if
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><a href="write.asp?gotopage=<%=gotopage%>&flag=<%=flag%>&idx=<%=rslist("idx")%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>"><b><%=rslist("tcode")%></a></td>
		<td><%=rslist("comname")%></td>
		<td><%=choiceDcenter%></td>
		<td><%=rslist("name")%></td>
		<td><%=rslist("tel1")%>-<%=rslist("tel2")%>-<%=rslist("tel3")%></td>
		<td><%=imsicnt2%></td>
		<td><%=imsidcarno%>호차</td>
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