<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<%
	gongi = request("gongi")
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")
	' �˻� ���� �߰� 
	searchi = request("searchi")
	searchj = request("searchj")
	searchk = request("searchk")

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
		searchd = replace(left(now()-180,10),"-","")
	end if

	if searche="" then
		searche = replace(left(now(),10),"-","")
	end if
	'''''''''''''''''''''''''''
	fclass1 = Request("fclass1")
	sclass2 = Request("sclass2")
	tclass3 = Request("tclass3")
	imsifclass1 = right(Request("fclass1"),5)
	imsisclass2 = right(Request("sclass2"),5)
	imsitclass3 = right(Request("tclass3"),5)

	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	sqlFilter = ""

	set rslist = server.CreateObject("ADODB.Recordset")
'	sql = " select seq, convert(varchar(10), RequestDay, 11) Request_Day ,RequestName  , case when RTRIM(RequestAge) <> '' then year(getdate()) - year(RequestAge) else '00' end RequestAge,RequestTel  ,RequestHP  ,WishMoney,  LoanOrg  ,LoanProduct  ,LoanMoney  ,[InterestRate ]  ,convert(varchar(10), LoanDay, 11), StatusMemo  from tb_loan where replace(convert(varchar(10), RequestDay, 111), '/', '') <= '" & searche & "' and replace(convert(varchar(10), RequestDay, 111), '/', '') >= '" & searchd & "' "
	sql = " select seq, convert(varchar(10), RequestDay, 11) Request_Day ,RequestName  , case when RTRIM(RequestAge) <> '' then year(getdate()) - year(RequestDay) else '00' end RequestAge,RequestTel  ,RequestHP  ,WishMoney,  LoanOrg  ,LoanProduct  ,LoanMoney  ,[InterestRate ]  ,convert(varchar(10), LoanDay, 11), StatusMemo  from tb_loan where replace(convert(varchar(10), RequestDay, 111), '/', '') <= '" & searche & "' and replace(convert(varchar(10), RequestDay, 111), '/', '') >= '" & searchd & "' "
	If searchj = "1" Then
		'If sqlFilter = "" Then 
		'	sqlFilter = sqlFilter & " Where " 
		'Else 
		'	sqlFilter = sqlFilter & " And " 
		'End If 
		sqlFilter = sqlFilter & " and RequestName like '%" & searchk &  "%' "
	ElseIf searchj = "2" Then 
		'If sqlFilter = "" Then 
		'	sqlFilter = sqlFilter & " Where " 
		'Else 
		'	sqlFilter = sqlFilter & " And " 
		'End If 
		sqlFilter = sqlFilter & " and replace(RequestTel, '-', '') like '%" & searchk &  "%' "
	ElseIf searchj = "3" Then 
		'If sqlFilter = "" Then 
		'	sqlFilter = sqlFilter & " Where " 
		'Else 
		'	sqlFilter = sqlFilter & " And " 
		'End If 
		sqlFilter = sqlFilter & " and replace(RequestHP, '-', '') like '%" & searchk &  "%' "
	ElseIf searchj = "4" Then 
		'If sqlFilter = "" Then 
		'	sqlFilter = sqlFilter & " Where " 
		'Else 
		'	sqlFilter = sqlFilter & " And " 
		'End If 
		If searchk = "" Then 
			sqlFilter = sqlFilter & " and LoanDay is null "
		else
			sqlFilter = sqlFilter & " and LoanDay like '%" & searchk &  "%' "
		End If  
	End If 

	If searchi = "1" Then 
		'If sqlFilter = "" Then 
		'	sqlFilter = sqlFilter & " Where " 
		'Else 
		'	sqlFilter = sqlFilter & " And " 
		'End If 
		sqlFilter = sqlFilter & " and LoanOrg is null "
	ElseIf searchi = "2" Then 
		'If sqlFilter = "" Then 
		'	sqlFilter = sqlFilter & " Where " 
		'Else 
		'	sqlFilter = sqlFilter & " And " 
		'End If 
		sqlFilter = sqlFilter & " and LoanOrg is not null "
	End If 

	sql = sql & sqlFilter & " order by RequestDay desc"
	'response.write sql
	'response.end
	rslist.PageSize=20
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if


%>

<script language="JavaScript">
<!--
function onlyNumber(){
   if((event.keyCode<48)||(event.keyCode>57))
      event.returnValue=false;
}
//-->
</script>

<table width="940" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ �����û���� ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="list.asp" method="POST" name=form>
	<tr>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>�˻�����</b></td>
		<td nowrap width="90%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<input type="button" name="����" value="����" class="box_work" onclick="javascript:serchtodaycheck(document.form.searchd, document.form.searche);"> ��)20110501 
          	<select name="searchi" class="f">
            	<option value="0" <%if searchi="0" then%>selected<%end if%>>��ü</option>
            	<option value="1" <%if searchi="1" then%>selected<%end if%>>����û</option>
				<option value="2" <%if searchi="2" then%>selected<%end if%>>����Ϸ�</option>
           	</select>
			<select name="searchj" size="1" class="box_work">
       			<option value="0" <%if searchj="0" then%>selected<%end if%>>��ü</option>
       			<option value="1" <%if searchj="1" then%>selected<%end if%>>����</option>
       			<option value="2" <%if searchj="2" then%>selected<%end if%>>��ȭ��ȣ</option>
       			<option value="3" <%if searchj="3" then%>selected<%end if%>>�ڵ�����ȣ</option>
<!--       			<option value="4" <%if searchj="4" then%>selected<%end if%>>������</option>-->
       		</select>
			<input type="Text" name="searchk" size="8" maxlength="15" value="<%=searchk%>" style="width:150">
	        <input type="button" name="�� ��" value="�� �� " class="box_work"' onclick="javascript:kindsearchok2(this.form);">
	        <input type="button" name="�ʱ�ȭ" value="�ʱ�ȭ" class="box_work"' onclick="javascript:frmzerocheck(this.form,'list.asp');">
		</td>
	</tr>

</form>

</table>

<table border=0 cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=60%>* ��ü <B><%=rslist.recordcount%></b>���� ����Ÿ�� �ֽ��ϴ�.
<!--<img src="/images/admin/excel.gif" border=0>
<a href="excell.asp?searcha=<%=searcha%>&searchh=<%=searchh%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>"><img src="/images/admin/excel.gif" border=0></a>-->

		</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=3%>��ȣ</td>
		<td width=6%>��û����</td>
		<td width=5%>����</td>
		<td width=3%>����</td>
		<td width=9%>��ȭ��ȣ</td>
		<td width=9%>�ڵ�����ȣ</td>
		<td width=6%>����ݾ�<br>(����)</td>
		<td width=9%>�������</td>
		<td width=10%>�����ǰ</td>
		<td width=6%>����ݾ�<br>(����)</td>
		<td width=5%>�ݸ�<BR>(%)</td>
		<td width=6%>������</td>
		<td width=10%>�����Ȳ</td>
	</tr>
<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i
	If Len(rslist(8)) > 6 Then 
	   product = left(rslist(8), 6) & "..." 
	Else
		product = rslist(8)
	End If 

	If Len(rslist(12)) > 6 Then 
	   StatusMemo = left(rslist(12), 6) & "..." 
	Else
		StatusMemo = rslist(12)
	End If 
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=rslist(1)%></td>
		<td><a href="#" onclick="window.open('loancase.asp?seq=<%=rslist(0)%>','','top=100,left=100,width=385,height=550'); return false;"><%=rslist(2)%>&nbsp;</a></td>
		<td><%=rslist(3)%>&nbsp;</td>
		<td><%=rslist(4)%>&nbsp;</td>
		<td><%=rslist(5)%>&nbsp;</td>
		<td><%=rslist(6)%>&nbsp;</td>
		<td><%=rslist(7)%>&nbsp;</td>
		<td><%=product%>&nbsp;</td>
		<td><%=rslist(9)%>&nbsp;</td>
		<td><%=rslist(10)%>&nbsp;</td>
		<td><%=rslist(11)%>&nbsp;</td>
		<td><%=StatusMemo%>&nbsp;</td>
	</tr>
</form>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop
%>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" width=100%>
	<tr height=30 align=center>
		<td>

		<% blockPage=Int((GotoPage-1)/10)*10+1
			if blockPage = 1 Then
				Response.Write "<font color=#8B9494>����10��</font> [ "
			Else 
		%>
				<a href="list.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">ù������</a>&nbsp;
				<a href="list.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">���� 10��</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="list.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>����10��</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="list.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">���� 10��</a>
				&nbsp;<a href="list.asp?GotoPage=<%=rslist.pagecount%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">������</a>
		<% 	End If %>

		</td>
	</tr>
</table>

				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<%
	rslist.close
	db.close
	set rs=nothing
	set rslist=nothing
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->

<%if gongi="1" and imsicom_notice<>"" and (noticeflag="2" or noticeflag="a") and session("Ausergubun")="3" then%>
<!--------���̾� �˾�---------->
<div id="popWindow" style="position:absolute; left:<%if imsich_gongi<>"" then%>30<%else%>80<%end if%>px; top:370px; z-index:0; visibility;" onSelectStart="return false" isInfoWin="true">
<table width="350" height=100 cellpadding="0" cellspacing="0" border="0" bgcolor=white>
	<tr>
		<td height=25 bgcolor=#2A75B6 width=70%>&nbsp; <font color=white><b>* ��ü ��������</td>
		<td height=25 bgcolor=#2A75B6 width=30% align=right><a href="#" onclick="pop_win()"><font color=white><B>[ â �� �� ]</a>&nbsp; </td>
	</tr>
	<tr>
		<td valign=top bgcolor=#F4FB9F align=center colspan=2>

		<table width="97%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td><font color=black><B><%=imsicom_notice%></td>
			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td colspan=2 height=20 bgcolor=#2A75B6 align=right></td>
	</tr>
</table>
</div>
<!--//�˾�-->
<%end if%>

