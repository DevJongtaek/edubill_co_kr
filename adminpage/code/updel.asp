<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,wdate,userid,usercode,flag,gubun,code,content "
	SQL = sql & " from tb_log "
	SQL = sql & " order by wdate desc"
	rslist.PageSize=20
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if
%>

<script Language="JavaScript">
<!-- 
function delcheck() {
	var msg;
	msg=confirm("정말 삭제하겠습니까?");
	if(msg) {
		form.submit() ;
		return false ;
	}
}

function delcheck2() {
	if (form.delgubun3.value=="") {
		alert("추가를 선택하여 주시기바랍니다.") ;
		form.delgubun3.focus() ;
		return false ;
	}
	var msg;
	msg=confirm("정말 삭제하겠습니까?");
	if(msg) {
		form.action="updelok22.asp" ;
		form.submit() ;
		return false ;
	}
}
//-->
</script>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td width=65%><font color=blue size=3><B>[ 상품/체인점 추가|수정|삭제관리 ]</td>
	</tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form name=form method=post action="updelok2.asp">

	<tr height=30 valign=bottom>
		<td width=40%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=60% align=right>
			<select name="delgubun1">
				<option value="1">전체
				<option value="2">상품
				<option value="3">체인
			</select> 
			<select name="delgubun2">
<!--
				<option value="1">전체
-->
				<option value="3">수정
				<option value="4">삭제
				<!--<option value="2">추가-->
			</select>
			<input type=button value="삭제" onclick="return delcheck(this.form)">
 &nbsp; 		<a href="excell3.asp"><img src="/images/admin/excel.gif" border=0></a>
 &nbsp; 
			<select name="delgubun3">
				<option value="">추가선택
				<option value="2">추가
			</select>
			<input type=button value="추가삭제" onclick="return delcheck2(this.form)">

		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=20%>날짜</td>
		<td width=9%>아이디</td>
		<td width=20%>회원사</td>
		<td width=7%>코드</td>
		<td width=7%>구분</td>
		<td width=7%>코드</td>
		<td width=23%>상품명</td>
		<td width=7%>구분</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i

	imsicomname = ""
	imsitcode = ""

	if isnull(rslist(3)) or rslist(3)="" then
	else
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select tcode,comname "
		SQL = sql & " from tb_company "
		SQL = sql & " where idx = "& left(rslist(3),5) &" "
		rs.Open sql, db, 1
		if not rs.eof then
			imsitcode = rs(0)
			imsicomname = rs(1)
		end if
		rs.close
	end if

	imsifont = ""
	if rslist(5)="추가" then
		imsifont = "<font color=blue>"
	else
		imsifont = ""
	end if

	'2006-07-20 오후 5:32:50
	imsiimsiday = rslist(1)
	if len(replace(right(imsiimsiday,8)," ","")) = 7 then
		imsiimsiday = left(imsiimsiday,14) & "0" & right(imsiimsiday,7)
	end if
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=imsiimsiday%></td>
		<td><%=rslist(2)%></td>
		<td align=left>&nbsp;<%=imsitcode%>(<%=imsicomname%>)</td>
		<td><%=rslist(4)%></td>
		<td><%=imsifont%><%=rslist(5)%></td>
		<td><%=rslist(6)%></td>
		<td align=left>&nbsp;<%=rslist(7)%></td>
		<td><a href="updelok.asp?gotopage=<%=gotopage%>&idx=<%=rslist(0)%>">삭제</a></td>
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
				<a href="updel.asp?GotoPage=1&searcha=<%=searcha%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>">첫페이지</a>&nbsp;
				<a href="updel.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searche=<%=searche%>&searchd=<%=searchc%>&searchg=<%=searchc%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="updel.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="updel.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>">다음 10개</a>
				&nbsp;<a href="updel.asp?GotoPage=<%=rslist.pagecount%>&searcha=<%=searcha%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>">마지막</a>
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