<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")

	if searchc="y" then
		imsititle = "���"
	elseif searchc="n" then
		imsititle = "�ֹ�"
	elseif searchc="" then
		imsititle = "�ֹ�/���"
	end if

	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if

	if searcha="" then
		searcha = replace(left(now()-1,10),"-","")
	end if

	if searchb="" then
		searchb = replace(left(now(),10),"-","")
	end if

	

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select searchordertime,SearchStartTime,SearchEndTime "
	SQL = sql & " from tb_company "
	SQL = sql & " where flag='1' "
	SQL = sql & " and idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
	searchordertime = rs(0)
	SearchStrartTime = rs(1)
	SearchEndTime = rs(2)
	rs.close

	If searchd = "" And SearchStrartTime = "" Then 
		searchd = "000000"
	Else 
		If Len(SearchStrartTime) = 4 Then 
			searchd = SearchStrartTime & "00"
		Else
			searchd = "000000"
		End If 
	End If 

	If searche = "" And SearchEndTime = "" Then 
		searche = "235959"
	Else 
		If Len(SearchEndTime) = 4 Then 
			searche = SearchEndTime & "59"
		Else
			searche = "235959"
		End If 
	End If
	
	startdate = searcha & searchd
	enddate = searchb & searche

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select  a.pcode,a.pname,isnull(a.sumordernum, 0) as sumordernum, b.ptitle, a.sumrordernum, isnull(b.pprice, 0) as pprice "
	SQL = sql & " from "
	SQL = sql & " 	(select pcode,pname,sum(ordernum) as sumordernum , sum(case when flag='y' then rordernum end) as sumrordernum "
	SQL = sql & " 	from v_tb_order "
	SQL = sql & " 	where deflag='n' and flag='y'  "
			if session("Ausergubun")="3" then
				SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
 			else
				SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
			end if
			If Len(startdate) = 14 And searchordertime = "y" Then 
				SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "			
			Else
				if (searcha<>"") and (len(searcha)=8) then
					SQL = sql & " and orderday >= '"& searcha &"' "
				end if
			end If
			If Len(enddate) = 14  And searchordertime = "y" Then 
				SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) "			
			Else
				if (searchb<>"") and (len(searchb)=8) then
					SQL = sql & " and orderday <= '"& searchb &"' "
				end if
			End If 
			if session("Ausergubun")="3" then
				'����α��ν� ���簡 ���������̿�� �ش繰�����͸� ��������07.01.12'''''''''''''''''''''''''
				if session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
					SQL = sql & " and dcenterchoice = '"& trim(session("Adcenteridx")) &"' "
				end if
				''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			end if
	SQL = sql & " 	and ordernum>0 group by pcode,pname) a "
	SQL = sql & " left outer join "
	SQL = sql & " 	(select pcode,ptitle,pprice from tb_product where usercode = '"& left(session("Ausercode"),5) &"' ) b "
	SQL = sql & " on a.pcode = b.pcode "
	SQL = sql & " order by a.pcode asc "
'response.write  sql
	rs.Open sql, db, 1
%>


<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ ��ǰ�� ����ǥ ]</font></td>
	</tr>
	<tr height="6">
		<td><font color=red size=2>��.�ֹ�����->�ֹ����� ȭ���� '�������' �׸��� '�ֹ�Ȯ��'�̶�� �Ǿ� �ִ� �ֹ� ���� '��޼���'�� ��ǰ�ڵ庰�� ���� ��.</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="tlist.asp" method="POST" name=kindform>
<input type="hidden" value="<%=searchordertime%>" name ="searchordertime">
	<tr>
		<td nowrap width="15%" bgcolor="#F7F7FF" height="25" align=center><B>�ֹ�����</td>
		<td nowrap width="70%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searcha" size="8" maxlength="8" class="box_work" value="<%=searcha%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<%If searchordertime = "y" Then %><input type="Text" name="searchd" size="6" maxlength="6" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;"><%End If %>
			~
			<input type="Text" name="searchb" size="8" maxlength="8" class="box_work" value="<%=searchb%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<%If searchordertime = "y" Then %><input type="Text" name="searche" size="6" maxlength="6" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;"><%End If %>
			<input type="button" name="����" value="����" class="box_work"
			<%If searchordertime = "y" Then %>	
			onclick="javascript:serchtodaychecktime(document.kindform.searcha, document.kindform.searchb, document.kindform.searchd, document.kindform.searche);"
			<%else%>
			onclick="javascript:serchtodaycheck(document.kindform.searcha, document.kindform.searchb);"
			<%End If %>>
		</td>
<!--
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>�� ��</td>
		<td nowrap width="25%" bgcolor="#FFFFFF" height="25">
			<select name=searchc>
				<option value="" <%if searchc="" then%>selected<%end if%>>�ֹ�/���
				<option value="n" <%if searchc="n" then%>selected<%end if%>>�ֹ�����
				<option value="y" <%if searchc="y" then%>selected<%end if%>>�ֹ�Ȯ��
			</select>
		</td>
-->
		<td nowrap width="15%">
			<input type="button" name="�� ��" value="�� �� " class="box_work"' onclick="javascript:kindsearchok2(this.form);">
	        	<input type="button" name="�ʱ�ȭ" value="�ʱ�ȭ" class="box_work"' onclick="javascript:frmzerocheck(this.form,'tlist.asp?flag=2');">
		</td>
	</tr>
	</form>
</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
<form method = "POST" name="selectbox">
	<tr height=30 valign=bottom>
		<td width=70%>* ��ü <B><%=rs.recordcount%></b>���� ����Ÿ�� �ֽ��ϴ�.</td>
		<td width=30% align=right>
			<select name="selectexcel">
				<option value = "product" selected>��ǰ�� ����ǥ(��ü)
				<option value = "jisa">��ǰ�� ����ǥ(����)
				<option value = "chain">��ǰ�� ����ǥ(ü��)
			</select>
		<a href ="#"><img src="/images/admin/excel.gif" border=0 onclick="ExcelExport();"></a></td>
	</tr>
</form>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>��ȣ</td>
		<td width=9%>��ǰ�ڵ�</td>
		<td width=34%>��ǰ��</td>
		<td width=18%>�԰�</td>
		<!--<td width=9%>�ֹ�����</td>-->
		<td width=9%>��޼���</td>
		<td width=10%>�ܰ�</td>
		<td width=15%>�ݾ�</td>
	</tr>

<%
i=1
imsihap1 = 0
imsihap2 = 0
imsihap3 = 0
imsihap4 = 0
do until rs.EOF

	'a.pcode,a.pname,a.sumordernum, b.ptitle, c.sumrordernum
	imsidcarname      = rs("ptitle")
	imsiimsirordernum = rs("sumrordernum")
	if imsiimsirordernum="" or isnull(imsiimsirordernum) then imsiimsirordernum=rs(2)
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=i%></td>
		<td><%=rs(0)%></td>
		<td><%=rs(1)%></td>
		<td><%=imsidcarname%></td>
		<!--<td align=right><%=rs(2)%> &nbsp; </td>-->
		<td align=right><%=formatnumber(imsiimsirordernum, 0)%> &nbsp; </td>

		<td align=right><%=formatnumber(rs("pprice"),0)%> &nbsp; </td>
		<td align=right><%if imsiimsirordernum=0 then%>0<%else%><%=formatnumber(imsiimsirordernum*rs("pprice"),0)%><%end if%> &nbsp; </td>
	</tr>

</form>

<%
imsihap1 = imsihap1 + rs(2)
imsihap2 = imsihap2 + imsiimsirordernum
imsihap3 = imsihap3 + rs("pprice")
'imsihap4 = imsihap4 + (rs(2)*rs("pprice"))
imsihap4 = imsihap4 + (imsiimsirordernum*rs("pprice"))
rs.MoveNext 
i=i+1
loop 
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td colspan=4>�� ��</td>
		<!--<td align=right><%=imsihap1%> &nbsp; </td>-->
		<td align=right><%=formatnumber(imsihap2,0)%> &nbsp; </td>
		<!--<td align=right><%=formatnumber(imsihap3,0)%> &nbsp; </td>-->
		<td align=right></td>
		<td align=right><%=formatnumber(imsihap4,0)%> &nbsp; </td>
	</tr>

</table>

<BR>
<center><a href="#" onclick="javascript:pwinnew();"><img src="/images/admin/l_bu15.gif" alt="�μ�" border=0></a>
<script language="JavaScript">
<!--
function pwinnew(){
	window.open("newwin.asp?gotopage=<%=request("gotopage")%>&searcha=<%=request("searcha")%>&searchb=<%=request("searchb")%>&searchc=<%=request("searchc")%>&searchd=<%=request("searchd")%>&carname=<%=request("carname")%>","AutoAddr","toolbar=no,menubar=no,scrollbars=1,resizable=no,width=670,height=700");
}
//-->
</script>

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