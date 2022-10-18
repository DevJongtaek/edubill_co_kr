<%
	Server.ScriptTimeOut = 1000000
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
	Function regsendval(val)
		regsend1 = "0,1,A,B,C,D,2,A,B,C,D,E,F,G,H,I,J"
		regsend2 = "성공,Time Out,호처리중,음영지역,Power off,저장수초과,잘못된번호,일시정지,기타문제,착신거절,기타,형식오류,형식오류,불가단말기,호불가상태,메시지삭제,Que Full"
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

	Function FunHPCut(Hvalnum)	'핸드폰번호0111111111->011-111-1111
		if Hvalnum<>"" and len(Hvalnum)>=10 then
			imsilenhp  = len(Hvalnum)	'전체길이
			imsilenhp1 = left(Hvalnum,3)	'통신사번호
			imsilenhp2 = mid(left(Hvalnum,(imsilenhp-4)),4)	'국번
			imsilenhp3 = right(Hvalnum,4)	'전화반호
			FunHPCut = imsilenhp1&"-"&imsilenhp2&"-"&imsilenhp3
		end if
	End Function

	Function Fundate(Hval)
		if Hval<>"" then
			DATE_MD = Right(Replace(FormatDateTime(Hval,2),"-",""),4)
			DATE_Y  = MID(Replace(FormatDateTime(Hval,2),"-",""),1,4)
			B_DATE  = DATE_Y & DATE_MD 	'월일년
			B_TIME  = left(Replace(FormatDateTime(Hval,4),":",""),6)&Right("00" & second(Hval),2)  '시분초
			IntTime = B_DATE &  B_TIME
		end if
		Fundate = IntTime
	End Function

	sub SelectDateChoice(yearDa,monthDa,dayDa,yvalD,mvalD,dvalD)
		imsiye  = mid(now(),1,4)
		imsimo  = mid(now(),6,2)
		imsida  = mid(now(),9,2)
		if yearDa<>"" then
			response.write "<select name="&yearDa&">"
					response.write "<option value=>선택"
					for i=2008 to (imsiye+1)
						imsiselected = ""
						if yvalD<>"" then
							if cstr(yvalD)=cstr(i) then
								imsiselected = "selected"
							end if
						end if
						response.write "<option value="& i &" "& imsiselected &">"&i&"년"
					next
			response.write "</select>"
		end if
		if monthDa<>"" then
			response.write "<select name="&monthDa&">"
					response.write "<option value=>선택"
					for i=1 to 12
						if i<10 then
							ii=cstr("0"&i)
						else
							ii=cstr(i)
						end if
						imsiselected = ""
						if mvalD<>"" then
							if mvalD=ii then
								imsiselected = "selected"
							end if
						end if
						response.write "<option value="& ii &" "& imsiselected &">"&ii&"월"
					next
			response.write "</select>"
		end if
		if dayDa<>"" then
			response.write "<select name="&dayDa&">"
					response.write "<option value=>전체"
					for i=1 to 31
						if i<10 then
							ii=cstr("0"&i)
						else
							ii=cstr(i)
						end if
						imsiselected = ""
						if dvalD<>"" then
							if dvalD=ii then
								imsiselected = "selected"
							end if
						end if
						response.write "<option value="&ii&" "& imsiselected &">"&ii&"일"
					next
			response.write "</select>"
		end if
	end sub
	'--------------------------------------------------------------------------------------------------------------------
	'# 자바스크립트 alert창
	'# alertFlag     1:이전페이지 이동    2:지정페이지이동    3:부모창 새로고침 후 자신창 닫기    4:부모창 새로고침만    
	'#               5:프레임 있을때 이동
	'# alertMsgFlag  y: 메세지내용 뿌림   n:메세지내용 안뿌림
	'# alertMsg	 메세지내용
	'# alertURL	 이동할 주소
	'--------------------------------------------------------------------------------------------------------------------
	SUB FunAlertMsg(alertFlag,alertMsgFlag,alertMsg,alertURL)
		response.write "<SCRIPT LANGUAGE='JavaScript'>"
			if alertMsgFlag="y" then
				response.write "alert('"& alertMsg &"');"
			end if
			if alertFlag="1" then
				response.write "history.back(-1);"
			elseif alertFlag="2" then
				response.write "location.href='"& alertURL &"';"
			elseif alertFlag="3" then
				response.write "opener.location.reload();window.close();"
			elseif alertFlag="4" then
				response.write "opener.location.reload();"
			elseif alertFlag="5" then
				response.write "window.open('"& alertURL &"', '_top');"
			end if
		response.write "</SCRIPT>"
		response.end
	End SUB
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
		searchd = replace(left(now(),4),"-","")
	end if
	if searche="" then
		searche = replace(mid(now(),6,2),"-","")
	end if
	if searchg="" then
		imsidate = searchd&"-"&searche
	else
		imsidate = searchd&"-"&searche&"-"&searchg
	end if
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
	imsitb = "em_log_" & searchd & searche
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	sql = " select isnull(count(*),0) TotCount from INFORMATION_SCHEMA.tables  where table_name = '"& imsitb &"' "
	rs.Open sql, db, 1
	imsierrcnt = rs(0)
	rs.close

	tbsql = " select * from "& imsitb &" "
	tbsql = tbsql & " where tran_etc2 = '"& btcode &"' "
	if searcha<>"" and searchb<>"" then tbsql = tbsql & " and "& searcha &" like '%"& searchb &"%' "
	if searchc<>"" then tbsql = tbsql & " and tran_etc3 = '"& searchc &"' "
	if searchf="y" then 
		tbsql = tbsql & " and tran_rslt  = '0' "
	elseif searchf="n" then 
		tbsql = tbsql & " and tran_rslt  <> '0' "
	end if
	if len(imsidate)=7 then
		tbsql = tbsql & " and substring(convert(char(10),tran_date,21),1,7) = '"& imsidate &"' "
	else
		tbsql = tbsql & " and convert(char(10),tran_date,21) = '"& imsidate &"' "
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
if imsierrcnt>0 then
	set rslist = server.CreateObject("ADODB.Recordset")
	sql = " select a.*, b.comname,b.tcode from ("& tbsql &") a "
	sql = sql & " left outer join "
	sql = sql & " 	(select comname,tcode as ttcode,idx from tb_company where flag='1' and tcode = '"& btcode &"') c "
	sql = sql & " on a.tran_etc2 = c.ttcode "
	sql = sql & " left outer join "
	sql = sql & " 	(select comname,tcode,bidxsub from tb_company where flag='3') b "
	sql = sql & " on c.idx = b.bidxsub and a.tran_etc3=b.tcode "
	sql = sql & " order by tran_pr asc "
	rslist.Open sql, db, 1
	tcnt = rslist.recordcount
end if
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
		<td>핸드폰번호</td>
		<td>전송결과</td>
		<td>전송일시</td>
		<td>통신사</td>
		<td>메세지</td>


		<td>체인본부코드</td>
		<td>체인점코드</td>
	</tr>

<%
if imsierrcnt>0 then
i=1
do until rslist.EOF
	tran_rslt  = regsendval(replace(trim(rslist("tran_rslt"))," ",""))
	tran_phone = FunHPCut(rslist("tran_phone"))

	tran_date = Fundate(rslist("tran_date"))
	tran_date = DateFormatReplace(tran_date,"/","1")
	tran_etc4 = rslist("tran_etc4")
	if tran_etc4="11" then tran_etc4="전화"
	if tran_etc4="12" then tran_etc4="인터넷"
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
end if
%>

</table>


<%
	db.close
	set db=nothing
%>

</body>
</html>