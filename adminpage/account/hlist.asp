<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")

	if searcha = "" then
		searcha = replace(left(now()-120,7),"-","")
	end if
	if searchb = "" then
		searchb = replace(left(now(),7),"-","")
	end if
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select accountflag from tb_company where idx = " & left(session("Ausercode"),5)
	rs.Open sql, db, 1
	accountflag = rs(0)
	rs.close

	if len(session("Ausercode"))=10 then
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select tcode from tb_company where idx = " & right(session("Ausercode"),5)
		rs.Open sql, db, 1
		imsijtcode = rs(0)
		rs.close
	end if

	sendSQL = " idx = '" & left(session("Ausercode"),5) & "' and (Aym >= '" & searcha & "' and Aym <= '" & searchb & "') "
	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select a.seq,a.Aym,a.hname,a.umoney,a.tcode,a.textBigo,b.Anum,b.kmoney,b.smoney,b.hmoney, c.accountflag, a.jtcode, a.idate,a.imoney,c.idx as CIDX from "
	SQL = sql & " (select seq,idx,Aym,hname,umoney,tcode,textBigo,wdate,jtcode,idate,imoney from tAccountM where flag='1' and "& sendSQL &" ) a "

	if len(session("Ausercode"))=5 then
		SQL = sql & " left outer join "
		SQL = sql & " (select wdate,sum(Anum) as Anum,sum(kmoney) as kmoney,sum(smoney) as smoney,sum(hmoney) as hmoney,jtcode from tAccountM where "& sendSQL &" and jtcode='' group by wdate,jtcode) b "
		SQL = sql & " on a.wdate = b.wdate and ((a.jtcode='' and b.jtcode='') or (a.jtcode<>'' and b.jtcode<>'')) "
	elseif len(session("Ausercode"))=10 then
		SQL = sql & " left outer join "
		SQL = sql & " (select wdate,sum(Anum) as Anum,sum(kmoney) as kmoney,sum(smoney) as smoney,sum(hmoney) as hmoney,jtcode from tAccountM where "& sendSQL &" and jtcode = '"& imsijtcode &"' group by wdate,jtcode) b "
		SQL = sql & " on a.wdate = b.wdate and ((a.jtcode='' and b.jtcode='') or (a.jtcode<>'' and b.jtcode<>'')) "
	end if

	SQL = sql & " left outer join "
	SQL = sql & " (select idx,accountflag from tb_company where flag='1') c "
	SQL = sql & " on a.idx = c.idx "

	if len(session("Ausercode"))=5 then
		SQL = sql & " where a.jtcode='' "
	elseif len(session("Ausercode"))=10 then
		SQL = sql & " where a.jtcode = '"& imsijtcode &"' "
	end if

	SQL = sql & " order by a.Aym desc, a.wdate desc "
'response.write sql
	rslist.PageSize=20
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if
%>

<script language="JavaScript">
<!--
function taxpage(seqval){
	window.open ('taxpage4.asp?seq='+seqval,'taxID','toolbar=no,menubar=no,scrollbars=yes,resizable=yes,width=700,height=400');
	return false ;
}

function taxpage2(seqval){
	window.open ('taxpage3.asp?seq='+seqval,'taxID','toolbar=no,menubar=no,scrollbars=yes,resizable=yes,width=700,height=700');
	return false ;
}

function onlyNumber(){
   if((event.keyCode<48)||(event.keyCode>57))
      event.returnValue=false;
}

function checkValue() {
	if (form.searcha.value=="") {
		alert("청구년월을 입력하여 주시기바랍니다.") ;
		form.searcha.focus() ;
		return false ;
	}
	if (form.searchb.value=="") {
		alert("청구년월을 입력하여 주시기바랍니다.") ;
		form.searchb.focus() ;
		return false ;
	}
	form.submit() ;
	return false ;
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
		<td><font color=blue size=3><B>[ 거래명세서 및 입금내역 ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="hlist.asp" method="POST" name=form>
	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp; <B>청구년월</td>
		<td nowrap width="84%" bgcolor="#FFFFFF"> 
        	<input type="Text" name="searcha" size="6" maxlength="6" class="box_work" value="<%=searcha%>" onkeypress="onlyNumber()">
		~
        	<input type="Text" name="searchb" size="6" maxlength="6" class="box_work" value="<%=searchb%>" onkeypress="onlyNumber()">
        	<input type="button" name="검 색" value="검 색 " class="box_work"' onclick="javascript:checkValue(this.form);">
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
		<td width=5%>번호</td>
		<td width=8%>청구년월</td>
		<td width=25%>회원사명</td>
		<td width=9%>이용료/점</td>
		<td width=8%>체인점수</td>
		<td width=13%>합계금액</td>
		<td width=10%>입금일자</td>
		<td width=10%>입금액</td>
		<td width=12%>전표출력</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i

	Aym   = left(rslist(1),4) &"/"& right(rslist(1),2)
	imoney = rslist("imoney")
	if imoney>0 then 
		imoney = formatnumber(imoney,0)
	else
		imoney = ""
	end if
	idate = rslist("idate")
	if idate<>"" then idate = mid(idate,1,4) &"/"& mid(idate,5,2) &"/"& mid(idate,7,2)
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=Aym%></td>
		<td align=left>&nbsp;<%=rslist("hname")%></td>
		<td align=right><%=formatnumber(rslist("umoney"),0)%>&nbsp;</td>
		<td><%=rslist("Anum")%></td>
		<%if rslist("accountflag")="y" then%>
			<td align=right><%=formatnumber(rslist("hmoney"),0)%>&nbsp;</td>
		<%else%>
			<td align=right><%=formatnumber(rslist("kmoney"),0)%>&nbsp;</td>
		<%end if%>


		<td><%=idate%></td>
		<td><%=imoney%></td>

		<td>
			<%if accountflag="y" then%><input type="button" name="세금" value="세금" class="box_work" onclick="javascript:taxpage('<%=rslist("CIDX")%>');"><%end if%>
			<input type=button name="거래" value="거래"   class="box_work" onclick="javascript:taxpage2('<%=rslist("seq")%>');">
		</td>
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
				<a href="hlist.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>">첫페이지</a>&nbsp;
				<a href="hlist.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="hlist.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="hlist.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>">다음 10개</a>
				&nbsp;<a href="hlist.asp?GotoPage=<%=rslist.pagecount%>&&searcha=<%=searcha%>&searchb=<%=searchb%>">마지막</a>
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