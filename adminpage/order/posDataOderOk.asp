<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/fun.asp"-->

<!--#include virtual="/adminpage/order/pos_in1.asp"-->
<!--#include virtual="/db/db.asp"-->
<!--#include virtual="/adminpage/order/pos_in2.asp"-->

<%
	set rs = server.CreateObject("ADODB.Recordset")
	Sql = " select od_no, OD_DATE,OD_TIME, OD_CUST "
	Sql = sql & " from PosData_order "
	Sql = sql & " where od_date >= '"& ymd1 &"' and od_date <= '"& ymd2 &"' and uflag = 'n' "
	Sql = sql & " group by od_no, OD_DATE,OD_TIME, OD_CUST "
	rs.Open sql, db, 1
	if not rs.eof then
		orderarray = rs.GetRows
		orderarrayint = ubound(orderarray,2)
	else
		orderarray = ""
		orderarrayint = ""
	end if
	rs.close

	db_insert_cnt = 0
	db_insert_cnt2 = 0
if suc_cnt>0 then
	if orderarrayint <> "" then

		OD_TIME2	= 10
		for i=0 to orderarrayint
			OD_NO		= trim(orderarray(0,i))
			OD_DATE		= trim(orderarray(1,i))	'8
			OD_TIME		= trim(orderarray(2,i))	'6
			OD_CUST		= trim(orderarray(3,i))
			real_pcode	= ""
			real_qty	= ""
			OD_TIME1	= left(trim(orderarray(2,i)),4)
			OD_TIME2	= OD_TIME2+1
			if OD_TIME2 > 99 then
				OD_TIME2 = 10
			end if

			Sql = " select ODD_QTY,bcscode,pcode,d_requestday "
			Sql = sql & " from PosData_order "
			Sql = sql & " where OD_NO = '"& OD_NO &"' "
			rs.Open sql, db, 1

			do until rs.eof

				ODD_QTY = rs(0)
				bcscode = rs(1)
				pcode = rs(2)
				d_requestday = rs(3)
				scode		= right(bcscode,5)

				real_idx = OD_DATE & OD_TIME1 & OD_TIME2 & scode	'년월일(8)+시분초(6)+순번(2)+체인점5자리코드
				'real_idx = mid(OD_NO,1,8) & mid(OD_NO,12,4) & OD_TIME2 & scode	'년월일(8)+일련번호(4)+체인점5자리코드
	
				if real_pcode="" then
					real_pcode = pcode
				else
					real_pcode = real_pcode &","& pcode
				end if

				if real_qty="" then
					real_qty   = ODD_QTY
				else
					real_qty   = real_qty   &","& ODD_QTY
				end if

			rs.movenext
			loop
			rs.close
%>
			<!--#include virtual="/adminpage/order/pos_in3.asp"-->
<%
		next
	end if

	sql = "update PosData_order set uflag = 'y' where sessionid = '"& session.sessionid &"' "
	db.execute sql

	'response.write tot_cnt & "<BR>"
	'response.write suc_cnt & "<BR>"
	'response.write fai_cnt
end if
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>POS 주문</title>
<link href="/css/jin.css" rel="stylesheet" type="text/css" />
</head>
<body topmargin="0" leftmargin="10">

<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height=20><font color=blue size=3><B>[POS 주문]</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor=#D7D7D7>

<form action="posDataOderok.asp" method="POST" name=form>

	<tr bgcolor=#EDF7FA>
		<td bgcolor=white align=center>
전체POS데이타 : <%=tot_cnt%><BR>
조회가능POS데이타 : <%=suc_cnt%><BR>
조회실패POS데이타 : <%=fai_cnt%><BR>
실제DB저장주문건수 : <%=db_insert_cnt%><BR>
실제DB저장상품건수 : <%=db_insert_cnt2%><BR>
<%if fai_cnt>0 then%>실패파일 : <a href="posDataOrder_dn.asp?f_name=<%=session.sessionid & ".txt"%>"><%=session.sessionid & ".txt"%></a><BR><%end if%>
<input type=button value="창닫기" onclick="window.close()">
		</td>
	</tr>

</form>

</table>

</body>
</html>