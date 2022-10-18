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

	if searchg="" then searchg = "0"
	if searchc="" then searchc = "0"
	if searchd="" then searchd = replace(left(now()-31,10),"-","")
	if searche="" then searche = replace(left(now(),10),"-","")
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	btcode = "01806010"
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rslist = server.CreateObject("ADODB.Recordset")
	sql = " select a.*, b.comname, b.dcode,c.dname, d.comname as jisaname,b.tel1,b.tel2,b.tel3,d.tel1 as jtel1,d.tel2 as jtel2,d.tel3 as jtel3,b.accountflag "
	sql = sql & " from  "

	SQL = sql & " 	(select seq,Aym,hname,umoney,tcode,jtcode,wdate,idx,iflag from tAccountM where idate='' and flag='1') e "
	sql = sql & " 	left outer join  "

	sql = sql & " 	( select wdate,tcode,jtcode,Aym,Aymd, "
	sql = sql & " 		sum(kmoney) as kmoney,sum(smoney) as smoney,sum(hmoney) as hmoney,idate,imoney "
	sql = sql & " 	  from tAccountM group by wdate,tcode,Aym,Aymd,idate,imoney,jtcode) a "

	SQL = sql & " on a.tcode = e.tcode and a.wdate=e.wdate and a.jtcode=e.jtcode and a.Aym = e.Aym "

	sql = sql & " 	left outer join  "
	sql = sql & " 	( select idx,comname,virtual_acnt2,tcode,dcode,accountflag,tel1,tel2,tel3 from tb_company where flag='1' ) b "
	sql = sql & " 	on a.tcode = b.tcode "
	sql = sql & " 	left outer join ( select dname,dcode from tb_dealer ) c on c.dcode = b.dcode "
	sql = sql & " 	left outer join  "
	sql = sql & " 	( select comname,tcode,bidxsub,tel1,tel2,tel3 from tb_company where flag='2' ) d "
	sql = sql & " 	on a.jtcode = d.tcode and d.bidxsub = b.idx "

	SQL = sql & " where a.Aymd >= '"& searchd &"' and a.Aymd <= '"& searche &"' "
	if searchf="y" then SQL = sql & " and a.idate <> '' and a.imoney > 0 "
	if searchf="n" then SQL = sql & " and a.idate = '' and a.imoney = 0 "
	if searcha<>"" and searchb<>"" then SQL = sql & " and "& searcha &" like '%"& searchb &"%' "
	SQL = sql & " order by a.tcode asc, a.Aym asc "

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
		<td>코드</td>
		<td>회원사</td>
		<td>담당자</td>
		<td>년월</td>
		<td>금액</td>
		<td>부가세</td>
		<td>합계금액</td>
		<td>입금일자</td>
		<td>입금액</td>
		<td>연락처</td>
	</tr>

<%
i=1
hkmoney  = 0
hsmoney  = 0
hhmoney  = 0
hdep_amt = 0
do until rslist.EOF
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'tcode,Aym,kmoney,smoney,hmoney,idate,imoney
	imsidt   = rslist("idate")
	dep_amt  = rslist("imoney")
	Aym      = rslist("Aym")
	jisaname = rslist("jisaname")
	kmoney   = rslist("kmoney")
	smoney   = rslist("smoney")
	hmoney   = rslist("hmoney")
	accountflag = rslist("accountflag")
	if accountflag <> "y" then smoney = 0
	if accountflag <> "y" then hmoney = kmoney
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	hkmoney  = hkmoney + kmoney
	hsmoney  = hsmoney + smoney
	hhmoney  = hhmoney + hmoney
	hdep_amt = hdep_amt + dep_amt
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	kmoney   = formatnumber(kmoney,0)
	smoney   = formatnumber(smoney,0)
	hmoney   = formatnumber(hmoney,0)
	if imsidt  <>""  then imsidt  = DateFormatReplace(imsidt,"/","1")
	if dep_amt <> "" then dep_amt = formatnumber(dep_amt,0)
	if isnull(jisaname) then jisaname=""
	Aym = mid(Aym,3,2) &"/"& mid(Aym,5,2)
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	tel  = rslist("tel1") &"-"& rslist("tel2") &"-"& rslist("tel3")
	jtel = rslist("jtel1") &"-"& rslist("jtel2") &"-"& rslist("jtel3")
	tel  = replace(tel,"--","")
	jtel = replace(jtel,"--","")
%>
	<tr height=25 align=center>
		<td class="accountnum"><%=i%></td>
		<td class="accountnum"><%=rslist("tcode")%></td>
		<td class="accountnum" align=left><%=rslist("comname")%><%if jisaname<>"" then%><font color=red>(<%=jisaname%>)<%end if%></td>
		<td class="accountnum"><%=rslist("dname")%></td>
		<td class="accountnum"><%=Aym%></td>
		<td class="accountnum" align=right><%=kmoney%></td>
		<td class="accountnum" align=right><%=smoney%></td>
		<td class="accountnum" align=right><%=hmoney%></td>
		<td class="accountnum"><%=imsidt%></td>
		<td class="accountnum" align=right><%=dep_amt%></td>
		<td><%=tel%></td>
	</tr>

<%
rslist.MoveNext 
i=i+1
loop
%>

	<tr height=25 align=center>
		<td class="accountnum" colspan=5>합 계</td>
		<td class="accountnum" align=right><%=formatnumber(hkmoney,0)%></td>
		<td class="accountnum" align=right><%=formatnumber(hsmoney,0)%></td>
		<td class="accountnum" align=right><%=formatnumber(hhmoney,0)%></td>
		<td class="accountnum"></td>
		<td class="accountnum" align=right><%=formatnumber(hdep_amt,0)%></td>
	</tr>

</table>

<%
	db.close
	set db=nothing
%>

</body>
</html>