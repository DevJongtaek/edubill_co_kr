<HTML>
<HEAD>
<LINK REL="StyleSheet" TYPE="text/css" HREF="../common/StyleSheet.css">
<title>보낸 메시지함</title>
<script language="JavaScript">
function calc_del(form) {
	var number = 0;
	var check = form.cnt.value;
	for (k=0 ; k <= check; k++) {
		if (form.elements[k].checked == true)
			number++;
		}
	if (number ==0 ) {
		alert("아무것도 선택하지 않으셨습니다.\r\n" 
		+ "삭제할 메시지를 선택해 주십시오.");
		return false;
	}
	if (number > 0) {
		c = confirm(number + "개의 메시지를 삭제합니다.\r\n"
		+ "정말 삭제하시겠습니까?");
		if (c != "0") {
			form.submit();
		}
		return false;
	}
	return false;
}

function toggle_all(form) {
	var check = form.cnt.value;
	if (window.event.srcElement.innerHTML == "모두선택")
	{
		for (k=0 ; k < check; k++)
			form.elements[k].checked = true;
		window.event.srcElement.innerHTML = "선택끄기";
	}
	else
	{
		for (k=0; k < check; k++)
			form.elements[k].checked = false;
		window.event.srcElement.innerHTML = "모두선택";
	}
		
	return false;
}
</script>
</HEAD>
<BODY leftmargin=40 marginwidth=40 bgcolor="white">

<!-- 메뉴바 -->
<CENTER><br><br>
<P><font face="굴림" size="4"><B>E M M A</B></font></p>
<P>
<A HREF="./send_msg.asp"><font face="굴림" size="2">메시지보내기</font></A>
<B>|</B>
<A HREF="./SentMailbox.asp"><font face="굴림" size="2">보낸메시지함</font></A>
<B>|</B>
<A HREF="./ReservMailbox.asp"><font face="굴림" size="2">예약메시지함</font></A>
<B>|</B>
<A HREF="./addrlist.asp"><font face="굴림" size="2">주소록</font></A>
<B>|</B>
<A HREF="./logout.asp"><font face="굴림" size="2">로그아웃</font></A>
</P>
</CENTER>

<!-- #include file = "./DBConnect.inc"  -->
<CENTER>
<%
officenum = session("sessionid")

if Request("page")="" then
	curpage=1
else
	curpage=cint(Request("page"))
end if

if Request("startpage")="" then
	startpage=1
else
	startpage=cint(Request("startpage"))
end if

ipp=10
ten=5

yea=YEAR(NOW)
mon=MONTH(NOW)
if mon < 10 then
	mon= "0" & mon
end if
cur_log=yea & mon

'sql = "if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[em_log_" & cur_log & "]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) CREATE TABLE em_log_" & cur_log & " (tran_pr int NOT NULL identity(1,1),	tran_refkey varchar(20) default NULL,	tran_id varchar(20) default NULL, tran_phone varchar(15) NOT NULL default '', tran_callback varchar(15) default NULL, tran_status char(1) default NULL, tran_date datetime NOT NULL default '0000-00-00 00:00:00', tran_rstdate datetime default NULL, tran_reportdate datetime default NULL, tran_rslt char(1) default NULL, tran_msg varchar(255) default NULL, tran_etc1 varchar(64) default NULL, tran_etc2 varchar(16) default NULL, tran_etc3 varchar(16) default NULL, tran_etc4 int default NULL, tran_type int NOT NULL default '0', PRIMARY KEY (tran_pr))"
'set rs = DBConn.Execute(sql)

Set DbRec=Server.CreateObject("ADODB.Recordset")
DbRec.CursorType=1
DbRec.Open "SELECT tran_date, tran_msg, tran_etc1, tran_etc4 FROM em_log_" & cur_log & " WHERE tran_id = '" & officenum & "' AND tran_pr=tran_etc4 AND tran_date <= getdate() AND ( tran_etc3 IS NULL or SUBSTRING(tran_etc3,3,1) <> 'D') and (tran_status='2' or tran_status='3') UNION SELECT tran_date, tran_msg, tran_etc1, tran_etc4 FROM em_tran WHERE tran_id = '" & officenum & "' AND tran_pr=tran_etc4 AND tran_date <= getdate() AND ( tran_etc3 IS NULL or SUBSTRING(tran_etc3,3,1) <> 'D') order by tran_etc4 ASC", DBConn

if DbRec.BOF or DbRec.EOF then
%>
  <table width="600" border="0" cellspacing="1">
    <tr>
      <td colspan=3 align=left class="tblNoColor">
	  <font face="굴림" size="2">총 0 개의 메시지</font></td>
      <td colspan=3 align=right class="tblNoColor">
	  	<font face="굴림" size="2" color=red>
	  Page 1/1</font>
	  </td>
    </tr>
  </table>
  <table border="0" ><tr><td>
  <table width= 600 border="0" cellpadding="3" cellspacing="2">
    <tr> 
      <td bgcolor="#aa8c9b" WIDTH=150 align="center"><font face="굴림" size="2" color="#FFFFFF">작성시간</font></td>
      <td bgcolor="#aa8c9b" WIDTH=100 align="center"><font face="굴림" size="2" color="#FFFFFF">수신자</font></td>
      <td bgcolor="#aa8c9b" align="center"><font face="굴림" size="2" color="#FFFFFF">내용</font></td>
      <td bgcolor="#aa8c9b" WIDTH=30 align="center"><font face="굴림" size="2" color="#FFFFFF">선택</font></td>
	</tr>
	
    <tr> 
      <td colspan=4 align="center"><font face="굴림" size="2">보낸 메시지가 없습니다.</font></td>
	</tr>
	</table>
	</td></tr>
	</table>
<%
else
DbRec.MoveLast
postcount=DbRec.Recordcount

totpage=int(postcount/ipp)
totpage=cint(totpage)


if(totpage * ipp) <> postcount then totpage = totpage + 1

For a=1 to (curpage-1) * ipp
	DbRec.MovePrevious
Next 

pg=Request.QueryString("page")

if isEmpty(pg) then
	pg=1
else
	pg=pg+0
end if

if pg<1 then
	pg=1
end if

lastpg=1+Int((postcount-1)/ipp)

if pg>lastpg then
	pg=lastpg
end if

nextpg=pg+1
prevpg=pg-1
endpg=pg*ipp
startpg=endpg-ipp+1

cpage=curpage - 1
n = postcount - cpage*ipp 

%>

<FORM name="mainform" method="POST" 	action="DeleteSentMail.asp">
  <table width="600" border="0" cellspacing="1">
    <tr>
      <td colspan=3 align=left class="tblNoColor">
	  <font face="굴림" size="2">총 <%=postcount%> 개의 메시지</font></td>
      <td colspan=3 align=right class="tblNoColor">
	  	<font face="굴림" size="2" color=red>
	  Page <%=curpage%>/<%=lastpg%></font>
	  </td>
    </tr>
  </table>
  <table border="0" ><tr><td>
  <table width= 600 border="0" cellpadding="3" cellspacing="2">
    <tr> 
      <td bgcolor="#aa8c9b" WIDTH=150 align="center"><font face="굴림" size="2" color="#FFFFFF">작성시간</font></td>
      <td bgcolor="#aa8c9b" WIDTH=100 align="center"><font face="굴림" size="2" color="#FFFFFF">수신자</font></td>
      <td bgcolor="#aa8c9b" align="center"><font face="굴림" size="2" color="#FFFFFF">내용</font></td>
      <td bgcolor="#aa8c9b" WIDTH=30 align="center"><font face="굴림" size="2" color="#FFFFFF">선택</font></td>
	</tr>
	<%
	For i = 1 to ipp
		if totpage = curpage then
			value = postcount Mod ipp
			if i > value and value <> 0 then
				Exit For
			end if
		end if
	%>
    <tr> 
      <td align="center"><font face="굴림" size="2"><%=DbRec("tran_date")%></font></td>
      <td align="center"><font face="굴림" size="2"><%=DbRec("tran_etc1")%></font></td>
      <td align="center"><font face="굴림" size="2"><a href="ViewSentMail.asp?msgkey=<%=DbRec("tran_etc4")%>&page=<%=pg%>&startpage=<%=startpage%>"><%=DbRec("tran_msg")%></a></font></td>
      <td align="center" WIDTH=30><input type="checkbox" name="<%=DbRec("tran_etc4")%>" value="on"></td>
	</tr>
	<%
	n=n-1
	DbRec.MovePrevious
	Next
	%>

</table>
</td></tr></table>
  <table width="600" border="0" cellspacing="1">
  <tr>
    <td  class="tblNoColor" align="center"> <br><font face="굴림" size="2">
	[<a href="/삭제" onClick="calc_del(document.mainform);return false;">삭제</a>]
	[<a href="/모두선택" name="toggle" onClick="toggle_all(document.mainform);return false;">모두선택</a>] </font>
<% if totpage>ten then %> 
	<% if startpage=1 then %>
		</font><font color="#808000" size="2" face="굴림">Prev</font><font color="#000000" size="2">  
	<%else%> 
		<a href="SentMailbox.asp?page=1&amp;startpage=1" >처음</a>
		<a href="SentMailbox.asp?page=<%=cint(startpage)-1%>&amp;startpage=<%=cint(startpage)-ten%>" > Prev</a> 
	<%end if%>
	<%
	For a=startpage to startpage+ten-1
	if a>totpage then
		exit for
	else if a=curpage then
	%>
		<font color="#ff0000" size="2"> <%=a%> </font>
		<%else%> 
		<a href="SentMailbox.asp?page=<%=a%>&amp;startpage=<%=startpage%>" ><%=a%></a>
		<%End if%>
	<%end if%>

	<%Next%>
		<%if((startpage\ten)=(totpage\ten)) then%> 
			</font><font color="#808000" size="2" face="굴림">Next</font><font color="#000000" size="2">
		<%else%>
			<%if lastpg = a-1 then%>
				<font color="#808000" size="2" face="굴림">Next</font><font color="#000000" size="2">
			<%else%>
				<a href="SentMailbox.asp?page=<%=a%>&amp;startpage=<%=a%>" > Next </a>
				<%if (lastpg mod ten)=0 then %>
					<a href="SentMailbox.asp?page=<%=lastpg%>&amp;startpage=<%=(lastpg\ten)*ten-(ten-1)%>" >마지막</a>
				<%else%>
					<a href="SentMailbox.asp?page=<%=lastpg%>&amp;startpage=<%=(lastpg\ten)*ten+1%>" >마지막</a>
				<%end if%>
			<%end if%>
		<%end if%>
	<%else%></font>
		<font color="#808000" size="2" face="굴림">Prev</font><font color="#000000" size="2">
	<%
	For a=startpage to totpage
		if a=curpage then%><font color="RED"><%=a%></font>
		<%else%> <a href="SentMailbox.asp?page=<%=a%>" ><%=a%></font></a> 
	<%	
		end if
	next%>  </font>
		<font color="#808000" size="2" face="굴림">Next</font><font color="#000000" size="2">  
<%end if%></font>
	</td>
  </tr>
  </table>
	<% if lastpg=curpage then %>
		<% if value <> 0 then %>
			<INPUT TYPE="HIDDEN" NAME="cnt" VALUE="<%=value%>">
		<% else %>
			<INPUT TYPE="HIDDEN" NAME="cnt" VALUE="<%=ipp%>">
		<% end if %>
	<% else %>
		<INPUT TYPE="HIDDEN" NAME="cnt" VALUE="<%=ipp%>">
	<% end if %>
		<INPUT TYPE="HIDDEN" NAME="lastpg" VALUE="<%=lastpg%>">
		<INPUT TYPE="HIDDEN" NAME="page" VALUE="<%=pg%>">
		<INPUT TYPE="HIDDEN" NAME="startpage" VALUE="<%=startpage%>">
		<INPUT TYPE="HIDDEN" NAME="ten" VALUE="<%=ten%>">
</FORM>
<% end if %>
</BODY>
</CENTER>
</HTML>
