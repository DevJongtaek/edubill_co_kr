<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=tax1.xls"
%>

<!--#include virtual="/db/db.asp"-->
<%
	imsititlename = "세금계산서 조회"
	stxt1 = request("stxt1")
	stxt2 = request("stxt2")
	imsiwdate = request("imsiwdate")

	if stxt2="" then
		stxt2 = "Aym"
	end if
	if stxt1="" then
		stxt1 = replace(left(now(),7),"-","")
	end if

	if stxt2="Aym" then
		imsiorderby = " order by a.tcode desc, a.hname asc"
	elseif stxt2="tcode" or stxt2="hname" then
		imsiorderby = " order by a.Aym desc, a.tcode asc"
	end if

	if stxt2 = "Aym" then
		sendSQL = " Aym = '"& stxt1 &"' "
		if imsiwdate<>"" then
			sendSQL = sendSQL & " and wdate = '"& imsiwdate &"' "
		end if
	elseif stxt2 = "tcode" then
		sendSQL = " tcode = '"& stxt1 &"' "
		if imsiwdate<>"" then
			sendSQL = sendSQL & " and wdate = '"& imsiwdate &"' "
		end if
	elseif stxt2 = "hname" then
		sendSQL = " hname like '%"& stxt1 &"%' "
		if imsiwdate<>"" then
			sendSQL = sendSQL & " and wdate = '"& imsiwdate &"' "
		end if
	end if

	'GotoPage = Request("GotoPage")
	'if GotoPage = "" then
	'	GotoPage = 1
	'end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select a.seq,'113-11-83754' as bizno,'매출' as Gubun,'에듀빌' as sangho,'서비스'as uptae,'인터넷결제대행' as jongmok "
	SQl = sql &" ,'박양우' as ceo,'서울 금천구 디지털로 9길 65, 408호(가산동, 백상스타타워 1차)' as addr,a.Aym,a.hname "
	SQL = sql & ",companynum,a.companyname,a.companyUptae,a.companyUpjong,a.companyAddr,case a.jtcode when '' then c.homepage else d.homepage end  as homepage,convert(varchar,c.tel) as tel,SUBSTRING(a.Aymd,5,2) as smonth,SUBSTRING(a.Aymd,7,2) as sday "
	SQL = sql &" ,a.umoney,a.tcode,b.Anum,b.kmoney,b.smoney,b.hmoney, c.accountflag, a.jtcode,CONVERT(VARCHAR,  DATEADD(day,1,getdate()) , 112) as AddDATE, convert(varchar(10),convert(datetime,a.Aymd),120) as Aymd ,c.taxtitle from "
	SQL = sql & " (select seq,Aym,hname,umoney,tcode,jtcode,wdate,idx,companynum,companyname,companyUptae,companyUpjong,companyAddr,Aymd from tAccountM where flag='1' and "& sendSQL &" ) a "
	SQL = sql & " left outer join "
	SQL = sql & "  (select wdate,tcode,jtcode,sum(Anum) as Anum,sum(kmoney) as kmoney,sum(smoney) as smoney,sum(hmoney) as hmoney from tAccountM group by wdate,tcode,jtcode) b "
	SQL = sql & " on a.tcode = b.tcode and a.wdate=b.wdate and a.jtcode=b.jtcode "
	SQL = sql & " left outer join "
	SQL = sql & " (select idx,accountflag,homepage,tel1+'-'+tel2+'-'+tel3 as tel,taxtitle from tb_company where flag='1') c "
	SQL = sql & " on a.idx = c.idx "
    SQL = sql & "  left outer join "
	SQL = sql & " (select idx,accountflag,homepage,tel1+'-'+tel2+'-'+tel3 as tel,taxtitle,bidxsub,tcode from tb_company where flag='2') d"
	SQL = sql & " on a.jtcode = d.tcode and d.bidxsub = c.idx "

	SQL = sql & " WHERE c.accountflag = 'Y'"

	SQL = sql & imsiorderby
	'rslist.PageSize=20
'response.write sql

	rslist.Open sql, db, 1

	'if not rslist.bof then
	'	rslist.AbsolutePage=int(gotopage)
	'end if
	

%>

<html>
<head>
<title>edubill.co.kr</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">


</head>
<body>
<table border=1>
	<tr height=28 align="center" style="font-weight:bold;font-size:12px" bgcolor="#D4F4FA">
	
		<td>사업자번호(공급자)</td>
		<td>구분</td>
		<td>상호</td>
		<td>업태</td>
		<td>종목</td>
		<td>대표자</td>
		<td>주소</td>
		<td>공급받는회사</td>
		<td>사업자번호</td>
		<td>고객대표자</td>
		<td>고객업태</td>
		<td>고객종목</td>
		<td>고객주소</td>
		<td>이메일</td>
		<td>핸드폰</td>
		<td>제목</td>
		<td>작성일</td>
		<td>공급가액</td>
		<td>세액</td>
		<td>보안번호</td>
		<td>권</td>
		<td>호</td>
		<td>일련번호</td>
		<td>구분</td>
		<td>품목월1</td>
		<td>품목일1</td>
		<td>품목1</td>
		<td>규격1</td>
		<td>수량1</td>
		<td>단가1</td>
		<td>공급가액1</td>
		<td>세액1</td>
		<td>비고1</td>
		<td>품목월2</td>
		<td>품목일2</td>
		<td>품목2</td>
		<td>규격2</td>
		<td>수량2</td>
		<td>단가2</td>
		<td>공급가액2</td>
		<td>세액2</td>
		<td>비고2</td>
	
		<td>국세청전송여부</td>
		<td>국세청전송일(년월일:8자리)</td>

	</tr>

<%
hap_kmoney = 0
hap_smoney = 0
hap_hmoney = 0
i=1
'j=((gotopage-1)*19)+gotopage
'do until rslist.EOF or rslist.PageSize<i
do until rslist.EOF

	'Aym   = left(rslist(0),4) &"/"& right(rslist(0),2)
	'wdate = mid(rslist(1),1,4) &"/"& mid(rslist(1),5,2) &"/"& mid(rslist(1),7,2) &" "& mid(rslist(1),9,2) &":"& mid(rslist(1),11,2) &":"& mid(rslist(1),13,2)

	hap_kmoney = hap_kmoney+rslist("kmoney")
	hap_smoney = hap_smoney+rslist("smoney")
	hap_hmoney = hap_hmoney+rslist("hmoney")
%>

	<tr height="25" style="font-size:12px">
	
		<td><%=rslist("bizno")%></td>
		<td><%=rslist("Gubun")%></td>
		<td><%=rslist("sangho")%></td>
		<td><%=rslist("uptae")%></td>
		<td><%=rslist("jongmok")%></td>
		<td><%=rslist("ceo")%></td>
		<td><%=rslist("addr")%></td>
		<td><%=rslist("hname")%></td>
		<td><%=rslist("companynum")%></td>
		<td><%=rslist("companyname")%></td>
		<td><%=rslist("companyUptae")%></td>
		<td><%=rslist("companyUpjong")%></td>
		<td><%=rslist("companyAddr")%></td>
		<td><%=rslist("homepage")%></td>
		<td><%=rslist("tel")%></td>
		<!--<td>수발주 SVC 이용료</td>-->
         <td><%=rslist("taxtitle")%></td>
		<td><%=rslist("Aymd")%></td>
		<td class="accountnum" align=right><%=rslist("kmoney")%></td>
		<td class="accountnum" align=right><%=rslist("smoney")%></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td>청구</td>
		<td><%=rslist("smonth")%></td>
		<td><%=rslist("sday")%></td>
	<!--	<td>수발주 SVC 이용료</td>-->
        <td><%=rslist("taxtitle")%></td>
		<td></td>
		<td><%=rslist("Anum")%></td>
		<td><%=rslist("umoney")%></td>
		<td class="accountnum" align=right><%=rslist("kmoney")%></td>
		<td class="accountnum" align=right><%=rslist("smoney")%></td>
	
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	
		<td>Y</td>
		<td><%=rslist("AddDATE")%></td>
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