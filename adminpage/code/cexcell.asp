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
	'if searchf="" then
	'	searchf = "0"
	'end if

	if searchd="" then
		searchd = replace(left(now()-31,10),"-","")
	end if

	if searche="" then
		searche = replace(left(now(),10),"-","")
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	btcode = "01806010"
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rslist = server.CreateObject("ADODB.Recordset")
	sql = " select a.*, b.comname,b.tcode,b.flag as comflag, b.idx as comidx "
	sql = sql & " from  "
	sql = sql & " 	( "
	sql = sql & " 	select * from tb_virtual_acnt "
	SQL = sql & " 	where cporg_cd = '"& btcode &"' and dep_st = '1' "
			if searchd<>"" then SQL = sql & " and tr_il >= '"& searchd &"' "
			if searche<>"" then SQL = sql & " and tr_il <= '"& searche &"' "
			if searcha<>"" and searchb<>"" and left(searcha,2)<>"b." then SQL = sql & " and "& searcha &" like '%"& searchb &"%' "
			if searchc="1" then
				SQL = sql & " and (ye_money-mi_money) >= 0 "
			elseif searchc="2" then
				SQL = sql & " and (ye_money-mi_money) < 0 "
			end if
			if searchf<>"" then SQL = sql & " and taxReg = '"& searchf &"' "
	sql = sql & " 	) a "
	sql = sql & " left outer join  "
	sql = sql & " 	( "
	sql = sql & " 	select comname,virtual_acnt2,tcode,flag,idx from tb_company where flag='1' or flag='2' "
	sql = sql & " 	) b "
	sql = sql & " on a.va_no = b.virtual_acnt2 "
		if (searcha="b.comname" or searcha="b.tcode") and searchb<>"" then SQL = sql & " where "& searcha &" like '%"& searchb &"%' "
	SQL = sql & " order by a.tr_il desc, a.tr_si desc, b.comname asc "
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
		<td>번호</td>
		<td>가상계좌번호</td>
		<td>은행명</td>
		<td>입금자</td>
		<td>입금일</td>
		<td>회원사코드</td>
		<td>회원사명</td>
		<td>입금액</td>
		<td>비고</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF
	imsidt = rslist("tr_il")
	imsidt = DateFormatReplace(imsidt,"/","1")

	dep_amt  = rslist("dep_amt")
	ye_money = rslist("ye_money")
	mi_money = rslist("mi_money")
	if dep_amt  <> "" then dep_amt  = formatnumber(dep_amt,0)
%>

	<tr height=25 align=center>
		<td class="accountnum"><%=j%></td>
		<td class="accountnum"><%=rslist("va_no")%></td>
		<td class="accountnum"><%=rslist("depbnk_nm")%></td>
		<td class="accountnum" align=left><%=rslist("cust_nm")%></td>
		<td class="accountnum"><%=imsidt%></td>
		<td class="accountnum"><%=rslist("tcode")%></td>
		<td class="accountnum" align=left><%=rslist("comname")%></td>
		<td class="accountnum" align=right><%=dep_amt%></td>
		<td class="accountnum"><%=rslist("bigo")%></td>
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