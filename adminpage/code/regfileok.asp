<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%

	searcha = request("searcha")
	searchb = request("searchb")
	if len(searchb)=1 then
		searchb = "0"&searchb
	end if
	'searchc = request("searchc")
	'if len(searchc)=1 then
	'	searchc = "0"&searchc
	'end if

	searchc = "01"
	searchd = "31"
	imsifilename = searcha&searchb
	aday = searcha&searchb&searchc
	bday = searcha&searchb&searchd

	comname = request("comname")

	Function FunCheck1(fvalue,fsize)
		imsistr = ""
		fcheckvalue = len(Trim(fvalue))
		fcheckvalue1 = int(fsize)-int(fcheckvalue)
		if fcheckvalue1 > 0 then
			for i = 1 to fcheckvalue1
				imsistr = "0" & imsistr
			next
			FunCheck1 = imsistr&Trim(fvalue)
		else
			FunCheck1 = Trim(fvalue)
		end if

	End Function

	Function FunCheck2(fvalue,fsize)
		aimsistr = ""
		afcheckvalue = len(Trim(fvalue))
		afcheckvalue1 = int(fsize)-int(afcheckvalue)
		if afcheckvalue1 > 0 then
			for i = 1 to afcheckvalue1
				aimsistr = aimsistr & " "
			next
			FunCheck2 = fvalue & aimsistr
		else
			FunCheck2 = fvalue
		end if
	End Function

	function FunCheck3(str)
		for i=1 to len(str)
        		charat=mid(str, i, 1)
        		if asc(charat)>0 and asc(charat)<255 then
            			wLen=wLen+1
        		else
            			wLen=wLen+2
        		end if
    		next

		astr = str
		for i = 1 to (20-wLen)
			astr = astr & " "
		next

    		FunCheck3 = astr

	end function 

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " SELECT b.* "
	SQL = sql & " FROM tb_company a, tb_company b "
	SQL = sql & " where a.idx = b.bidxsub "
	SQL = sql & " and a.flag='1' and b.flag='3' "
	SQL = sql & " and b.idx in "
	SQL = sql & " 		( "
	SQL = sql & " 		SELECT distinct c.idx "
	SQL = sql & " 		FROM tb_company c, tb_order d "
	SQL = sql & " 		where c.idx = substring(d.usercode,11,5) "
	SQL = sql & " 		and c.flag = '3' "
	SQL = sql & " 		and d.orderday >= '"& aday &"' and d.orderday <= '"& bday &"' "
	SQL = sql & " 		) "

	if request("comname") <> "" then
		SQL = sql & " and b.bidxsub = "& request("comname") &" "
	end if

	SQL = sql & " and a.usegubun = '2' "
	SQL = sql & " order by a.tcode asc, b.tcode asc "
	rs.Open sql, db, 1

	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\regmake\" & imsifilename & ".txt",true 
	Set objFile = fs.OpenTextFile("D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\regmake\" & imsifilename & ".txt",8) 

	i=1
	imsitxtcount = 0
	Do Until rs.EOF

		tel1 = ""
		tel2 = ""
		tel3 = ""
		tel = ""
		hapday = ""
		imsiidx = ""
		imsibidxsub = ""
		usercode = ""
		usemoney = ""
		jumincheck = ""
		jumin1 = ""
		jumin2 = ""
		jumin = ""
		comname = ""
		telname = ""
		f1 = ""
		f2 = ""
		f3 = ""
		f4 = ""
		f5 = ""
		f6 = ""
		f7 = ""
		f8 = ""
		f9 = ""
		f10 = ""
		f11 = ""

		imsif1=""
		imsif2=""
		imsif3=""
		imsif4=""
		imsif5=""
		imsif6=""
		imsif=""
		imsitxt1 = ""
		imsitxt2 = ""
		imsitxt3 = ""
		imsitxt4 = ""
		imsitxt5 = ""
		imsiidx = ""
		imsibidxsub = ""
		imsiatcode = ""
		imsibtcode = ""

		if isnull(rs("ctel1")) or isnull(rs("ctel2")) or isnull(rs("ctel3")) then
			tel = "000000000000"
		else
			tel1 = FunCheck1(trim(rs("ctel1")),4)
			tel2 = FunCheck1(trim(rs("ctel2")),4)
			tel3 = FunCheck1(trim(rs("ctel3")),4)
			tel = tel1&tel2&tel3
			tel = FunCheck1(tel,12)
		end if

		if isnull(rs("hapday")) then
			hapday = "00000000"
		else
			hapday = trim(rs("hapday"))
		end if
		hapday = FunCheck1(hapday,8)

		imsiidx = trim(rs("idx"))
		imsibidxsub = trim(rs("bidxsub"))
		usercode = imsibidxsub&imsiidx
		usercode = FunCheck1(usercode,16)

		set rs2 = server.CreateObject("ADODB.Recordset")
		SQL = "SELECT usemoney,tcode "
		SQL = sql & " FROM tb_company"
		SQL = sql & " where idx = "& rs("bidxsub") &" "
		rs2.Open sql, db, 1
		if isnull(rs2("usemoney")) then
			usemoney = 0
		else
			usemoney = rs2("usemoney")
		end if
		imsiatcode = rs2(1)
		rs2.close
		usemoney = FunCheck1(usemoney,10)
		imsibtcode = trim(rs("tcode"))
		usercode = imsiatcode&imsibtcode
		usercode = FunCheck1(usercode,16)

		if isnull(rs("jumincheck")) or rs("jumincheck")="" or rs("jumincheck")="n" then
			imsijumincheck = "0"
		else
			imsijumincheck = "1"
		end if

		if isnull(rs("jumin1")) or isnull(rs("jumin2")) or rs("jumin1")="" or rs("jumin2")="" then
			jumin1 = ""
			jumin2 = ""
		else
			jumin1 = trim(rs("jumin1"))
			jumin2 = trim(rs("jumin2"))
		end if
		jumin = FunCheck1(jumin1&jumin2,13)

		if isnull(rs("comname")) then
			comname = ""
		else
			comname = trim(rs("comname"))
			comname = FunCheck3(comname)
		end if

		if isnull(rs("telname")) then
			telname = ""
		else
			telname = trim(rs("telname"))
		end if
		telname = FunCheck3(telname)

		'��ȭ��ȣ,�ջ��û��,û���ݾ�,�ֹε�Ϲ�ȣ,ü������,KT������
		'ctel1,ctel2,ctel3,hapday,usemoney,jumin1,jumin2,comname,telname

		'if tel="000000000000" or hapday="00000000" or usemoney="0000000000" or jumin="0000000000000" or comname="                    " or telname="                    " then
		if tel="000000000000" or hapday="00000000" or usemoney="0000000000" or comname="                    " or telname="                    " then
		else
			f1 = "D"		'���� 1
			f2 = "0326000015"	'�ջ���ڵ� 10
			f3 = tel		'��ȭ��ȣ 12
			f4 = hapday		'�ջ��û�� 8
			f5 = usercode		'userid 16
			f6 = usemoney		'û���ݾ� 10
			f7 = jumin		'�ֹι�ȣ 13
			f8 = imsijumincheck	'CK 
			f9 = "5155"		'����׸� 4
			f10 = comname		'���� 20
			f11 = telname		'KT��ȭ������ 20

			imsiwriteline = f1&f2&f3&f4&f5&f6&f7&f8&f9&f10&f11
			objFile.writeLine(imsiwriteline)
			imsitxtcount = imsitxtcount+1
		end if

	rs.MoveNext
	i=i+1
	Loop
	objFile.close
	rs.close
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " SELECT b.* "
	SQL = sql & " FROM tb_company a, tb_company b "
	SQL = sql & " where a.idx = b.bidxsub "
	SQL = sql & " and a.flag='1' and b.flag='3' "
	SQL = sql & " and b.idx in "
	SQL = sql & " 		( "
	SQL = sql & " 		SELECT distinct c.idx "
	SQL = sql & " 		FROM tb_company c, tb_order d "
	SQL = sql & " 		where c.idx = substring(d.usercode,11,5) "
	SQL = sql & " 		and c.flag = '3' "
	SQL = sql & " 		and d.orderday >= '"& aday &"' and d.orderday <= '"& bday &"' "
	SQL = sql & " 		) "

	if request("comname") <> "" then
		SQL = sql & " and b.bidxsub = "& request("comname") &" "
	end if

	SQL = sql & " and a.usegubun = '2' "
	SQL = sql & " order by a.tcode asc, b.tcode asc "
	rs.Open sql, db, 1

	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	fs.CreateTextFile "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\regmake\error.log",true 
	Set objFile = fs.OpenTextFile("D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\regmake\error.log",8) 

	i=1
	imsierrorcount=0
	Do Until rs.EOF
		tel1 = ""
		tel2 = ""
		tel3 = ""
		tel = ""
		hapday = ""
		imsiidx = ""
		imsibidxsub = ""
		usercode = ""
		usemoney = ""
		jumincheck = ""
		jumin1 = ""
		jumin2 = ""
		jumin = ""
		comname = ""
		telname = ""
		f1 = ""
		f2 = ""
		f3 = ""
		f4 = ""
		f5 = ""
		f6 = ""
		f7 = ""
		f8 = ""
		f9 = ""
		f10 = ""
		f11 = ""

		imsif1=""
		imsif2=""
		imsif3=""
		imsif4=""
		imsif5=""
		imsif6=""
		imsif=""
		imsitxt1 = ""
		imsitxt2 = ""
		imsitxt3 = ""
		imsitxt4 = ""
		imsitxt5 = ""
		imsiidx = ""
		imsibidxsub = ""

		if isnull(rs("ctel1")) or isnull(rs("ctel2")) or isnull(rs("ctel3")) then
			tel = "000000000000"
		else
			tel1 = FunCheck1(trim(rs("ctel1")),4)
			tel2 = FunCheck1(trim(rs("ctel2")),4)
			tel3 = FunCheck1(trim(rs("ctel3")),4)
			tel = tel1&tel2&tel3
			tel = FunCheck1(tel,12)
		end if

		if isnull(rs("hapday")) then
			hapday = "00000000"
		else
			hapday = trim(rs("hapday"))
		end if
		hapday = FunCheck1(hapday,8)

		imsiidx = trim(rs("idx"))
		imsibidxsub = trim(rs("bidxsub"))
		usercode = imsibidxsub&imsiidx
		usercode = FunCheck1(usercode,16)

		set rs2 = server.CreateObject("ADODB.Recordset")
		SQL = "SELECT usemoney,tcode "
		SQL = sql & " FROM tb_company"
		SQL = sql & " where idx = "& rs("bidxsub") &" "
		rs2.Open sql, db, 1
		if isnull(rs2("usemoney")) then
			usemoney = ""
		else
			usemoney = rs2("usemoney")
		end if
		imsiatcode = rs2(1)
		rs2.close
		usemoney = FunCheck1(usemoney,10)
		imsibtcode = trim(rs("tcode"))
		usercode = imsiatcode&imsibtcode
		usercode = FunCheck1(usercode,8)

		if isnull(rs("jumincheck")) or rs("jumincheck")="" or rs("jumincheck")="n" then
			imsijumincheck = "0"
		else
			imsijumincheck = "1"
		end if

		if isnull(rs("jumin1")) or isnull(rs("jumin2")) or rs("jumin1")="" or rs("jumin2")="" then
			jumin1 = ""
			jumin2 = ""
		else
			jumin1 = trim(rs("jumin1"))
			jumin2 = trim(rs("jumin2"))
		end if
		jumin = FunCheck1(jumin1&jumin2,13)

		if isnull(rs("comname")) then
			comname = ""
		else
			comname = trim(rs("comname"))
			comname = FunCheck3(comname)
		end if

		if isnull(rs("telname")) then
			telname = ""
		else
			telname = trim(rs("telname"))
		end if
		telname = FunCheck2(telname,20)

		'��ȭ��ȣ,�ջ��û��,û���ݾ�,�ֹε�Ϲ�ȣ,ü������,KT������
		'ctel1,ctel2,ctel3,hapday,usemoney,jumin1,jumin2,comname,telname

		'if tel="000000000000" or hapday="00000000" or usemoney="0000000000" or jumin="0000000000000" or comname="                    " or telname="                    " then
		if tel="000000000000" or hapday="00000000" or usemoney="0000000000" or comname="                    " or telname="                    " then
			if tel="000000000000" then
				imsif1 = "��ȭ��ȣ"
			end if

			if hapday="00000000" then
				imsif2 = "�ջ��û��"
			end if

			if usemoney="0000000000" then
				imsif3 = "û���ݾ�"
			end if

			if jumin="0000000000000" then
				imsif4 = "�ֹε�Ϲ�ȣ"
			end if

			if comname="                    " then
				imsif5 = "ü������"
			end if

			if telname="                    " then
				imsif6 = "KT������"
			end if

			imsif = imsif1&","&imsif2&","&imsif3&","&imsif5&","&imsif6
			for jj=1 to 6
				if left(imsif,1)="," then
					imsif = mid(imsif,2)
				end if
				imsif = replace(imsif,",,",",")
				if right(imsif,1)="," then
					imsif = left(imsif,len(imsif)-1)
				end if
			next

			imsitxt1 = "E "
			imsiidx = trim(rs("idx"))
			imsibidxsub = trim(rs("bidxsub"))
			imsitxt2 = usercode&" "

			set rs2 = server.CreateObject("ADODB.Recordset")
			SQL = "SELECT comname "
			SQL = sql & " FROM tb_company"
			SQL = sql & " where idx = "& rs("bidxsub")
			rs2.Open sql, db, 1
			imsitxt3 = rs2(0)			'ȸ�����
			rs2.close

			imsitxt4 = "-"
			imsitxt5 = FunCheck2(rs("comname"),10)	'ü������

			imsiwriteline = imsitxt1&imsitxt2&imsitxt3&imsitxt4&imsitxt5&imsif
			objFile.writeLine(imsiwriteline)
			imsierrorcount=imsierrorcount+1
		else
		end if

	rs.MoveNext
	i=i+1
	Loop
	objFile.close
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT idx,comname,tcode "
	SQL = sql & " FROM tb_company"
	SQL = sql & " where flag='1' "
	if request("comname") <> "" then
		SQL = sql & " and idx = "& request("comname") &" "
	end if
	SQL = sql & " and usegubun = '2' "	'�̿�ᳳ���ڰ� ü�����ΰ͸�
	SQL = sql & " order by tcode asc"
	rs.Open sql, db, 1

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	imsifilename2 = trim(imsifilename)&".txt"
%>

<!--#include virtual="/adminpage/incfile/top.asp"-->

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td> &nbsp; <font color=blue size=3><B>[ û��ȭ�� ���� ����Ʈ ]</td>
	</tr>
</table>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr> 
		<td nowrap width="15%" bgcolor="#F7F7FF" height="25"> &nbsp; <B>û��ȭ��</td>
		<td nowrap width="35%" bgcolor="#FFFFFF">&nbsp;
			<%if imsitxtcount > 0 then%><a href=regdown.asp?f_name=<%=imsifilename2%>><%=imsifilename2%></a><%end if%>
		</td>
		<td nowrap width="15%" bgcolor="#F7F7FF" height="25"> &nbsp; <B>��������</td>
		<td nowrap width="35%" bgcolor="#FFFFFF">&nbsp;
			<%if imsierrorcount > 0 then%><a href="regdown.asp?f_name=error.log">error.log</a><%end if%>
		</td>
	</tr>
</table>

<BR>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr align=center>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25"><B>��ȣ</td>
		<td nowrap width="15%" bgcolor="#F7F7FF" height="25"><B>ȸ�����ڵ�</td>
		<td nowrap width="20%" bgcolor="#F7F7FF" height="25"><B>ȸ�����</td>
		<td nowrap width="15%" bgcolor="#F7F7FF" height="25"><B>���� ü����</td>
		<td nowrap width="15%" bgcolor="#F7F7FF" height="25"><B>�̻�� ü����</td>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25"><B>�����߻�</td>
		<td nowrap width="15%" bgcolor="#F7F7FF" height="25"><B>û���ݾ�</td>
	</tr>

<%
	ii=1
	imsiimsihap1=0
	imsiimsihap2=0
	imsiimsihap3=0
	imsiimsihap4=0

	do until rs.eof

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " SELECT b.* "
	SQL = sql & " FROM tb_company a, tb_company b "
	SQL = sql & " where a.idx = b.bidxsub "
	SQL = sql & " and a.flag='1' and b.flag='3' "
	SQL = sql & " and b.idx in "
	SQL = sql & " 		( "
	SQL = sql & " 		SELECT distinct c.idx "
	SQL = sql & " 		FROM tb_company c, tb_order d "
	SQL = sql & " 		where c.idx = substring(d.usercode,11,5) "
	SQL = sql & " 		and c.flag = '3' "
	SQL = sql & " 		and d.orderday >= '"& aday &"' and d.orderday <= '"& bday &"' "
	SQL = sql & " 		) "
	SQL = sql & " and b.bidxsub = "& rs("idx") &" "
	SQL = sql & " and a.usegubun = '2' "
	SQL = sql & " order by a.tcode asc, b.tcode asc "
	rs2.Open sql, db, 1


	i=1
	imsitxtcount = 0
	imsiacount=0
	imsibcount=0
	imsibcountmoney=0
	Do Until rs2.EOF

		tel1 = ""
		tel2 = ""
		tel3 = ""
		tel = ""
		hapday = ""
		imsiidx = ""
		imsibidxsub = ""
		usercode = ""
		usemoney = ""
		usemoney2 = 0
		jumincheck = ""
		jumin1 = ""
		jumin2 = ""
		jumin = ""
		comname = ""
		telname = ""
		f1 = ""
		f2 = ""
		f3 = ""
		f4 = ""
		f5 = ""
		f6 = ""
		f7 = ""
		f8 = ""
		f9 = ""
		f10 = ""
		f11 = ""

		imsif1=""
		imsif2=""
		imsif3=""
		imsif4=""
		imsif5=""
		imsif6=""
		imsif=""
		imsitxt1 = ""
		imsitxt2 = ""
		imsitxt3 = ""
		imsitxt4 = ""
		imsitxt5 = ""
		imsiidx = ""
		imsibidxsub = ""

		if isnull(rs2("ctel1")) or isnull(rs2("ctel2")) or isnull(rs2("ctel3")) then
			tel = "000000000000"
		else
			tel1 = FunCheck1(trim(rs2("ctel1")),4)
			tel2 = FunCheck1(trim(rs2("ctel2")),4)
			tel3 = FunCheck1(trim(rs2("ctel3")),4)
			tel = tel1&tel2&tel3
			tel = FunCheck1(tel,12)
		end if

		if isnull(rs2("hapday")) then
			hapday = "00000000"
		else
			hapday = trim(rs2("hapday"))
		end if
		hapday = FunCheck1(hapday,8)

		imsiidx = trim(rs2("idx"))
		imsibidxsub = trim(rs2("bidxsub"))
		usercode = imsibidxsub&imsiidx
		usercode = FunCheck1(usercode,16)

		set rs3 = server.CreateObject("ADODB.Recordset")
		SQL = "SELECT usemoney,tcode "
		SQL = sql & " FROM tb_company"
		SQL = sql & " where idx = "& rs2("bidxsub") &" "
		rs3.Open sql, db, 1
		usemoney = rs3("usemoney")
		usemoney2 = rs3("usemoney")
		imsiatcode = rs3(1)
		rs3.close
		usemoney = FunCheck1(usemoney,10)
		imsibtcode = trim(rs2("tcode"))
		usercode = imsiatcode&imsibtcode
		usercode = FunCheck1(usercode,16)

		if isnull(rs2("jumincheck")) or rs2("jumincheck")="" or rs2("jumincheck")="n" then
			imsijumincheck = "0"
		else
			imsijumincheck = "1"
		end if

		if isnull(rs2("jumin1")) or isnull(rs2("jumin2")) or rs2("jumin1")="" or rs2("jumin2")="" then
			jumin1 = ""
			jumin2 = ""
		else
			jumin1 = trim(rs2("jumin1"))
			jumin2 = trim(rs2("jumin2"))
		end if
		jumin = FunCheck1(jumin1&jumin2,13)

		if isnull(rs2("comname")) then
			comname = ""
		else
			comname = trim(rs2("comname"))
			comname = FunCheck3(comname)
		end if

		if isnull(rs2("telname")) then
			telname = ""
		else
			telname = trim(rs2("telname"))
		end if
		telname = FunCheck2(telname,20)

		'��ȭ��ȣ,�ջ��û��,û���ݾ�,�ֹε�Ϲ�ȣ,ü������,KT������
		'ctel1,ctel2,ctel3,hapday,usemoney,jumin1,jumin2,comname,telname
		'if tel="000000000000" or hapday="00000000" or usemoney="0000000000" or jumin="0000000000000" or comname="                    " or telname="                    " then
		if tel="000000000000" or hapday="00000000" or usemoney="0000000000" or comname="                    " or telname="                    " then
			imsiacount = imsiacount+1
		else
			imsibcount = imsibcount+1
			imsibcountmoney = imsibcountmoney+usemoney2
		end if

	rs2.MoveNext
	i=i+1
	Loop
	rs2.close

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " SELECT count(idx) "
	SQL = sql & " FROM tb_company"
	SQL = sql & " where flag = '3' "
	SQL = sql & " and bidxsub = '"& rs("idx") &"' "
	rs2.Open sql, db, 1
	allsayong = 0
	allsayong = rs2(0)
	rs2.close
	misayong = 0
	misayong = allsayong-(imsiacount+imsibcount)
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	imsiimsihap1=imsiimsihap1+imsibcount
	imsiimsihap2=imsiimsihap2+misayong
	imsiimsihap3=imsiimsihap3+imsiacount
	imsiimsihap4=imsiimsihap4+imsibcountmoney
%>




	<tr align=center bgcolor="#ffffff" height="25">
		<td><%=ii%></td>
		<td><%=rs("tcode")%></td>
		<td><%=rs("comname")%></td>
		<td><%=imsibcount%></td>
		<td><%=misayong%></td>
		<td><%=imsiacount%></td>
		<td><%=FormatCurrency(imsibcountmoney)%></td>
	</tr>

<%
	rs.movenext
	ii=ii+1
	loop
	rs.close
%>

	<tr align=center bgcolor="#ffffff" height="25">
		<td colspan=3>�հ�</td>
		<td><%=imsiimsihap1%></td>
		<td><%=imsiimsihap2%></td>
		<td><%=imsiimsihap3%></td>
		<td><%=FormatCurrency(imsiimsihap4)%></td>
	</tr>
</table>
				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<%
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->