<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=tax.xls"
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
	'end if,

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select a.seq,a.Aym,a.hname,a.umoney,a.tcode,b.Anum,b.kmoney,b.smoney,b.hmoney, c.accountflag, a.jtcode from "
	SQL = sql & " (select seq,Aym,hname,umoney,tcode,jtcode,wdate,idx from tAccountM where flag='1' and "& sendSQL &" ) a "
	SQL = sql & " left outer join "
	'SQL = sql & " (select wdate,tcode,sum(Anum) as Anum,sum(kmoney) as kmoney,sum(smoney) as smoney,sum(hmoney) as hmoney from tAccountM where "& sendSQL &" group by wdate,tcode) b "
	SQL = sql & "  (select wdate,tcode,jtcode,sum(Anum) as Anum,sum(kmoney) as kmoney,sum(smoney) as smoney,sum(hmoney) as hmoney from tAccountM group by wdate,tcode,jtcode) b "
	'SQL = sql & " on a.tcode = b.tcode and a.wdate=b.wdate and ((a.jtcode='' and b.jtcode='') or (a.jtcode<>'' and b.jtcode<>'')) "
	SQL = sql & " on a.tcode = b.tcode and a.wdate=b.wdate and a.jtcode=b.jtcode "

	SQL = sql & " left outer join "
	SQL = sql & " (select idx,accountflag from tb_company where flag='1') c "
	SQL = sql & " on a.idx = c.idx "

	SQL = sql & imsiorderby
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
		<td>번호</td>
		<td>코드</td>
		<td>청구년월</td>
		<td>회원사명</td>
		<td>이용료</td>
		<td>체인점수</td>
		<td>공급가액</td>
		<td>세액</td>
		<td>합계금액</td>
		<td>전표출력</td>
	</tr>

<%
hap_kmoney = 0
hap_smoney = 0
hap_hmoney = 0
i=1
'j=((gotopage-1)*19)+gotopage
'do until rslist.EOF or rslist.PageSize<i
do until rslist.EOF

	Aym   = left(rslist(0),4) &"/"& right(rslist(0),2)
	wdate = mid(rslist(1),1,4) &"/"& mid(rslist(1),5,2) &"/"& mid(rslist(1),7,2) &" "& mid(rslist(1),9,2) &":"& mid(rslist(1),11,2) &":"& mid(rslist(1),13,2)

	'hap_kmoney = hap_kmoney+rslist("kmoney")
	'hap_smoney = hap_smoney+rslist("smoney")
	'hap_hmoney = hap_hmoney+rslist("hmoney")
	
	if rslist("accountflag")="y" then
		hap_kmoney = hap_kmoney+rslist("kmoney")
		hap_smoney = hap_smoney+rslist("smoney")
		hap_hmoney = hap_hmoney+rslist("hmoney")
	else
		hap_kmoney = hap_kmoney+rslist("kmoney")
		hap_smoney = hap_smoney+0
		hap_hmoney = hap_hmoney+rslist("kmoney")
	end if
%>

	<tr height=25>
		<td><%=i%></td>
		<td><%=rslist("tcode")%></td>
		<td><%=left(rslist("Aym"),4)%><%=right(rslist("Aym"),2)%></td>
		<td align=left><B><%=rslist("hname")%></td>
		<td align=right><%=rslist("umoney")%></td>
		<td><%=rslist("Anum")%></td>
	<td class="accountnum" align=right><%=formatnumber(rslist("kmoney"),0)%></td>
		<!--<td class="accountnum" align=right><%if rslist("accountflag")="y" then%><%=formatnumber(rslist("smoney"),0)%><%else%>0<%end if%>&nbsp;</td>-->
		<!--<td class="accountnum" align=right><%if rslist("accountflag")="y" then%><%=formatnumber(rslist("hmoney"),0)%><%else%><%=formatnumber(rslist("kmoney"),0)%><%end if%>&nbsp;</td>-->
		<td class="accountnum" align=right><%if rslist("accountflag")="y" then%><%=rslist("smoney")%><%else%>0<%end if%></td>
		<td class="accountnum" align=right><%if rslist("accountflag")="y" then%><%=rslist("hmoney")%><%else%><%=rslist("kmoney")%><%end if%></td>
		<td><input type="button" name="세금" value="세금" class="box_work" onclick="javascript:location.href='listdel.asp?wdate=<%=rslist(1)%>';"></td>
	</tr>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop 
%>

	<tr height=25>
		<td>계</td>
		<td></td>
		<td></td>
		<td align=left></td>
		<td align=right></td>
		<td></td>
		<td align=right><%=hap_kmoney%></td>
		<td align=right><%=hap_smoney%></td>
		<td align=right><%=hap_hmoney%></td>
		<td></td>
	</tr>

</table>

<%
	db.close
	set db=nothing
%>

</body>
</html>