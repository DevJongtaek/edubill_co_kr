<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	imsititlename = "세금계산서"

	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select Aym,wdate,count(seq) "
	SQL = sql & " from tAccountM "
	SQL = sql & " where flag='1' "
	SQL = sql & " group by Aym,wdate "
	SQL = sql & " order by wdate desc, Aym desc "
	rslist.PageSize=20
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if
%>

<script language="JavaScript">
<!--
function excell_up()
{
	window.open ('dataup/excell_up.asp','ExcellID','width=450,height=120,left=100,top=100')
	return false ;
}

function bkinddel(val1,val2,val3,val4) {
	var msg;
	msg=confirm("정말로 모두 삭제하시겠습니까?\n청구년월 : "+ val1 +"\n등록일자 : "+ val2 +"\n등록건수 : "+ val3 +"건");
	if(msg) {
		location.href = "listdel.asp?wdate="+val4;
		return false ;
	}
}
//-->
</script>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td> &nbsp; <font color=blue size=3><B>[ <%=imsititlename%> 관리 ]</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* 전체 <B><%=rslist.recordcount%></b>개의 데이타가 있습니다.</td>
		<td width=30% align=right><input type="button" name="EXCELL" value="세금계산서등록" class="box_work" onclick="javascript:excell_up();"></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=10%>번호</td>
		<td width=20%>청구년월</td>
		<td width=40%>등록일시</td>
		<td width=10%>등록건수</td>
		<td width=20%>전표관리</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i

	Aym   = left(rslist(0),4) &"/"& right(rslist(0),2)
	wdate = mid(rslist(1),1,4) &"/"& mid(rslist(1),5,2) &"/"& mid(rslist(1),7,2) &" "& mid(rslist(1),9,2) &":"& mid(rslist(1),11,2) &":"& mid(rslist(1),13,2)
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=Aym%></td>
		<td><%=wdate%></td>
		<td><%=rslist(2)%></td>
		<td>
			<input type="button" name="조회" value="조회" class="box_work" onclick="javascript:location.href='list2.asp?stxt1=<%=rslist(0)%>&imsiwdate=<%=rslist(1)%>';">
			<input type="button" name="삭제" value="삭제" class="box_work" onclick="bkinddel('<%=Aym%>', '<%=wdate%>', '<%=rslist(2)%>', '<%=rslist(1)%>')">
		</td>
	</tr>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop 
%>

</form>

</table>


				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width=800>
	<tr height=30 align=center>
		<td>

		<% blockPage=Int((GotoPage-1)/10)*10+1
			if blockPage = 1 Then
				Response.Write "<font color=#8B9494>이전10개</font> [ "
			Else 
		%>
				<a href="list.asp?GotoPage=1">첫페이지</a>&nbsp;
				<a href="list.asp?GotoPage=<%=blockPage-10%>">이전 10개</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="list.asp?GotoPage=<%=blockPage%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="list.asp?GotoPage=<%=blockPage%>">다음 10개</a>
				&nbsp;<a href="list.asp?GotoPage=<%=rslist.pagecount%>">마지막</a>
		<% 	End If %>

		</td>
	</tr>
</table>

<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->