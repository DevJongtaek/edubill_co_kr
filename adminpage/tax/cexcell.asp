<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=order.xls"
%>

<!--#include virtual="/db/db.asp"-->

<%
	'--------------------------------------------------------------------------------------------------------------------
	'# 날짜관련 함수
	'# FunYMDHMS(dflag)	년월일시분초 가져오는 함수
	'#    			4:yyyy    6:yyyymm    8:yyyymmdd    10:yyyymmddhh    12:yyyymmddhhmm    14:yyyymmddhhmmss
	'# DateFormatReplace	20090605123541 -->> 2009-06-05 12:35:41
	'#    			psDate:데이타	psDateflag:날짜구분값	psDategubun:1=날짜전체 2=시간만
	'# SelectDateChoice	년월일 콤보박스
	'#    			yearDa:년도값    monthDa:월값    dayDa:일값    yvalD:년도이름    mvalD:월이름    dvalD:일이름
	'# alertURL	 이동할 주소
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
	'sql = " select * from tb_virtual_acnt "                     2011.04.05 파일생성코드 추가
	'SQL = sql & " where cporg_cd = '"& btcode &"' "
	set rslist = server.CreateObject("ADODB.Recordset")
	sql = " select * from tb_virtual_acnt A "
	SQL = sql & " left  join (select tcode, fileregcode from tb_company where bidxsub = '"& left(session("Ausercode"),5) &"') B "
	SQL = sql & " on A.chancode = B.tcode "
	SQL = sql & " where cporg_cd = '"& btcode &"' "

	if session("Ausergubun")="4" and ctcode<>"" then	'체인점
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
		<td>일자</td>
		<td>시간</td>
		<td>가상계좌</td>
		<td>입금액</td>
		<td>은행명</td>
		<td>입금자</td>

		<td>체인점코드</td>
		<td>파일생성코드</td>
		<td>체인점명</td>
		<td>여신금</td>
		<td>미수금</td>
		<td>주문</td>
	</tr>

<%
i=1
do until rslist.EOF
	if rslist("ye_money")-rslist("mi_money") >= 0 then
		imsitmsg = "<font color=blue>허용"
	else
		imsitmsg = "<font color=red>차단"
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