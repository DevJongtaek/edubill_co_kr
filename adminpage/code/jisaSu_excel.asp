<%
	Session.TimeOut	= 1000
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=excell.xls"
%>
<!--#include virtual="/db/db.asp"-->
<%
	searchd = request("searchd")
	searche = request("searche")
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if searchd="" then searchd = replace(left(now()-31,10),"-","")
	if searche="" then searche = replace(left(now(),10),"-","")
	linksql = "searchd="&searchd&"&searche="&searche
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	sessionSql1 = "bidxsub = "& left(session("Ausercode"),5) &" and idxsub = "& mid(session("Ausercode"),6,5) &" "
	sessionSql2 = "substring(a.usercode,1,10) = '"& mid(session("Ausercode"),1,10) &"' "
	sessionSql3 = "a.orderday >= '"& searchd &"' and a.orderday <= '"& searche &"' "
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	sql = " select comname from tb_company where idx = "& mid(session("Ausercode"),6,5) &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsicname = rs(0)
	end if
	rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	sql = " select "
	SQL = sql & " 	aa.tcode, aa.comname, aa.name, aa.wdate, "
	SQL = sql & " 	isnull(bb.pcnt,0), isnull(bb.hapmoney,0), bb.usercode "
	SQL = sql & " from "
	SQL = sql & " ( "
	SQL = sql & " select bidxsub as bcode, idxsub as mcode, idx as scode, tcode,comname,name,substring(wdate,1,10) as wdate "
	SQL = sql & " from tb_company "
	SQL = sql & " where flag = '3' "	'���ϻ�����
	SQL = sql & " and " & sessionSql1
	SQL = sql & " ) aa "
	SQL = sql & " right outer join "
	SQL = sql & " ( "
	SQL = sql & " select a.usercode, sum(b.rordernum) as pcnt, sum(b.rordernum*b.pprice) as hapmoney "
	SQL = sql & " from tb_order a, tb_order_product b "
	SQL = sql & " where a.idx = b.idx "
	SQL = sql & " and " & sessionSql2
	SQL = sql & " and b.flag = 'T'  "
	SQL = sql & " and " & sessionSql3
	SQL = sql & " group by a.usercode "
	SQL = sql & " ) bb "
	SQL = sql & " on aa.bcode = substring(bb.usercode,1,5) and aa.mcode = substring(bb.usercode,6,5) and aa.scode = substring(bb.usercode,11,5) "
	SQL = sql & " order by aa.tcode asc "
	rs.Open sql, db, 1
	if not rs.eof then
		groupArr = rs.GetRows
		groupArrint = ubound(groupArr,2)
	else
		groupArrint = ""
	end if
	rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	sql = " select "
	sql = sql & " 	aa.comname, aa.tcode,  "
	sql = sql & " 	bb.orderday, bb.pcode, bb.pname, cc.ptitle , isnull(bb.pprice,0) as pprice, isnull(bb.pcnt,0) as pcnt, isnull(bb.hapmoney,0) as hapmoney "
	sql = sql & " from "
	sql = sql & " ( "
	sql = sql & " select bidxsub as bcode, idxsub as mcode, idx as scode, tcode,comname "
	sql = sql & " from tb_company "
	sql = sql & " where flag = '3' "
	sql = sql & " and " & sessionSql1
	sql = sql & " ) aa "
	sql = sql & " right outer join "
	sql = sql & " ( "
	sql = sql & " select a.usercode, a.orderday, b.pcode, b.pname, sum(b.pprice) as pprice, sum(b.rordernum) as pcnt, sum(b.rordernum*b.pprice) as hapmoney "
	sql = sql & " from tb_order a, tb_order_product b "
	sql = sql & " where a.idx = b.idx "
	sql = sql & " and " & sessionSql2
	sql = sql & " and b.flag = 'T'  "
	sql = sql & " and " & sessionSql3
	sql = sql & " group by a.usercode, a.orderday, b.pcode, b.pname "
	sql = sql & " ) bb "
	sql = sql & " on aa.bcode = substring(bb.usercode,1,5) and aa.mcode = substring(bb.usercode,6,5) and aa.scode = substring(bb.usercode,11,5) "

	sql = sql & " left outer join "
	sql = sql & " ( select pcode,ptitle from tb_product where substring(usercode,1,5) = '"& mid(session("Ausercode"),1,5) &"' ) cc "
	sql = sql & " on bb.pcode = cc.pcode "
	sql = sql & " order by aa.tcode asc, bb.orderday asc, bb.pcode asc "
	rs.Open sql, db, 1
	if not rs.eof then
		PrivateArr = rs.GetRows
		PrivateArrint = ubound(PrivateArr,2)
	else
		PrivateArrint = ""
	end if
	rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>

<html>
<head>
<title>edubill.co.kr</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<style type="text/css">
<!--
td.accountnum
{mso-number-format:\@}
-->
</STYLE>
</head>

<table width='700' border="0" align="center">
	<tr height="47">
		<td align=center colspan=7><font size=3><B> ������ ���곻�� (<%=imsicname%>)</td>
	</tr>
</table>

<table width='700' border="0" align="center">
	<tr height="47">
		<td colspan=7>* ����Ⱓ : <%=mid(searchd,1,4)%>/<%=mid(searchd,5,2)%>/<%=mid(searchd,7,2)%> ~ <%=mid(searche,1,4)%>/<%=mid(searche,5,2)%>/<%=mid(searche,7,2)%></td>
	</tr>
</table>

<table border=0 width='700'><tr height=20><td colspan=7><B>[ ü������ �հ�ǥ ]</td></tr></table>

<table border=1 width='700'>
	<tr height=25 align=center>
		<td>��ȣ</td>
		<td>ü�����ڵ�</td>
		<td>ü������</td>
		<td>��ǥ��</td>
		<td>�������</td>
		<td>�ڽ��հ�</td>
		<td>�������հ�</td>
	</tr>

<%
	if groupArrint<>"" then
		hap1 = 0
		hap2 = 0
		for i=0 to groupArrint
			hap1 = cdbl(hap1)+cdbl(groupArr(4,i))
			hap2 = cdbl(hap2)+cdbl(groupArr(5,i))
%>

			<tr height=20 align=center>
				<td class='accountnum'><%=i+1%></td>
				<td class='accountnum'><%=groupArr(0,i)%></td>
				<td class='accountnum' align=left>&nbsp;<%=groupArr(1,i)%></td>
				<td class='accountnum'><%=groupArr(2,i)%></td>
				<td class='accountnum'><%=replace(groupArr(3,i),"-","/")%></td>
				<td class='accountnum' align=right><%=formatnumber(groupArr(4,i),0)%></td>
				<td class='accountnum' align=right><%=formatnumber(groupArr(5,i),0)%></td>
			</tr>

<%
		next
	end if
%>

	<tr height=25 align=center>
		<td class='accountnum' colspan=5>�� ��</td>
		<td class='accountnum' align=right><%=formatnumber(hap1,0)%></td>
		<td class='accountnum' align=right><%=formatnumber(hap2,0)%></td>
	</tr>
</table>

<BR>


<%
	if PrivateArrint<>"" then
		hap1=0
		hap2=0
		for i=0 to PrivateArrint
			imsihtm = "<table width='700' border='0'><tr height=20><td colspan=7><B>["& PrivateArr(0,i) &" ("& PrivateArr(1,i) &")]</td></tr></table>"
			imsihtm = imsihtm & " <table border=1 width='700'>"
			imsihtm = imsihtm & " 	<tr height=25 align=center>"
			imsihtm = imsihtm & " 		<td>����</td>"
			imsihtm = imsihtm & " 		<td>��ǰ�ڵ�</td>"
			imsihtm = imsihtm & " 		<td>��ǰ��</td>"
			imsihtm = imsihtm & " 		<td>�԰�</td>"
			imsihtm = imsihtm & " 		<td>�ܰ�</td>"
			imsihtm = imsihtm & " 		<td>�ڽ�</td>"
			imsihtm = imsihtm & " 		<td>������</td>"
			imsihtm = imsihtm & " 	</tr>"
			'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			newTcode = PrivateArr(1,i)
			if i=0 or newTcode<>oldTcode then
				if i>0 then 
					response.write "<tr height=25 align=center> "
					response.write "		<td class='accountnum' colspan=5>�� ��</td> "
					response.write "		<td class='accountnum' align=right>"& formatnumber(hap1,0) &"</td> "
					response.write "		<td class='accountnum' align=right>"& formatnumber(hap2,0) &"</td> "
					response.write "	</tr> "
					response.write "</table><BR>"
					hap1=0
					hap2=0
				end if
				response.write imsihtm
			end if
			hap1 = cdbl(hap1) + cdbl(PrivateArr(7,i))
			hap2 = cdbl(hap2) + cdbl(PrivateArr(8,i))
%>

				<tr height=20 align=center>
					<td class='accountnum'><%=int(mid(PrivateArr(2,i),5,2))%>/<%=int(right(PrivateArr(2,i),2))%></td>
					<td class='accountnum'><%=PrivateArr(3,i)%></td>
					<td class='accountnum' align=left>&nbsp;<%=PrivateArr(4,i)%></td>
					<td class='accountnum'><%=PrivateArr(5,i)%></td>
					<td class='accountnum' align=right><%=formatnumber(PrivateArr(6,i),0)%></td>
					<td class='accountnum' align=right><%=formatnumber(PrivateArr(7,i),0)%></td>
					<td class='accountnum' align=right><%=formatnumber(PrivateArr(8,i),0)%></td>
				</tr>
<%
			oldTcode = newTcode
		next
	end if

	response.write "<tr height=25 align=center> "
	response.write "		<td class='accountnum' colspan=5>�� ��</td> "
	response.write "		<td class='accountnum' align=right>"& formatnumber(hap1,0) &"</td> "
	response.write "		<td class='accountnum' align=right>"& formatnumber(hap2,0) &"</td> "
	response.write "	</tr> "
	response.write "</table><BR>"
%>

<%
	db.close
	set db=nothing
%>

</body>
</html>