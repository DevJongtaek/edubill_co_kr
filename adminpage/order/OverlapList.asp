<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<title>중복 주문 체크</title>
<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx ,usercode, orderday, SUM(ordermoney) ordermoney from  "
	SQL = sql & " (select idx, usercode, orderday, SUM(pprice*rordernum) ordermoney from v_tb_order  "
	if session("Ausergubun")="3" then
		SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
	else
		SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if
	SQL = sql & " and orderday >= '" & searcha & "' "
	SQL = sql & " and orderday <= '" & searchb & "' "
	SQL = sql & " group by idx, usercode , orderday) a "
	SQL = sql & " group by idx, usercode, orderday "
	SQL = sql & " order by orderday, usercode"
	'response.write SQL & "<br>"
	rs.Open sql, db, 1
		imsiIdx = ""
		imsiUsercode = ""
		imsiOrderday = ""
		imsiOrdermoney = ""
		overlapIdx = ""

	Do Until rs.eof
		imIdx = rs("idx")
		imUsercode = rs("usercode")
		imOrderday = rs("orderday")
		imOrdermoney = rs("ordermoney")
		'response.write "imUsercode:"& imUsercode & "=" & imsiUsercode&"<br>imOrderday:"&imOrderday& "=" &imsiOrderday& "<br>imOrdermoney:" &imOrdermoney &"=" &imsiOrdermoney
		'response.write "<br><br>"
		If imsiUsercode = imUsercode And imsiOrderday = imOrderday And CStr(imsiOrdermoney) = CStr(imOrdermoney) Then
			If overlapIdx = "" Then 
				overlapIdx = "'" & imsiIdx & "''" & rs("idx") & "'"
			Else 
				overlapIdx = overlapIdx & "'" & imIdx & "''" & imsiIdx & "'"
			End If 
		End If 
		imsiIdx = rs("idx")
		imsiUsercode = rs("usercode")
		imsiOrderday = rs("orderday")
		imsiOrdermoney = rs("ordermoney")
	rs.movenext
	Loop
	rs.close
	overlapIdx = Replace(overlapIdx, "''", "','")
	'response.write "overlapIdx" &overlapIdx
	If Trim(overlapIdx) ="" Then 
	response.write "<script language=JavaScript>"
    response.write "window.close();"
	response.write "</script>"
	End If 
	If trim(session("Adcenteridx")) = "10233" Then 
		set rslist = server.CreateObject("ADODB.Recordset")
		SQL = " select c.tcode, c.comname, v.idx, SUM(p.pprice*ordernum) ordermoney from v_tb_order v join tb_company c  "
		SQL = sql & " on RIGHT(v.idx, 5) = c.idx "
		SQL = sql & " join (select pcode, pprice from tb_product where usercode = '77275') p "
		SQL = sql & " on p.pcode = v.pcode "
		if session("Ausergubun")="3" then
			SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		else
			SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		end if
		SQL = sql & " and v.idx in(" & overlapIdx & ") "
		SQL = sql & " group by v.idx,c.tcode, c.comname "
		'response.write SQL & "<br>"
		rslist.Open sql, db, 1
	Else
		set rslist = server.CreateObject("ADODB.Recordset")
		SQL = " select c.tcode, c.comname, v.idx, SUM(pprice*rordernum) ordermoney from v_tb_order v join tb_company c  "
		SQL = sql & " on RIGHT(v.idx, 5) = c.idx   "
		if session("Ausergubun")="3" then
			SQL = sql & " where substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		else
			SQL = sql & " where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		end if
		SQL = sql & " and v.idx in(" & overlapIdx & ") "
		SQL = sql & " group by v.idx,c.tcode, c.comname "
		'response.write SQL & "<br>"
		rslist.Open sql, db, 1
	End If 
%>

<body>
<table width="500" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
<FORM name="form" method="POST" action="sms_formok.asp">
	<tr>
		<td colspan=2><font color=blue size=3pt><b>[중복주문 건 확인]</b></font></td>
	</tr>
	<tr>
		<td width=8%><img src="warning.png" width=50 height=50></td>
		<td><font color = red>같은 날자에 동일한 금액으로 복수 건이 주문되었습니다. <br> 중복 주문 건 여부를 필히 확인하시기 바랍니다.!!!</font></td>
	</tr>
	<tr>
		<td align=center colspan=2>
		<div id="tempdiv" style="overflow:auto; height:200px; width:600px;">
		<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7 id="searchlist">
			<tr height=28 bgcolor=#F7F7FF align=center>
				<td width="15%">체인점코드</td>
				<td>체인점명</td>
				<td>주문일시</td>
				<td>주문금액</td>
				<td>비고</td>
			</tr>
			<% Do Until rslist.eof 
				imsidaytime = left(rslist("idx"),4)&"/"&mid(rslist("idx"),5,2)&"/"&mid(rslist("idx"),7,2)
				imsidaytime = imsidaytime&" "&mid(rslist("idx"),9,2)&":"&mid(rslist("idx"),11,2)&":"&mid(rslist("idx"),13,2)
			%>
			<tr height=22 bgcolor=#FFFFFF align=center>
				<td><%=rslist("tcode")%></td>
				<td><%=rslist("comname")%></td>
				<td><%=imsidaytime%></td>
				<td><%=FormatCurrency(rslist("ordermoney"))%></td>
				<td></td>
			</tr>
			<% rslist.movenext 
			   Loop %>
		</table>
		</td>
	</tr>
</table>
</body>
</html>
<% rslist.close %>