<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/fun.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	Server.ScriptTimeOut = 1000000

	imsifileflag = request("imsifileflag")	'파일생성구분
	cbrandchoice = request("cbrandchoice")	'브랜드
	searchc = request("searchc")		
	searchd = request("searchd")
	imsifnow = FunYMDHMS(now())


	if imsifileflag="7" then
		if cbrandchoice="" then
			filename     = "전체-" & imsifnow &".txt"	'파일명
		else
			sql = "select bname"
			sql = sql & " FROM tb_company_brand where bidx = "&cbrandchoice
			Set rs = db.execute(sql)
			if not rs.eof then
				filename     = left(rs(0),2)&"-"& imsifnow &".txt"	'파일명
			else
				call FunErrorMsg("해당 자료가 없습니다.")
			end if
			rs.close
		end if
	else
		filename     = imsifnow &".txt"	'파일명
	end if

	filepath     = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\txt\"	'파일경로
	filepathname = filepath&filename
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>

<%if imsifileflag="2" then%>
	<!--#include virtual="/adminpage/order/filemake/inc_2.asp"-->
<%elseif imsifileflag="3" then%>
	<!--#include virtual="/adminpage/order/filemake/inc_3.asp"-->
<%elseif imsifileflag="7" then%>
	<!--#include virtual="/adminpage/order/filemake/inc_7.asp"-->
<%elseif imsifileflag="9" then%>
	<!--#include virtual="/adminpage/order/filemake/inc_9.asp"-->
<%elseif imsifileflag="a" then%>
	<!--#include virtual="/adminpage/order/filemake/inc_a.asp"-->
<%elseif imsifileflag="4" then%>
	<!--#include virtual="/adminpage/order/filemake/inc_4.asp"-->
	<%elseif imsifileflag="b" then%>
	<!--#include virtual="/adminpage/order/filemake/inc_b.asp"-->
	<%elseif imsifileflag="c" then%>
	<!--#include virtual="/adminpage/order/filemake/inc_c.asp"-->
<%elseif imsifileflag="d" then%>
	<!--#include virtual="/adminpage/order/filemake/inc_d.asp"-->
<%elseif imsifileflag="e" then%>
	<!--#include virtual="/adminpage/order/filemake/inc_e.asp"-->
<%else%>
	<!--#include virtual="/adminpage/order/filemake/inc.asp"-->
<%end if%>

<%
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
	Sql = Sql & ") Values ("
	Sql = Sql & "'" & left(session("Ausercode"),5) & "',"
	Sql = Sql & "'" & left(yyyymmdd1, 8) & "',"
	Sql = Sql & "'" & mid(yyyymmdd1, 9,6) & "',"
	Sql = Sql & "'" & left(yyyymmdd, 8) & "',"
	Sql = Sql & "'" & mid(yyyymmdd, 9,6) & "',"
	Sql = Sql & "'" & min & "',"
	Sql = Sql & "'" & max & "',"
	Sql = Sql & "'" & order_num & "',"	'주문건수 - 리스트에서 잘못부르므로
	Sql = Sql & " " & count_num & ","	'상품건수
	Sql = Sql & "'" & session("Ausercode") & "',"
	Sql = Sql & "'" & filename & "')"
	db.execute(Sql)

	db.close
	set db=nothing

	jmsg = jmsg & "총 "& order_num &"건의 주문데이터를 생성 하였습니다.\n\n"
	jmsg = jmsg & "▶시작일시 : "&mid(yyyymmdd1,1,4)&"/"&mid(yyyymmdd1,5,2)&"/"&mid(yyyymmdd1,7,2)&" "&mid(yyyymmdd1,9,2)&":"&mid(yyyymmdd1,11,2)&":"&mid(yyyymmdd1,13,2)&"\n"
	jmsg = jmsg & "▶종료일시 : "&mid(yyyymmdd,1,4)&"/"&mid(yyyymmdd,5,2)&"/"&mid(yyyymmdd,7,2)&" "&mid(yyyymmdd,9,2)&":"&mid(yyyymmdd,11,2)&":"&mid(yyyymmdd,13,2) & "\n\n"
	jmsg = jmsg & "주문 건과 화일생성 건이 다른 경우,\n"
	jmsg = jmsg & "주문관리->재생성에서 다시 생성 하십시오."

	call FunSucMsg(jmsg,"/adminpage/order/filemake/dlist.asp")

	'call FunSucMsg("파일을 생성했습니다.","/adminpage/order/filemake/dlist.asp")
	'response.write "/adminpage/order/dlist.asp"
%>