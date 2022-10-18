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
	Function regsendval(val)
		regsend1 = "0,1,A,B,C,D,2,A,B,C,D,E,F,G,H,I,J"
		regsend2 = "����,Time Out,ȣó����,��������,Power off,������ʰ�,�߸��ȹ�ȣ,�Ͻ�����,��Ÿ����,���Ű���,��Ÿ,���Ŀ���,���Ŀ���,�Ұ��ܸ���,ȣ�Ұ�����,�޽�������,Que Full"
		regsend1array = split(regsend1,",")
		regsend2array = split(regsend2,",")
		if val<>"" then
			imsii = ""
			for k=0 to ubound(regsend1array)
				if trim(regsend1array(k))=val then
					regsendval = regsend2array(k)
					exit for
				end if
			next
		end if
	End Function 

	Function FunHPCut(Hvalnum)	'�ڵ�����ȣ0111111111->011-111-1111
		if Hvalnum<>"" and len(Hvalnum)>=10 then
			imsilenhp  = len(Hvalnum)	'��ü����
			imsilenhp1 = left(Hvalnum,3)	'��Ż��ȣ
			imsilenhp2 = mid(left(Hvalnum,(imsilenhp-4)),4)	'����
			imsilenhp3 = right(Hvalnum,4)	'��ȭ��ȣ
			FunHPCut = imsilenhp1&"-"&imsilenhp2&"-"&imsilenhp3
		end if
	End Function

	Function Fundate(Hval)
		if Hval<>"" then
			DATE_MD = Right(Replace(FormatDateTime(Hval,2),"-",""),4)
			DATE_Y  = MID(Replace(FormatDateTime(Hval,2),"-",""),1,4)
			B_DATE  = DATE_Y & DATE_MD 	'���ϳ�
			B_TIME  = left(Replace(FormatDateTime(Hval,4),":",""),6)&Right("00" & second(Hval),2)  '�ú���
			IntTime = B_DATE &  B_TIME
		end if
		Fundate = IntTime
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
	if searchd="" then
		searchd = replace(left(now()-1,10),"-","")
	end if

	if searche="" then
		searche = replace(left(now(),10),"-","")
	end if
	searchdd = mid(searchd,1,4)&""&mid(searchd,5,2)&""&mid(searchd,7,2)
	searchee = mid(searche,1,4)&""&mid(searche,5,2)&""&mid(searche,7,2)
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode from tb_company where flag='1' and idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
	if not rs.eof then
		btcode = rs(0)
		'btcode = "9074"
	end if
	rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode,comname from tb_company where flag='3' and bidxsub = "& left(session("Ausercode"),5) &" order by comname asc"
	rs.Open sql, db, 1
	if not rs.eof then
		carray = rs.GetRows
		carrayint = ubound(carray,2)
	else
		carray = ""
		carrayint = ""
	end if
	rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	imsitb = "em_log_"
	syymm = int(left(searchd,6))	'200901
	eyymm = int(left(searche,6))	'200901
	's_imsitb = imsitb & syymm
	'e_imsitb = imsitb & eyymm
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	for i=syymm to eyymm
		if i=syymm then 
			s_imsitb = imsitb & syymm
		else
			s_imsitb = imsitb & (syymm+1)
		end if
		tbsql = tbsql & " select * from "& s_imsitb &" where tran_etc2 = '"& btcode &"' "
		if searcha<>"" and searchb<>"" then tbsql = tbsql & " and "& searcha &" like '%"& searchb &"%' "
		if searchc<>"" then tbsql = tbsql & " and tran_etc3 = '"& searchc &"' "
		if searchf="y" then 
			tbsql = tbsql & " and tran_rslt  = '0' "
		elseif searchf="n" then 
			tbsql = tbsql & " and tran_rslt  <> '0' "
		end if
		if i<eyymm then tbsql = tbsql & " union all "
	next
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rslist = server.CreateObject("ADODB.Recordset")
	sql = " select a.*, b.comname,b.tcode from ("& tbsql &") a "

	sql = sql & " left outer join "
	sql = sql & " (select comname,tcode from tb_company where flag='3' and bidxsub = (select idx from tb_company where flag='1' and tcode = '"& btcode &"') ) b "
	sql = sql & " on a.tran_etc3 = b.tcode "
	sql = sql & " where a.tran_date BETWEEN '"& searchdd &"' and '"& searchee &"' "

	sql = sql & " order by tran_pr asc "
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
	<tr height=28 align=center>
		<td>��ȣ</td>
		<td>�ڵ�����ȣ</td>
		<td>���۰��</td>
		<td>�����Ͻ�</td>
		<td>��Ż�</td>
		<td>�޼���</td>


		<td>ü�κ����ڵ�</td>
		<td>ü�����ڵ�</td>
	</tr>

<%
i=1
do until rslist.EOF
	tran_rslt  = regsendval(replace(trim(rslist("tran_rslt"))," ",""))
	tran_phone = FunHPCut(rslist("tran_phone"))

	tran_date = Fundate(rslist("tran_date"))
	tran_date = DateFormatReplace(tran_date,"/","1")
	tran_etc4 = rslist("tran_etc4")
	if tran_etc4="11" then tran_etc4="��ȭ"
	if tran_etc4="12" then tran_etc4="���ͳ�"
%>

	<tr height=25 align=center>
		<td><%=i%></td>
		<td class="accountnum"><%=tran_phone%></td>
		<td><%=tran_rslt%></td>
		<td class="accountnum"><%=tran_date%></td>
		<td><%=rslist("tran_net")%></td>
		<td><%=rslist("tran_msg")%></td>
		<td class="accountnum"><%=rslist("tran_etc2")%></td>
		<td class="accountnum"><%=rslist("tran_etc3")%></td>
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