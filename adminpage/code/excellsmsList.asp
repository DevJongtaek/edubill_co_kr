<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=SmsList.xls"
%>

<!--#include virtual="/db/db.asp"-->
<%
	imsititlename = "�����ֹ�����"
	 searchd = request("searchd")
	 'searche = request("searche")

    if searchd="" then
		searchd =  replace(left(now(),8),"-","")
	end if

	'if searche="" then
	'	searche = replace(left(now(),10),"-","")
	'end if

	set rslist = server.CreateObject("ADODB.Recordset")

    imsitb = "em_log_" & searchd


	 sql = " select a.tran_etc2 as tcode,max(b.comname) as comname,max(c.cnt) as Order1,max(isnull(d.cnt,0)) as Order2 from "& imsitb &" as a " 

sql = sql & " join tb_company b on a.tran_etc2 = b.tcode and b.flag = '1' "

sql = sql & " left join (select count(*) as cnt,tran_etc2 from "& imsitb &" where (tran_msg like '%����%�Ϸ�%'or tran_msg like '%����%���%' or tran_msg like '%����%�Աݾ�%') group by tran_etc2) c on a.tran_etc2 = c.tran_etc2 "
sql = sql & " left join (select count(*) as cnt,tran_etc2 from "& imsitb &" where (tran_msg not like '%����%�Ϸ�%'and tran_msg not like '%����%���%' and tran_msg not like '%����%�Աݾ�%') group by tran_etc2) d on a.tran_etc2 = d.tran_etc2"
sql = sql & " where len(a.tran_etc2) =4 group by a.tran_etc2"


	rslist.Open sql, db, 1

	

%>

<html>
<body>

<table border=1>
	<tr height=28 align=center>
		<td width=5%>��ȣ</td>
		<td width=15%>�ڵ�</td>
		<td width=40%>ȸ�����</td>
		<td width="20%">�ֹ�</td>
        <td width="20%">����</td>
	</tr>

<%
i=1

do until rslist.EOF 
   
	
	
	
%>
<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=i%></td>
		<td><%=rslist("tcode")%></td>
		<td><%=rslist("comname")%></td>
      <td><%=rslist("Order1")%></td>
        <td><%=rslist("Order2")%></td>
	</tr>

<%
rslist.MoveNext 
i=i+1

loop
%>
	

</table>

<%
	rslist.close
	db.close
	set rs=nothing
	set rslist=nothing
	set db=nothing
%>

</body>
</html>