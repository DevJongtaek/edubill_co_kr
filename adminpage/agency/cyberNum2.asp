<!--#include virtual="/adminpage/incfile/top2.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	'--------------------------------------------------------------------------------------------------------------------
	'# ��¥���� �Լ�
	'# FunYMDHMS(dflag)	����Ͻú��� �������� �Լ�
	'#    			4:yyyy    6:yyyymm    8:yyyymmdd    10:yyyymmddhh    12:yyyymmddhhmm    14:yyyymmddhhmmss
	'# DateFormatReplace	20090605123541 -->> 2009-06-05 12:35:41
	'#    			psDate:����Ÿ	psDateflag:��¥���а�	psDategubun:1=��¥��ü 2=�ð���
	'# SelectDateChoice	����� �޺��ڽ�
	'#    			yearDa:�⵵��    monthDa:����    dayDa:�ϰ�    yvalD:�⵵�̸�    mvalD:���̸�    dvalD:���̸�
	'# alertURL	 �̵��� �ּ�
	'--------------------------------------------------------------------------------------------------------------------
	Function DateFormatReplace(psDate,psDateflag,psDategubun)
		if psDateflag="" then
			psDateflag = "-"
		end if
		if psDategubun="" then
			psDategubun = "1"
		end if

		if psDategubun="1" then
	        	if IsNull(psDate) OR Len(psDate)=0 then 
        	        	DateFormatReplace="" 
        		elseif Len(psDate)=6 then 
      	          		DateFormatReplace = Left(psDate,4) & psDateflag & Right(psDate,2) 
        		elseif Len(psDate)=8 then 
                		DateFormatReplace = Left(psDate,4) & psDateflag & Mid(psDate,5,2) & psDateflag & Right(psDate,2) 
  			elseif Len(psDate)=12 then 
                		DateFormatReplace = Left(psDate,4) & psDateflag & Mid(psDate,5,2) & psDateflag & mid(psDate,7,2) & " " & mid(psDate,9,2) & ":" & right(psDate,2) 
  			elseif Len(psDate)=14 then 
                		DateFormatReplace = Left(psDate,4) & psDateflag & Mid(psDate,5,2) & psDateflag & mid(psDate,7,2) & " " & mid(psDate,9,2) & ":" & mid(psDate,11,2)  & ":" & mid(psDate,13,2)
			else 
	                	DateFormatReplace = psDate 
        		end if 
		else
	        	if IsNull(psDate) OR Len(psDate)=0 then 
        	        	DateFormatReplace="" 
        		elseif Len(psDate)=4 then 
                		DateFormatReplace = mid(psDate,1,2) & ":" & mid(psDate,3,2)
        		elseif Len(psDate)=6 then 
                		DateFormatReplace = mid(psDate,1,2) & ":" & mid(psDate,3,2) & ":" & mid(psDate,5,2)
			else 
	                	DateFormatReplace = psDate 
        		end if 
		end if
	End Function 
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")

	if searchg="" then
		searchg = "0"
	end if
	if searchf="" then
		searchf = "0"
	end if

	if searchd="" then
		searchd = replace(left(now()-31,10),"-","")
	end if

	if searche="" then
		searche = replace(left(now(),10),"-","")
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	sql = " select cporg_cd,tcode from tb_company where idx = "& left(session("AAusercode"),5) &" "
	rs.Open sql, db, 1
	btcode    = rs(0)
	imsitcode = rs(1)
	rs.close
	if len(session("AAusercode"))=15 then
		set rs = server.CreateObject("ADODB.Recordset")
		sql = " select virtual_acnt from tb_company where idx = "& right(session("AAusercode"),5) &" "
		rs.Open sql, db, 1
		ctcode = rs(0)
		rs.close
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rslist = server.CreateObject("ADODB.Recordset")
	sql = " select * from tb_input_acnt "
	SQL = sql & " where tcode = '"& imsitcode &"' "
	SQL = sql & " and chancode = '"& session("AAtcode") &"' "

	if searchd<>"" then
		SQL = sql & " and replace(SlipDate,'/','') >= '"& searchd &"' "
	end if

	if searche<>"" then
		SQL = sql & " and replace(SlipDate,'/','') <= '"& searche &"' "
	end if

	if searcha<>"" then
		SQL = sql & " and Collect_Method = '"& searcha &"' "
	end if

	if searchb<>"" and searchc<>"" then
		if searchb = "Input_Amt" then
			SQL = sql & " and "& searchb &" = "& searchc &" "
		else
			SQL = sql & " and "& searchb &" like '%"& searchc &"%' "
		end if
	end if

	SQL = sql & " order by SlipDate desc "
    'response.Write SQL
	rslist.PageSize=20
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>

<table width="770" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="98%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td width=40%><font color=blue size=3><B>[ �Աݳ�����ȸ ]</td>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="cyberNum2.asp" method="POST" name=form>
	<tr>
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>�����˻�</td>
		<td nowrap width="84%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<input type="button" name="����" value="����" class="box_work"' onclick="javascript:serchtodaycheck(document.form.searchd, document.form.searche);"> ��)20040928 ~ 20041004
			<BR>
			<select name="searcha">
				<option value="">�Աݹ��
				<option value="0" <%if searcha="0" then%>selected<%end if%>>�������
				<option value="1" <%if searcha="1" then%>selected<%end if%>>����
				<option value="2" <%if searcha="2" then%>selected<%end if%>>�������Ա�
				<option value="3" <%if searcha="3" then%>selected<%end if%>>�ſ�ī��
				<option value="4" <%if searcha="4" then%>selected<%end if%>>��ǥ
				<option value="5" <%if searcha="5" then%>selected<%end if%>>����
			</select>
			<select name="searchb">
				<option value="">���м���
				<option value="Send_Bank"     <%if searchb="Send_Bank" then%>selected<%end if%>>�۱�����
				<option value="Input_Bank"    <%if searchb="Input_Bank" then%>selected<%end if%>>��������
				<option value="Input_Amt"     <%if searchb="Input_Amt" then%>selected<%end if%>>�Աݾ�
				<option value="Check_Account" <%if searchb="Check_Account" then%>selected<%end if%>>�������
			</select>
			<input type="Text" name="searchc" size="15" class="box_work" value="<%=searchc%>">
	        	<input type="button" name="�� ��" value="�� �� "  class="box_work"' onclick="javascript:kindsearchok2(this.form);">
	        	<input type="button" name="�ʱ�ȭ" value="�ʱ�ȭ" class="box_work"' onclick="javascript:frmzerocheck(this.form,'cyberNum2.asp');">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="5"></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>��ȣ</td>
		<td width=13%>�Ա�����</td>
		<td width=20%>�Աݹ��</td>
		<td width=10%>�۱�����</td>
		<td width=10%>��������</td>
		<td width=10%>�Աݾ�</td>
		<td width=10%>�Ա��Ĺ̼�</td>
		<td width=12%>������¹�ȣ</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i
	idx = rslist("idx")
	tcode = rslist("tcode")
	chancode = rslist("chancode")
	SlipDate = rslist("SlipDate")
	Collect_Method = rslist("Collect_Method")
	Send_Bank = rslist("Send_Bank")
	Input_Bank = rslist("Input_Bank")
	Input_Amt = rslist("Input_Amt")
	Misu_Amt = rslist("Misu_Amt")
	Check_Account = rslist("Check_Account")
	if Input_Amt<>"" then Input_Amt = formatnumber(Input_Amt,0)
	if Misu_Amt<>"" then Misu_Amt = formatnumber(Misu_Amt,0)
	'if Check_Account<>"" then Check_Account = formatnumber(Check_Account,0)

	if Collect_Method="0" then
		Collect_Method = "�������"
	elseif Collect_Method="1" then
		Collect_Method = "����"
	elseif Collect_Method="2" then
		Collect_Method = "�������Ա�"
	elseif Collect_Method="3" then
		Collect_Method = "�ſ�ī��"
	elseif Collect_Method="4" then
		Collect_Method = "��ǥ"
	elseif Collect_Method="5" then
		Collect_Method = "����"
    elseif Collect_Method="6" then
		Collect_Method = "��ǰ��ȯ��"
	end if
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=SlipDate%></td>
		<td><%=Collect_Method%></td>
		<td><%=Send_Bank%></td>
		<td><%=Input_Bank%></td>
		<td align=right><%=Input_Amt%>&nbsp;</td>
		<td align=right><%=Misu_Amt%>&nbsp;</td>
		<td align=right><%=Check_Account%>&nbsp;</td>
	</tr>

</form>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop
%>

</table>

<table border="0" cellspacing="0" cellpadding="0" width=100%>
	<tr height=30 align=center>
		<td>

		<% blockPage=Int((GotoPage-1)/10)*10+1
			if blockPage = 1 Then
				Response.Write "<font color=#8B9494>����10��</font> [ "
			Else 
		%>
				<a href="cyberNum2.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">ù������</a>&nbsp;
				<a href="cyberNum2.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">���� 10��</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="cyberNum2.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>����10��</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="cyberNum2.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">���� 10��</a>
				&nbsp;<a href="cyberNum2.asp?GotoPage=<%=rslist.pagecount%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">������</a>
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

<BR>

<!--#include virtual="/adminpage/incfile/bottom2.asp"-->