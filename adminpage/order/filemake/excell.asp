<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel"
	Response.AddHeader "Content-Disposition","attachment;filename=Sheet1.xls"

	Server.ScriptTimeOut = 1000000
%>

<!--#include virtual="/db/db.asp"-->

<%
	imsinow = replace(left(now(),10),"-","")
	imsinow2 = replace(left(now()-1,10),"-","")

	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")

	if searchc = "" then
		searchc = "0"
	end if

	if searcha="" then
		searcha = imsinow2
	end if
	if searchb="" then
		searchb = imsinow
	end if

	imsiday1 = left(searcha,4)&"/"&mid(searcha,5,2)&"/"&right(searcha,2)
	imsiday2 = left(searchb,4)&"/"&mid(searchb,5,2)&"/"&right(searchb,2)

	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.pcode,a.pname"
	SQL = sql & " from tb_order_product a, tb_order b "
	SQL = sql & " where a.idx = b.idx "

	if session("Ausergubun")="3" then
		SQL = sql & " and substring(b.usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
		'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
		if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
			SQL = sql & " and a.dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
		end if
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	else
		SQL = sql & " and substring(b.usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if

	SQL = sql & " and b.deflag = 'n' "
	SQL = sql & " and b.flag = 'y' "

	'070105작업
	'SQL = sql & " and a.flag = 'T' "

	SQL = sql & " and b.orderday >= '"& searcha &"' "
	SQL = sql & " and b.orderday <= '"& searchb &"' "
	SQL = sql & " group by a.pcode,a.pname "
	SQL = sql & " order by a.pcode asc "
	rs.Open sql, db, 1
	if not rs.eof then
		proarray = rs.GetRows
		proarrayint = ubound(proarray,2)
	else
		proarray = ""
		proarrayint = ""
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select a.idx,a.comname, b.carname "
	SQL = sql & " from tb_company a, tb_order b "
	SQL = sql & " where a.idx = substring(b.usercode,11,5) "

	if session("Ausergubun")="3" then
		SQL = sql & " and substring(b.usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
	else
		SQL = sql & " and substring(b.usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if

	SQL = sql & " and b.deflag = 'n' "
	SQL = sql & " and b.flag = 'y' "
	SQL = sql & " and b.orderday >= '"& searcha &"' "
	SQL = sql & " and b.orderday <= '"& searchb &"' "
	SQL = sql & " group by a.comname, b.carname,a.idx "
	SQL = sql & " order by b.carname asc,a.comname asc "
	rs.Open sql, db, 1
	if not rs.eof then
		comarray = rs.GetRows
		comarrayint = ubound(comarray,2)
	else
		comarray = ""
		comarrayint = ""
	end if
	rs.close

	totlisthap = ""
%>

<html>
<head>
<title>edubill.co.kr</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
</head>

<body leftmargin="0" topmargin="0">

<table border=0>
	<tr>
		<td align=center>

		<table border=1>
			<tr height="25" align=center>
				<td><font color=black>호차</td>
				<td><font color=black>체인점명</td>

				<%if proarrayint<>"" then%>
					<%for i=0 to proarrayint%>
						<%
						if i=0 then
							imsipcodearr = proarray(0,i)
							totlisthap   = 0
						else
							imsipcodearr = imsipcodearr&","&proarray(0,i)
							totlisthap   = totlisthap&","&"0"
						end if
						%>
						<td><font color=black><%=proarray(1,i)%></td>
					<%next%>
				<%end if%>
			</tr>

<%
	totlisthap = split(totlisthap,",")

	if comarrayint<>"" then
		for i=0 to comarrayint
%>

			<tr height="25" align=center>
				<td><font color=black><%=comarray(2,i)%></td>
				<td><font color=black><%=comarray(1,i)%></td>

<%
		tot_pcode_array    = ""
		tot_pcount_array   = ""
		tot_pcode_arrayint = ""

		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select a.pcode,isnull(sum(a.ordernum),0) as imsicount "
		SQL = sql & " from tb_order_product a, tb_order b "
		SQL = sql & " where a.idx = b.idx "
		SQL = sql & " and a.pcode in ("& imsipcodearr &") "
		SQL = sql & " and b.carname = '"& comarray(2,i) &"' "

		if session("Ausergubun")="3" then
			SQL = sql & " and substring(b.usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
			'지사로그인시 본사가 물류센터이용시 해당물류센터만 가져오기07.01.12'''''''''''''''''''''''''
			if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
				SQL = sql & " and a.dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
			end if
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		else
			SQL = sql & " and substring(b.usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
		end if

		SQL = sql & " and substring(b.usercode,11,5) = '"& comarray(0,i) &"' "
		SQL = sql & " and b.deflag = 'n' "
		SQL = sql & " and b.flag = 'y' "

		'070105작업
		'SQL = sql & " and a.flag = 'T' "

		SQL = sql & " and b.orderday >= '"& searcha &"' "
		SQL = sql & " and b.orderday <= '"& searchb &"' "
		SQL = sql & " group by a.pcode "
		SQL = sql & " order by a.pcode asc "
		rs.Open sql, db, 1
		if not rs.eof then
			jj=0
			do until rs.eof
				if jj=0 then
					tot_pcode_array = rs(0)
					tot_pcount_array = rs(1)
				else
					tot_pcode_array = tot_pcode_array&","&rs(0)
					tot_pcount_array = tot_pcount_array&","&rs(1)
				end if
			rs.movenext
			jj=jj+1
			loop

			tot_pcode_array = split(tot_pcode_array,",")
			tot_pcount_array = split(tot_pcount_array,",")
			tot_pcode_arrayint = ubound(tot_pcode_array)
		else
			tot_pcode_array    = ""
			tot_pcount_array   = ""
			tot_pcode_arrayint = ""
		end if
		rs.close

		if proarrayint<>"" then
			for k=0 to proarrayint

				j=0
				imsi_i=""
				if tot_pcode_arrayint<>"" then
					for j=0 to tot_pcode_arrayint
						if proarray(0,k)=tot_pcode_array(j) then
							imsi_i = j
							exit for
						end if
					next
				end if

				if imsi_i<>"" then
					response.write "<td align=right><font color=black>"& tot_pcount_array(imsi_i) &"</td>"
					totlisthap(k) = int(totlisthap(k))+int(tot_pcount_array(imsi_i))
				else
					response.write "<td></td>"
				end if
			next
		end if
%>

			</tr>

<%		next
	end if

	totlisthapint = ubound(totlisthap)
%>


			<tr height="25" align=center>
				<td></td>
				<td><font color=black>계</td>


					<%for i=0 to totlisthapint%>
						<td align=right><font color=black><%=totlisthap(i)%></td>
					<%next%>

			</tr>
		</table>

		</td>
	</tr>
</table>

<%
	db.close
	set db=nothing
%>

</body>
</html>