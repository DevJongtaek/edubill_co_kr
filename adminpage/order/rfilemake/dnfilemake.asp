<%
Server.ScriptTimeOut = 1000000
%>
<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/fun.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")

	searchaa = searcha&searchb
	searchcc = searchc&searchd

	imsifileflag = request("imsifileflag")	'���ϻ�������
	cbrandchoice = request("cbrandchoice")	'�귣��
	imsifnow = FunYMDHMS(now())

	if imsifileflag="7" then
		if cbrandchoice="" then
			filename     = "R"&"��ü-" & imsifnow &".txt"	'���ϸ�
		else
			sql = "select bname"
			sql = sql & " FROM tb_company_brand where bidx = "&cbrandchoice
			Set rs = db.execute(sql)
			if not rs.eof then
				filename     = "R"&left(rs(0),2)&"-"& imsifnow &".txt"	'���ϸ�
			else
				call FunErrorMsg("�ش� �ڷᰡ �����ϴ�.")
			end if
			rs.close
		end if
	else
		filename     = "R"&imsifnow &".txt"	'���ϸ�
	end if

	filepath     = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\txt\rmake\"	'���ϰ��
	filepathname = filepath&filename
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>

<%if imsifileflag="2" then%>
	<!--#include virtual="/adminpage/order/rfilemake/inc_2.asp"-->
<%elseif imsifileflag="3" then%>
	<!--#include virtual="/adminpage/order/rfilemake/inc_3.asp"-->
<%elseif imsifileflag="7" then%>
	<!--#include virtual="/adminpage/order/rfilemake/inc_7.asp"-->
<%elseif imsifileflag="9" then%>
	<!--#include virtual="/adminpage/order/rfilemake/inc_9.asp"-->
<%elseif imsifileflag="a" then%>
	<!--#include virtual="/adminpage/order/rfilemake/inc_a.asp"-->
<%elseif imsifileflag="4" then%>
	<!--#include virtual="/adminpage/order/rfilemake/inc_4.asp"-->
	<%elseif imsifileflag="b" then%>
	<!--#include virtual="/adminpage/order/rfilemake/inc_b.asp"-->
	<%elseif imsifileflag="c" then%>
	<!--#include virtual="/adminpage/order/rfilemake/inc_c.asp"-->
<%elseif imsifileflag="d" then%>
	<!--#include virtual="/adminpage/order/rfilemake/inc_d.asp"-->
<%elseif imsifileflag="e" then%>
	<!--#include virtual="/adminpage/order/rfilemake/inc_e.asp"-->
<%else%>
	<!--#include virtual="/adminpage/order/rfilemake/inc.asp"-->
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
	Sql = Sql & ",fileflag"
	Sql = Sql & ",filename"
	Sql = Sql & ") Values ("
	Sql = Sql & "'" & left(session("Ausercode"),5) & "',"
	Sql = Sql & "'" & left(yyyymmdd1, 8) & "',"
	Sql = Sql & "'" & right(yyyymmdd1, 6) & "',"
	Sql = Sql & "'" & left(yyyymmdd, 8) & "',"
	Sql = Sql & "'" & right(yyyymmdd, 6) & "',"
	Sql = Sql & "'" & min & "',"
	Sql = Sql & "'" & max & "',"
	Sql = Sql & "'" & order_num & "',"	'�ֹ��Ǽ� - ����Ʈ���� �߸��θ��Ƿ�
	Sql = Sql & " " & count_num & ","	'��ǰ�Ǽ�
	Sql = Sql & "'" & session("Ausercode") & "',"
	Sql = Sql & "'2',"
	Sql = Sql & "'" & filename & "')"
	db.execute(Sql)

	db.close
	set db=nothing

	jmsg = jmsg & "�� "& order_num &"���� �ֹ������͸� ���� �Ͽ����ϴ�.\n\n"
	jmsg = jmsg & "�������Ͻ� : "&mid(yyyymmdd1,1,4)&"/"&mid(yyyymmdd1,5,2)&"/"&mid(yyyymmdd1,7,2)&" "&mid(yyyymmdd1,9,2)&":"&mid(yyyymmdd1,11,2)&":"&mid(yyyymmdd1,13,2)&"\n"
	jmsg = jmsg & "�������Ͻ� : "&mid(yyyymmdd,1,4)&"/"&mid(yyyymmdd,5,2)&"/"&mid(yyyymmdd,7,2)&" "&mid(yyyymmdd,9,2)&":"&mid(yyyymmdd,11,2)&":"&mid(yyyymmdd,13,2) & "\n\n"
	jmsg = jmsg & "�ֹ� �ǰ� ȭ�ϻ��� ���� �ٸ� ���,\n"
	jmsg = jmsg & "�ֹ�����->��������� �ٽ� ���� �Ͻʽÿ�."

	call FunSucMsg(jmsg,"/adminpage/order/rfilemake/dlist.asp")
	'call FunSucMsg("������ �����߽��ϴ�.","/adminpage/order/rfilemake/dlist.asp")
%>
























