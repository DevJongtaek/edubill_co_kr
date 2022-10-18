<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=Sheet1.xls"
%>

<!--#include virtual="/db/db.asp"-->

<%
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select substring(mentout,3,len(mentout)) as mentout from tb_adminuser where userid = 'root' "
	rslist.Open sql, db, 1
	mentout = replace(trim(rslist(0))," ","")
	rslist.close
	if mentout<>"" then
		mentout_array = split(mentout)
		set rslist = server.CreateObject("ADODB.Recordset")
		SQL = " select idx from tb_company where flag='1' and tcode in ( "
			for i=0 to ubound(mentout_array)
				if i=0 then
					SQL = SQL & " "& mentout_array(i) &" "
				else
					SQL = SQL & ", "& mentout_array(i) &" "
				end if
			next
		SQL = SQL & " ) "
		rslist.Open sql, db, 1
		if not rslist.eof then
			i=1
			do until rslist.eof 
				if i=1 then
					idx_array = rslist(0)
				else
					idx_array = idx_array & "," & rslist(0)
				end if
			rslist.movenext
			i=i+1
			loop
		end if
		rslist.close
	end if
	idx_arrayint = ""
	if idx_array<>"" then
		idx_array = replace(trim(idx_array)," ","")
		idx_array = split(idx_array)
		idx_arrayint = ubound(idx_array)
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,wdate,userid,usercode,flag,gubun,code,content "
	SQL = sql & " from tb_log "
	SQL = sql & " where userid <> 'erp' "
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if idx_arrayint<>"" then
		SQL = sql & " and substring(usercode,1,5) not in ( "
			for i=0 to idx_arrayint
				if i=0 then
					SQL = sql & " "& idx_array(i) &" "
				else
					SQL = sql & " , "& idx_array(i) &" "
				end if
			next
		SQL = sql & " ) "
	end if
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	SQL = sql & " order by wdate desc"
	rslist.Open sql, db, 1
%>

<html>
<style type="text/css">
<!--
td.accountnum
{mso-number-format:\@}
-->
</STYLE>
<body>

<table border=1>
	<tr height=28 align=center>
		<td width=20%>date</td>
		<td width=9%>id</td>
		<td width=20%><font color=blue>chain</td>
		<td width=20%><font color=blue>chainname</td>
		<td width=7%><font color=blue>type</td>
		<td width=7%>gubun</td>
		<td width=7%><font color=blue>code</td>
		<td width=23%><font color=blue>codename</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF

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

	<tr height=22>
		<td class=accountnum><%=imsiimsiday%></td>
		<td class=accountnum><%=rslist(2)%></td>
		<td class=accountnum><%=imsitcode%></td>
		<td class=accountnum><%=imsicomname%></td>
		<td class=accountnum><%=rslist(4)%></td>
		<td class=accountnum><%=imsifont%><%=rslist(5)%></td>
		<td class=accountnum><%=cstr(rslist(6))%></td>
		<td class=accountnum><%=replace(replace(rslist(7),"(",","),")",",")%></td>
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



<%
	db.close
	set db=nothing
%>

</body>
</html>