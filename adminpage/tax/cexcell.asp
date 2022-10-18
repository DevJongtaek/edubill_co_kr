<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=order.xls"
%>

<!--#include virtual="/db/db.asp"-->

<%
	'--------------------------------------------------------------------------------------------------------------------
	'# ��¥���� �Լ�
	'# FunYMDHMS(dflag)	����Ͻú��� �������� �Լ�
	'#    			4:yyyy    6:yyyymm    8:yyyymmdd    10:yyyymmddhh    12:yyyymmddhhmm    14:yyyymmddhhmmss
	'# DateFormatReplace	20090605123541 -->> 2009-06-05 12:35:41
	'#    			psDate:����Ÿ	psDateflag:��¥���а�	psDategubun:1=��¥��ü 2=�ð���
	'# SelectDateChoice	����� �޺��ڽ�
	'#    			yearDa:�⵵��    monthDa:����    dayDa:�ϰ�    yvalD:�⵵�̸�    mvalD:���̸�    dvalD:���̸�
	'# alertURL	 �̵��� �ּ�
	'--------------------------------------------------------------------------------------------------------------------
	Function DateFormatReplace(psDate,psDateflag,psDategubun)
		if psDateflag="" then
			psDateflag = "-"
		end if
		if psDategubun="" then
			psDategubun = "1"
		end if

		if psDategubun="1" then
	        	if IsNull(psDate) OR Len(psDate)=0 then 
        	        	DateFormatReplace="" 
        		elseif Len(psDate)=6 then 
      	          		DateFormatReplace = Left(psDate,4) & psDateflag & Right(psDate,2) 
        		elseif Len(psDate)=8 then 
                		DateFormatReplace = Left(psDate,4) & psDateflag & Mid(psDate,5,2) & psDateflag & Right(psDate,2) 
  			elseif Len(psDate)=12 then 
                		DateFormatReplace = Left(psDate,4) & psDateflag & Mid(psDate,5,2) & psDateflag & mid(psDate,7,2) & " " & mid(psDate,9,2) & ":" & right(psDate,2) 
  			elseif Len(psDate)=14 then 
                		DateFormatReplace = Left(psDate,4) & psDateflag & Mid(psDate,5,2) & psDateflag & mid(psDate,7,2) & " " & mid(psDate,9,2) & ":" & mid(psDate,11,2)  & ":" & mid(psDate,13,2)
			else 
	                	DateFormatReplace = psDate 
        		end if 
		else
	        	if IsNull(psDate) OR Len(psDate)=0 then 
        	        	DateFormatReplace="" 
        		elseif Len(psDate)=4 then 
                		DateFormatReplace = mid(psDate,1,2) & ":" & mid(psDate,3,2)
        		elseif Len(psDate)=6 then 
                		DateFormatReplace = mid(psDate,1,2) & ":" & mid(psDate,3,2) & ":" & mid(psDate,5,2)
			else 
	                	DateFormatReplace = psDate 
        		end if 
		end if
	End Function 
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")

	if searchg="" then
		searchg = "0"
	end if
	if searchc="" then
		searchc = "0"
	end if
	if searchf="" then
		searchf = "0"
	end if

	if searchd="" then
		searchd = replace(left(now()-1,10),"-","")
	end if

	if searche="" then
		searche = replace(left(now(),10),"-","")
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	sql = " select cporg_cd from tb_company where idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
	btcode = rs(0)
	rs.close
	if len(session("Ausercode"))=15 then
		set rs = server.CreateObject("ADODB.Recordset")
		sql = " select tcode from tb_company where idx = "& right(session("Ausercode"),5) &" "
		rs.Open sql, db, 1
		ctcode = rs(0)
		rs.close
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'sql = " select * from tb_virtual_acnt "                     2011.04.05 ���ϻ����ڵ� �߰�
	'SQL = sql & " where cporg_cd = '"& btcode &"' "
	set rslist = server.CreateObject("ADODB.Recordset")
	sql = " select * from tb_virtual_acnt A "
	SQL = sql & " left  join (select tcode, fileregcode from tb_company where bidxsub = '"& left(session("Ausercode"),5) &"') B "
	SQL = sql & " on A.chancode = B.tcode "
	SQL = sql & " where cporg_cd = '"& btcode &"' "

	if session("Ausergubun")="4" and ctcode<>"" then	'ü����
		SQL = sql & " and chancode = '"& ctcode &"' "
	end if

	if searchd<>"" then
		SQL = sql & " and tr_il >= '"& searchd &"' "
	end if
	if searche<>"" then
		SQL = sql & " and tr_il <= '"& searche &"' "
	end if
	if searcha<>"" and searchb<>"" then
		SQL = sql & " and "& searcha &" like '%"& searchb &"%' "
	end if

	if searchc="1" then
		SQL = sql & " and (ye_money-mi_money) >= 0 "
	elseif searchc="2" then
		SQL = sql & " and (ye_money-mi_money) < 0 "
	end if

	SQL = sql & " order by tr_il desc, tr_si desc, channame asc "
	rslist.Open sql, db, 1
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
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

<body>

<table border=1>
	<tr align=center height=25>
		<td>����</td>
		<td>�ð�</td>
		<td>�������</td>
		<td>�Աݾ�</td>
		<td>�����</td>
		<td>�Ա���</td>

		<td>ü�����ڵ�</td>
		<td>���ϻ����ڵ�</td>
		<td>ü������</td>
		<td>���ű�</td>
		<td>�̼���</td>
		<td>�ֹ�</td>
	</tr>

<%
i=1
do until rslist.EOF
	if rslist("ye_money")-rslist("mi_money") >= 0 then
		imsitmsg = "<font color=blue>���"
	else
		imsitmsg = "<font color=red>����"
	end if
%>

	<tr height=25 align=center>
		<td><%=rslist("tr_il")%></td>
		<td><%=rslist("tr_si")%></td>
		<td class="accountnum"><%=cstr(rslist("va_no"))%></td>
		<td><%=rslist("dep_amt")%></td>
		<td><%=rslist("depbnk_nm")%></td>
		<td><%=rslist("cust_nm")%></td>
		<td class="accountnum"><%=rslist("chancode")%></td>
		<td><%=rslist("fileregcode")%></td>
		<td><%=rslist("channame")%></td>
		<td><%=rslist("ye_money")%></td>
		<td><%=rslist("mi_money")%></td>
		<td><%=imsitmsg%>&nbsp;</td>
	</tr>

<%
rslist.MoveNext 
i=i+1
loop
%>

</table>


<%
	db.close
	set db=nothing
%>

</body>
</html>