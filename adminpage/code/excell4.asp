<%
	response.buffer=true
	response.contenttype="application/vnd.ms-excel" 
	Response.AddHeader "Content-Disposition","attachment;filename=Sheet1.xls"
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
	flag = request("flag")
	if flag="1" then
		imsititlename = "ȸ����"
	elseif flag="2" then
		imsititlename = "����(��)"
	elseif flag="3" then
		imsititlename = "ü����"
	end if

	if searchc="" then
		searchc = "0"
	end if
	if searchf="" then
		searchf = "0"
	end if
	if searchg="" then
		searchg = "0"
	end if
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	'if session("Ausergubun")="2" then
	'	searchc = session("Ausercode")
	'end if

	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,tcode,flag,idxsub,comname,name,post,addr,addr2,companynum1,companynum2,companynum3,uptae,upjong,tel1,tel2,tel3,fax1,fax2,fax3,hp1,hp2,hp3,dcarno,startday,cbrandchoice,usemoney, isnull(dcode,'') as dcode "
	SQL = sql & " ,virtual_acnt2_bank,virtual_acnt2,fileflag,myflag,smsflag,cyberNum,cporg_cd,virtual_acnt_bank,adminProgram,homepage"
	SQL = sql & " from tb_company "
	SQL = sql & " where flag = '"& flag &"' "

	if session("Ausergubun")="2" then	'����α���
		if flag="1" then		'���縮��Ʈ
			SQL = sql & " and idx = "& int(left(session("Ausercode"),5)) &" "
		elseif flag="2" then		'���縮��Ʈ
			SQL = sql & " and bidxsub = "& int(left(session("Ausercode"),5)) &" "
		elseif flag="3" then		'ü��������Ʈ
			SQL = sql & " and bidxsub = "& int(left(session("Ausercode"),5)) &" "
		end if
	elseif session("Ausergubun")="3" then	'����
		if flag="2" then		'���縮��Ʈ
			SQL = sql & " and bidxsub = "& int(left(session("Ausercode"),5)) &" "
		elseif flag="3" then		'ü��������Ʈ
			SQL = sql & " and bidxsub = "& int(left(session("Ausercode"),5)) &" "
			SQL = sql & " and idxsub = "& int(mid(session("Ausercode"),6,5)) &" "
		end if
	elseif session("Ausergubun")="4" then	'ü����
		SQL = sql & " and bidxsub = "& int(left(session("Ausercode"),5)) &" "
		SQL = sql & " and idxsub = "& int(mid(session("Ausercode"),6,5)) &" "
	end if

	if searcha <> "" then
		if searcha = "sdname" then
			SQL = sql & " and idx in (select usercode from tb_adminuser where flag='2' and username like '%"& searchb &"%' ) "
		elseif searcha = "userid" then
			SQL = sql & " and idx in (select usercode from tb_adminuser where flag='2' and userid = '"& searchb &"' ) "
		else
			SQL = sql & " and "& searcha &" like '"& searchb &"%' "
		end if
	end if

	if session("Ausergubun")="1" then
		if searchc <> "0" and searchc <> "" then
			SQL = sql & " and serviceflag = '"& searchc &"' "
		end if
	else
		if searchc <> "0" and searchc <> "" then
			SQL = sql & " and idxsub = "& searchc &" "
		end if
	end if

	'if searchc <> "0" and searchc <> "" then
	'	SQL = sql & " and idxsub = "& searchc &" "
	'end if

	if searchd <> "" then
		SQL = sql & " and startday >= "& int(searchd) &" "
	end if

	if searche <> "" then
		SQL = sql & " and startday <= "& int(searche) &" "
	end if

	if searchf <> "0" then
		SQL = sql & " and idxsub = "& int(searchf) &" "
	end if

	if searchg <> "0" then
		SQL = sql & " and dcarno = "& int(searchg) &" "
	end if

	if session("Ausergubun")="1" then
		SQL = sql & " order by wdate desc"
	else
		SQL = sql & " order by tcode desc"
	end if

	rslist.Open sql, db, 1

	if flag="3" then
		'����(��)
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select idx,comname from tb_company where flag='2' and bidxsub = "& left(session("Ausercode"),5) &" order by comname asc"
		rs.Open sql, db, 1
		if not rs.eof then
			jisaarray = rs.GetRows
			jisaarrayint = ubound(jisaarray,2)
		else
			jisaarray = ""
			jisaarrayint = ""
		end if
		rs.close
		if searchc="" then
			searchc = "0"
		end if
	end if

	'ȣ��
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,dcarno "
	SQL = sql & " from tb_car "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " order by dcarno asc"
	rs.Open sql, db, 1
	if not rs.eof then
		hcararray = rs.GetRows
		hcararrayint = ubound(hcararray,2)
	else
		hcararray = ""
		hcararrayint = ""
	end if
	rs.close
%>

<html>
<head>
<title>edubill.co.kr</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<style type="text/css">
<!--
td.accountnum
{mso-number-format:\@}
-->
</STYLE>
</head>

<table border="1">
	<tr height=28 align=center>
		<td>��ȣ</td>
		<td>ȸ�����ڵ�</td>
		<td>Flag</td>
		<td>ȸ�����</td>
		<td>��ǥ��</td>
		<td>�����</td>
		<td>��ȭ��ȣ</td>
		<td>�̿��</td>
		<td>ü������</td>
		<td>�������</td>
		<td>�����</td>

		<td>�����������</td>
		<td>���¹�ȣ</td>
		<td>ȭ�ϻ���(Text1,Text2��)</td>
		<td>�̼���üũ(Y/N)</td>
		<td>SMSȮ��(Y/N)</td>
		<td>������»��(Y/N)</td>
		<td>����ڵ�</td>
		<td>�����</td>
		<td>���� ���α׷�</td>
		<td>�̸����ּ�</td>
	</tr>

<%
i=1
do until rslist.EOF

	imsirscount1 = 0
	imsirscount2 = 0
	imsiusername = ""

	set rscount = server.CreateObject("ADODB.Recordset")
	SQL = " select count(idx),(select count(idx) from tb_company where bidxsub = "& rslist("idx") &" and flag = '3') "
	SQL = sql & " from tb_company "
	SQL = sql & " where bidxsub = "& rslist("idx") &" and flag = '2' "
	rscount.Open sql, db, 1
	if not rscount.eof then
		imsirscount1 = rscount(0)
		imsirscount2 = rscount(1)
	else
		imsirscount1 = 0
		imsirscount2 = 0
	end if
	rscount.close

	set rscount = server.CreateObject("ADODB.Recordset")
	SQL = " select username"
	SQL = sql & " from tb_adminuser "
	SQL = sql & " where flag = '2' and usercode = '"& rslist("idx") &"' "
	rscount.Open sql, db, 1
	if not rscount.eof then
		imsiusername = rscount(0)
	end if
	rscount.close

	imsidcodename = ""
	if rslist("dcode")<>"" then
		set rs2 = server.CreateObject("ADODB.Recordset")
		SQL = " select dname "
		SQL = sql & " from tb_dealer "
		SQL = sql & " where dcode = '"& rslist("dcode") &"' "
		rs2.Open sql, db, 1
		if not rs2.eof then
			imsidcodename = rs2(0)
		end if
		rs2.close
	end if

	fileflag = rslist("fileflag")
	if fileflag="0" then
		fileflag = "������"
	elseif fileflag="1" then
		fileflag = "Text 1 (����� ����)"
	elseif fileflag="2" then
		fileflag = "Text 2 (CJ ����, �ֹ�����)"
	elseif fileflag="3" then
		fileflag = "Text 3 (CJ ����, �������/Ȯ�ΰ�)"
	elseif fileflag="4" then
		fileflag = "Excel 1"
	elseif fileflag="5" then
		fileflag = "Excel 2"
	elseif fileflag="6" then
		fileflag = "Excel 3"
	elseif fileflag="7" then
		fileflag = "Text 4 (����� ����, �ֹ�Ȯ�ΰǸ�)"
	elseif fileflag="8" then
		fileflag = "Text 5 (����� ����, ��޿�û����)"
	elseif fileflag="9" then
		fileflag = "Text 6 (CJ ����, ��޿�û����)"
	elseif fileflag="a" then
		fileflag = "Text 7 (����� ����, ȭ�ϻ����ڵ�)"
	end if
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=i%></td>
		<td><%=rslist("tcode")%></td>
		<td>1</td>
		<td align=left><%=rslist("comname")%></td>
		<td><%=rslist("name")%></td>
		<td align=left><%=imsiusername%></td>
		<td><%=rslist("tel1")%>-<%=rslist("tel2")%>-<%=rslist("tel3")%></td>
		<td><%=mid(FormatCurrency(rslist("usemoney")),2)%></td>
		<td><%=imsirscount2%></td>
		<td><%=left(rslist("startday"),4)%>/<%=mid(rslist("startday"),5,2)%>/<%=right(rslist("startday"),2)%></td>
		<td><%=imsidcodename%></td>

		<td class='accountnum'><%=rslist("virtual_acnt2_bank")%></td>
		<td class='accountnum'><%=rslist("virtual_acnt2")%></td>
		<td><%=fileflag%></td>
		<td><%=rslist("myflag")%></td>
		<td><%=rslist("smsflag")%></td>
		<td><%=rslist("cyberNum")%></td>
		<td><%=rslist("cporg_cd")%></td>
		<td><%=rslist("virtual_acnt_bank")%></td>
		<td><%=rslist("adminProgram")%></td>
		<td><%=rslist("homepage")%></td>
	</tr>

</form>

<%
rslist.MoveNext 
i=i+1
loop 
%>

</table>

<%
	db.close
	set db=nothing
%>

</body>
</html>