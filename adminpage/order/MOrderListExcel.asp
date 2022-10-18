<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=order.xls"
%>
<!--#include virtual="/db/db.asp"-->
<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")
	'주문 시간
	searchi = request("searchi")
	searchj = request("searchj")


 
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

	if searchh <> "" then
	searchhArr = split(searchh,",")
  
   
    for i=0 to ubound(searchhArr)
			imsival = trim(searchhArr(i))
			if i=0 then
    	    inCnt = "'"& imsival &"'"
            else 
			inCnt =  inCnt &","& "'"& imsival &"'"
			end if
		next

    else

     
    inCnt = "'y','4','5','1','6','2','3'"
   
	end if


	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select SearchOrderTime, SearchStartTime, SearchEndTime "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
	if not rs.eof then
		SearchOrderTime = rs(0)    '시간사용
		SearchStartTime = rs(1)	   '시작시간
		SearchEndTime = rs(2)      '종료시간
	else
		SearchOrderTime = "n"
		SearchStartTime = ""
		SearchEndTime = ""
	end if
	rs.close
	'주문시간
	If searchi = "" Then 
		If  SearchStartTime = "" Then 
			searchi = "000000"
		Else 
			If Len(SearchStartTime) = 4 Then 
				searchi = SearchStartTime & "00"
			Else
				searchi = "000000"
			End If 
		End If 
	End If 

	If searchj = "" Then 
		If SearchEndTime = ""Then 
			searchj = "235959"
		Else 
			If Len(SearchEndTime) = 4 Then 
				searchj = SearchEndTime & "59"
			Else
				searchj = "235959"
			End If 
		End If
	End If 
	
	startdate = searchd + searchi
	enddate = searche + searchj

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select * "
	SQL = sql & " from tb_company "
	SQL = sql & " where bidxsub = '"& left(session("Ausercode"),5) &"' "
	if session("Ausergubun")="3" then
		SQL = sql & " and idxsub = '"& mid(session("Ausercode"),6,5) &"' "
	end if
	SQL = sql & " and flag = '3' "
    SQL = sql & " and orderflag  in ("&inCnt&")"
	SQL = sql & " and idx not in ( "
	SQL = sql & " 	select distinct substring(usercode,11,5) "
	SQL = sql & " 	from tb_order where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	If searchordertime = "n" Or searchordertime ="" Then 
		SQL = sql & " 	and orderday >= '"& searchd &"' and orderday <= '"& searche &"' "
	Else 
		SQL = sql & "  and (convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "
		SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) )  "
	End If 
	SQL = sql & " 	) "
	SQL = sql & " order by idx desc "

	rslist.Open sql, db, 1
%>

<html>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<body>
<table border="1">
	<tr height=28 align=center>
		<td colspan=8>조회기간 : <%=searchd%> ~ <%=searche%></td>
	</tr>
	<tr height=28 align=center>
		<td>번호</td>
		<td>코드</td>
		<td>체인점명</td>
		<td>브랜드</td>
		<td>지사명</td>
		<td>전화번호</td>
		<td>핸드폰</td>
		<td>호차</td>
		<td>주문상태</td>
	</tr>

<%
i=1

do until rslist.EOF

	tel = rslist("tel1")&"-"&rslist("tel2")&"-"&rslist("tel3")
	hp  = rslist("hp1")&"-"&rslist("hp2")&"-"&rslist("hp3")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select dcarno "
	SQL = sql & " from tb_car "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " and idx = "& rslist("dcarno") &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsidcarname = rs(0)
	ELSE
		imsidcarname = ""
	end if
	rs.close

	if rslist("cbrandchoice")<>"" then
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select bname from tb_company_brand "
		SQL = sql & " where bidx = "& rslist("cbrandchoice") &" "
		rs.Open sql, db, 1
		if not rs.eof then
			imsibname = rs(0)
		end if
		rs.close
	else
		imsibname = ""
	end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select distinct comname from tb_company where idx = "& rslist("idxsub") &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsicomname = rs(0)
	end if
	rs.close
	
	orderflag = rslist("orderflag")
	
	If left(session("Ausercode"),5) = "19209" or left(session("Ausercode"),5) = "96338" Then 
		'misugum = "미수금1"
    misugum = "주문차단"
	Else
		misugum = "미수금"
	End if 
	
	if orderflag="y" then
		imsiorderflag = "주문중"
	elseif orderflag="1" then
		imsiorderflag = "<font color='red'>" & misugum & "(정지)"
	elseif orderflag="2" then
		imsiorderflag = "<font color='red'>폐업(정지)"
	elseif orderflag="3" then
		imsiorderflag = "<font color='red'>휴업(정비)"
	elseif orderflag="4" then
		imsiorderflag = "<font color='blue'>경고1(주문)"
	elseif orderflag="5" then
		imsiorderflag = "<font color='blue'>경고2(주문)"
	elseif orderflag="6" then
		'imsiorderflag = "<font color='red'>미수금2(정지)"
        imsiorderflag = "<font color='red'>시즈닝차단(정지)"
	end if
%>

	<tr height=25>
		<td><%=i%></td>
		<td><%=rslist("tcode")%></td>
		<td><%=rslist("comname")%></td>

		<td><%=imsibname%></td>
		<td><%=imsicomname%></td>
		<td><%=tel%></td>
		<td><%=hp%></td>
		<td><%=imsidcarname%></td>
		<td>
				
					<%=imsiorderflag%>
				
		</td>
	</tr>

</form>

<%
rslist.MoveNext 
i=i+1

loop
%>

</table>

<%
	rslist.close
	db.close
	set rs=nothing
	set rslist=nothing
	set db=nothing
%>

</body>
</html>