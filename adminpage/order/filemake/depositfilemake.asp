<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/fun.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	Server.ScriptTimeOut = 1000000

	imsifileflag = request("imsifileflag")	'���ϻ�������
	cbrandchoice = request("cbrandchoice")	'�귣��
	searchc = request("searchc")		
	searchd = request("searchd")
	imsifnow = FunYMDHMS(now())

	if imsifileflag="7" then
		if cbrandchoice="" then
			filename     = "��ü-" & imsifnow &".txt"	'���ϸ�
		else
			sql = "select bname"
			sql = sql & " FROM tb_company_brand where bidx = "&cbrandchoice
			Set rs = db.execute(sql)
			if not rs.eof then
				filename     = left(rs(0),2)&"-"& imsifnow &".txt"	'���ϸ�
			else
				call FunErrorMsg("�ش� �ڷᰡ �����ϴ�.")
			end if
			rs.close
		end if
	else
		filename     = imsifnow &".txt"	'���ϸ�
	end if

	filepath     = "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\txt_acct\"	'���ϰ��
	filepathname = filepath&filename
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile filepathname,true 
	Set objFile = fs.OpenTextFile(filepathname,8) 

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select '00' + isnull(chancode, '') + '|' + isnull(dep_amt, '') + '|0001|' + isnull(tr_il, '') + '|' + isnull(tr_si, '') + '|' + isnull(channame, '') data, tr_il, tr_si, idx "
	SQL = sql & "   from tb_virtual_acnt "
	SQL = sql & "  where cporg_cd = (select cporg_cd from tb_company where idx = '" & left(session("Ausercode"),5) & "') "	
	SQL = sql & " and isnull(flag, '') in ('', 'n') "
	SQL = sql & " order by tr_il "
	'response.write SQL
	rs.Open sql, db, 1

	rowcount = 0
	startdate = ""
	starttime = ""
	enddate = ""
	endtime = ""
	imsipidxArray = ""
	Do Until rs.eof 
		data = rs("data")
		If startdate = "" Then 
			startdate = rs("tr_il")
			starttime = rs("tr_si")
		End If 
	objFile.writeLine(data)
	enddate = rs("tr_il")
	endtime = rs("tr_si")
	imsipidxArray = imsipidxArray & "'" & rs("idx") & "'"
	rowcount= rowcount + 1
	rs.movenext
	Loop

	imsipidxArray = Replace(imsipidxArray, "''", "','")

	If rowcount > 0 Then 
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		objFile.close
		Sql = " INSERT INTO [edubill_co_kr].[dbo].[tb_DepositDownload] "
        Sql = Sql & " ([UserCode] "
        Sql = Sql & " ,[bidxsub] "
        Sql = Sql & " ,[StartDate] "
        Sql = Sql & " ,[StartTime] "
        Sql = Sql & " ,[EndDate] "
        Sql = Sql & " ,[EndTime] "
        Sql = Sql & " ,[CountNum] "
        Sql = Sql & " ,[FileName]) "
	    Sql = Sql & " VALUES "
        Sql = Sql & " ('" & session("Ausercode") & "' "
        Sql = Sql & " ,'" & left(session("Ausercode"),5) & "' "
        Sql = Sql & " ,'"& startdate & "' "
        Sql = Sql & " ,'"& starttime & "' "
        Sql = Sql & " ,'"& enddate & "' "
        Sql = Sql & " ,'"& endtime & "' "
        Sql = Sql & " ,'"& rowcount & "' "
        Sql = Sql & " ,'"& filename & "' "
        Sql = Sql & " ) "
		'response.write Sql
		db.execute(Sql)

		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		USql = "Update tb_virtual_acnt Set flag = 'y', flagidx = '"& filename &"' "
		USql = Usql & " where idx in ( "& imsipidxArray &" ) "
		'response.write USql
		db.execute(USql)
		''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

		db.close
		set db=nothing

		jmsg = jmsg & "�� "& rowcount &"���� �Աݵ����͸� ���� �Ͽ����ϴ�.\n\n"
		jmsg = jmsg & "�������Ͻ� : "&mid(startdate,1,4)&"/"&mid(startdate,5,2)&"/"&mid(startdate,7,2)&" "&mid(starttime,1,2)&":"&mid(starttime,3,2)&":"&mid(starttime,5,2)&"\n"
		jmsg = jmsg & "�������Ͻ� : "&mid(enddate,1,4)&"/"&mid(enddate,5,2)&"/"&mid(enddate,7,2)&" "&mid(endtime,1,2)&":"&mid(endtime,3,2)&":"&mid(endtime,5,2) & "\n\n"
'		jmsg = jmsg & "�Ա� �ǰ� ȭ�ϻ��� ���� �ٸ� ���,\n"
'		jmsg = jmsg & "�ֹ�����->��������� �ٽ� ���� �Ͻʽÿ�."

		call FunSucMsg(jmsg,"/adminpage/order/filemake/depositlist.asp")

		'call FunSucMsg("������ �����߽��ϴ�.","/adminpage/order/filemake/dlist.asp")
		'response.write "/adminpage/order/dlist.asp"
	Else 
		objFile.close
		call FunErrorMsg("�ش� �ڷᰡ �����ϴ�.")
	End If 	
%>