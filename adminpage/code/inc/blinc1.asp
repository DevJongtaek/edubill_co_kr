<script language="JavaScript">
<!--
function bwinopenXY(URLStr, title, winWidth, winHeight){
	var x, y;
			
	x = 100
	y = 100		
	window.open( URLStr , title, "toolbar=no, scrollbars=yes, width=" + winWidth +", height=" + winHeight + ",  top=" + y + ",left=" + x);
}

//-->
</script>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="blist.asp" method="POST" name=findkindform>
<input type=hidden name=flag value="<%=flag%>">

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25">&nbsp;<B>회원사정보 검색</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
		<select name="searcha" size="1" class="box_work">
          		<option value="">전체리스트</option>
          		<option value="comname" <%if searcha = "comname" then%>selected<%end if%>>회원사명</option>
          		<option value="name" <%if searcha = "name" then%>selected<%end if%>>대표자명</option>
          		<option value="tel3" <%if searcha = "tel3" then%>selected<%end if%>>전화번호</option>
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
		<td width=30% align=right></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=8%>번호</td>
		<td width=10%>회원사코드</td>
		<td width=17%>회원사명</td>
		<td width=11%>대표자</td>
		<td width=11%>담당자</td>
		<td width=13%>전화번호</td>
		<td width=10%>등록일자</td>
		<td width=20%>구분</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i

	imsirscount1 = 0
	imsirscount2 = 0
	imsiusername = ""

	set rscount = server.CreateObject("ADODB.Recordset")
	SQL = " select username"
	SQL = sql & " from tb_adminuser "
	SQL = sql & " where flag = '2' and usercode = '"& rslist("idx") &"' "
	rscount.Open sql, db, 1
	if not rscount.eof then
		imsiusername = rscount(0)
	end if
	rscount.close
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=rslist("tcode")%></td>
		<td align=left><a href="write.asp?gotopage=<%=gotopage%>&flag=<%=flag%>&idx=<%=rslist("idx")%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>"><b><%=rslist("comname")%></a></td>
		<td><%=rslist("name")%></td>
		<td align=left><%=imsiusername%></td>
		<td><%=rslist("tel1")%>-<%=rslist("tel2")%>-<%=rslist("tel3")%></td>
		<td><%=left(rslist("startday"),4)%>/<%=mid(rslist("startday"),5,2)%>/<%=right(rslist("startday"),2)%></td>
		<td><a href="#" onclick="javascript:bwinopenXY('bwrite.asp?idx=<%=rslist("idx")%>', 'domain', 500, 500)">브랜드보기</a></td>
	</tr>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop 
%>

</table>