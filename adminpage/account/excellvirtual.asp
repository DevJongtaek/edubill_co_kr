<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=virtual.xls"
%>

<!--#include virtual="/db/db.asp"-->
<%
	imsititlename = "가상계좌정산"
	stxt1 = request("stxt1")
	'stxt2 = request("stxt2")
	imsiwdate = request("imsiwdate")

	'if stxt2="" then
'		stxt2 = "Aym"
	'end if
	if stxt1="" then
		stxt1 = replace(left(now(),7),"-","")
	end if

   ' if
	

	'GotoPage = Request("GotoPage")
	'if GotoPage = "" then
	'	GotoPage = 1
	'end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select max(a.tr_il) as tr_il,  a.cporg_cd, max(a.cnt) as cnt,max(b.comname)  as comname from "

SQL = sql & "(select count(cporg_cd) as cnt, cporg_cd,max(substring(tr_il,1,4)+'/'+substring(tr_il,5,2)) as tr_il from tb_virtual_acnt where dep_st ='1' and substring(tr_il,1,6)='"& stxt1 &"' group by cporg_cd  )  as a "
SQL = sql & "join (select  cporg_cd, comname from tb_company where flag='1' and cporg_cd != '') as b on a.cporg_cd = b.cporg_cd "
SQL = sql & "group by  a.cporg_cd order by b.comname "
	'rslist.PageSize=20
'response.write sql

	rslist.Open sql, db, 1

	'if not rslist.bof then
	'	rslist.AbsolutePage=int(gotopage)
	'end if

%>

<html>
<body>

<table border=1>
	<tr height=28 align=center>
		<td width=5%>번호</td>
		
		<td width=8%>입금년월</td>
        <td width=17%>기관코드</td>
		<td width=21%>체인본부</td>
		
		<td width=8%>건수</td>
		<td width=37%>비고</td>
	</tr>

<%
hap_kmoney = 0
hap_smoney = 0
hap_hmoney = 0
i=1

do until rslist.EOF

	
    tr_il = rslist("tr_il")
	cporg_cd = rslist("cporg_cd")
	comname = rslist("comname")
    cnt = rslist("cnt")
 
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=i%></td>
		<td style="mso-number-format:'\@'"><%=tr_il%></td>
		<td><%=cporg_cd%></td>
		<td align=left>&nbsp;<%=comname%></td>
		<td align=right><%=formatnumber(rslist("cnt"),0)%></td>
		<td></td>
	</tr>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop 
%>

	

</table>

<%
	db.close
	set db=nothing
%>

</body>
</html>