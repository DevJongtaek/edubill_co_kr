<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	Server.ScriptTimeOut = 1000000
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")

	searchaa = searcha&searchb
	searchcc = searchc&searchd

	o_yyy = replace(left(now(),10),"-","")
	ho = cstr(hour(time))
	if len(ho) = 1 then
		ho2 = "0"&ho
	else
		ho2 = ho
	end if
	mi = cstr(minute(time))
	if len(mi) = 1 then
		mi2 = "0"&mi
	else
		mi2 = mi
	end if
	se = cstr(second(time))
	if len(se) = 1 then
		se2 = "0"&se
	else
		se2 = se
	end if
	yyyymmdd_file = "R"&o_yyy&ho2&mi2&se2

	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\rfile\" & yyyymmdd_file & ".txt",true 
	Set objFile = fs.OpenTextFile("D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\rfile\" & yyyymmdd_file & ".txt",8) 

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT fileflag from tb_company where idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
	imsifileflag = rs(0)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT A.bidxsub, C.pidx, B.idx, A.tcode, C.pcode, C.rordernum, C.flag, isnull(b.request_day,'') as request_day "
	SQL = sql & " FROM tb_company A, tb_order B, tb_order_product C"
	SQL = sql & " WHERE A.idx = right(B.usercode, 5)"
	SQL = sql & " AND B.idx = C.idx"
	SQL = sql & " AND C.flag = 'T'"
	SQL = sql & " AND substring(C.idx,1,14) >= '"& searchaa &"' and substring(C.idx,1,14) <= '"& searchcc &"' "
	SQL = sql & " AND C.rordernum > 0 "
	SQL = sql & " AND A.bidxsub = '" & left(session("Ausercode"),5) & "'" 
	if session("Ausergubun")="3" then
		SQL = sql & " AND substring(b.usercode,1,10) = '" & session("Ausercode") & "'" 
	end if
	SQL = sql & " order by C.pidx"
	rs.Open sql, db, 1

if not rs.eof then

	j=1
	order_num=0
	Do Until rs.EOF
		if rs("idx") <> oldimsiidx then
			order_num = order_num+1
		end if
		oldimsiidx = rs("idx")

		str = ""
		onlen = len(Trim(rs("rordernum")))
		onlen1 = 5-onlen
		for i = 1 to onlen1
			str = str & " "
		next
		ordernum = Trim(rs("rordernum")) & str

		'0:사용안함
		'1:Text 1 (에듀빌 포멧)
		'2:Text 2 (CJ 포멧, 주문일자)xxxx
		'3:Text 3 (CJ 포멧, 배송일자/확인건)xxxx
		'7:Text 4 (에듀빌 포멧, 주문확인건만)xxxx
		'8:Text 5 (에듀빌 포멧, 배달요청일자)
		'9:Text 6 (CJ 포멧, 배달요청일자)xxxx
		'4:Excel 1
		'5:Excel 2
		'6:Excel 3

		if imsifileflag="8" then
			str = ""
			if rs("request_day")<>"" then
				onlen = len(Trim(rs("request_day")))
				onlen1 = 4-onlen
				for i = 1 to onlen1
					str = str & " "
				next
				request_day = Trim(rs("request_day")) & str
			else
				request_day = "    "
			end if
			objFile.writeLine(LEFT(Trim(rs("idx")),14) & Trim(rs("tcode")) & Trim(rs("pcode")) & ordernum & request_day)
		else
			objFile.writeLine(LEFT(Trim(rs("idx")),14) & Trim(rs("tcode")) & Trim(rs("pcode")) & ordernum)
		end if

	rs.MoveNext
	j=j+1
	Loop
	objFile.close

	if order_num="" then
		order_num = 0
	end if
	fileflag = "2"

	Sql = "Insert into tb_download ("
	Sql = Sql & " bidxsub"
	Sql = Sql & ",start_date"
	Sql = Sql & ",start_time"
	Sql = Sql & ",end_date"
	Sql = Sql & ",end_time"
	Sql = Sql & ",start_idx"
	Sql = Sql & ",end_idx"
	Sql = Sql & ",count_num"
	Sql = Sql & ",order_num"
	Sql = Sql & ",usercode"
	Sql = Sql & ",filename"
	Sql = Sql & ",fileflag"
	Sql = Sql & ") Values ("
	Sql = Sql & "'" & left(session("Ausercode"),5) & "',"
	Sql = Sql & "'" & searcha & "',"
	Sql = Sql & "'" & searchb & "',"
	Sql = Sql & "'" & searchc & "',"
	Sql = Sql & "'" & searchd & "',"
	Sql = Sql & "'" & min & "',"
	Sql = Sql & "'" & max & "',"
	Sql = Sql & "'" & order_num & "',"
	Sql = Sql & " " & order_num & ","
	Sql = Sql & "'" & session("Ausercode") & "',"
	Sql = Sql & "'" & yyyymmdd_file & ".txt' ,"
	Sql = Sql & "'" & fileflag &"' )"
	db.execute(Sql)

	db.close
	set db=nothing

	response.redirect "redlist.asp"

else

	response.write "<SCRIPT language=javascript>"
	response.write "alert('해당하는 자료가 없습니다');"
	response.write "history.go(-1);"
	response.write "</SCRIPT>"

end if
%>