<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
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
	Function regsendval(val)
		regsend1 = "0,1,A,B,C,D,2,A,B,C,D,E,F,G,H,I,J"
		regsend2 = "����,Time Out,ȣó����,��������,Power off,������ʰ�,�߸��ȹ�ȣ,�Ͻ�����,��Ÿ����,���Ű���,��Ÿ,���Ŀ���,���Ŀ���,�Ұ��ܸ���,ȣ�Ұ�����,�޽�������,Que Full"
		regsend1array = split(regsend1,",")
		regsend2array = split(regsend2,",")
		if val<>"" then
			imsii = ""
			for k=0 to ubound(regsend1array)
				if trim(regsend1array(k))=val then
					regsendval = regsend2array(k)
					exit for
				end if
			next
		end if
	End Function 

	Function FunHPCut(Hvalnum)	'�ڵ�����ȣ0111111111->011-111-1111
		if Hvalnum<>"" and len(Hvalnum)>=10 then
			imsilenhp  = len(Hvalnum)	'��ü����
			imsilenhp1 = left(Hvalnum,3)	'��Ż��ȣ
			imsilenhp2 = mid(left(Hvalnum,(imsilenhp-4)),4)	'����
			imsilenhp3 = right(Hvalnum,4)	'��ȭ��ȣ
			FunHPCut = imsilenhp1&"-"&imsilenhp2&"-"&imsilenhp3
		end if
	End Function

	Function Fundate(Hval)
		if Hval<>"" then
			DATE_MD = Right(Replace(FormatDateTime(Hval,2),"-",""),4)
			DATE_Y  = MID(Replace(FormatDateTime(Hval,2),"-",""),1,4)
			B_DATE  = DATE_Y & DATE_MD 	'���ϳ�
			B_TIME  = left(Replace(FormatDateTime(Hval,4),":",""),6)&Right("00" & second(Hval),2)  '�ú���
			IntTime = B_DATE &  B_TIME
		end if
		Fundate = IntTime
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
	if searchd="" then
		searchd = replace(left(now()-1,10),"-","")
	end if

	if searche="" then
		searche = replace(left(now(),10),"-","")
	end if
	searchdd = mid(searchd,1,4)&""&mid(searchd,5,2)&""&mid(searchd,7,2)
	searchee = mid(searche,1,4)&""&mid(searche,5,2)&""&mid(searche,7,2)
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode from tb_company where flag='1' and idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
	if not rs.eof then
		btcode = rs(0)
		'btcode = "9074"
	end if
	rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode,comname from tb_company where flag='3' and bidxsub = "& left(session("Ausercode"),5) &" order by comname asc"
	rs.Open sql, db, 1
	if not rs.eof then
		carray = rs.GetRows
		carrayint = ubound(carray,2)
	else
		carray = ""
		carrayint = ""
	end if
	rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	imsitb = "em_log_"
	syymm = int(left(searchd,6))	'200901
	eyymm = int(left(searche,6))	'200901
	's_imsitb = imsitb & syymm
	'e_imsitb = imsitb & eyymm
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	for i=syymm to eyymm
		if i=syymm then 
			s_imsitb = imsitb & syymm
		else
			s_imsitb = imsitb & (syymm+1)
		end if
		tbsql = tbsql & " select * from "& s_imsitb &" where tran_etc2 = '"& btcode &"' "
		if searcha<>"" and searchb<>"" then tbsql = tbsql & " and "& searcha &" like '%"& searchb &"%' "
		if searchc<>"" then tbsql = tbsql & " and tran_etc3 = '"& searchc &"' "
		if searchf="y" then 
			tbsql = tbsql & " and tran_rslt  = '0' "
		elseif searchf="n" then 
			tbsql = tbsql & " and tran_rslt  <> '0' "
		end if
		if i<eyymm then tbsql = tbsql & " union all "
	next
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rslist = server.CreateObject("ADODB.Recordset")
	sql = " select a.*, b.comname,b.tcode from ("& tbsql &") a "

	sql = sql & " left outer join "
	sql = sql & " (select comname,tcode from tb_company where flag='3' and bidxsub = (select idx from tb_company where flag='1' and tcode = '"& btcode &"') ) b "
	sql = sql & " on a.tran_etc3 = b.tcode "
	sql = sql & " where a.tran_date BETWEEN '"& searchdd &"' and '"& searchee &"' "

	sql = sql & " order by tran_pr asc "
	rslist.PageSize=20
	rslist.Open sql, db, 1

	if not rslist.bof then
		rslist.AbsolutePage=int(gotopage)
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
%>

<script language="JavaScript">
<!--
function onlyNumber(){
   if((event.keyCode<48)||(event.keyCode>57))
      event.returnValue=false;
}
function posorderwin(){
	window.open ('posDatatorder.asp','dssdsd','width=300,height=180,left=100,top=100');
	return false ;
}

function smsmsgpop(val){
	window.open ('msgpop.asp?msg='+val,'123','width=100,height=120,left=100,top=100');
	return false ;
}
//-->
</script>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ SMS ���۳��� ]</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="SendList.asp" method="POST" name=form>
	<tr>
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>��������<BR> &nbsp;<B>�������� �˻�</td>
		<td nowrap width="84%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<input type="button" name="����" value="����" class="box_work"' onclick="javascript:serchtodaycheck(document.form.searchd, document.form.searche);"> ��)20040928 ~ 20041004
			<BR>

			<select name="searchc" size="1" class="box_work">
          			<option value="" <%if searchc="" then%>selected<%end if%>>ü������ü
				<%for i=0 to carrayint%>
	          			<option value="<%=carray(0,i)%>" <%if searchc=cstr(carray(0,i)) then%>selected<%end if%>><%=carray(1,i)%>
				<%next%>
        		</select>
			<!--
			<select name="searchf" size="1" class="box_work">
          			<option value="" <%if searchf="" then%>selected<%end if%>>��Ż���ü
          			<option value="SKT" <%if searchf="SKT" then%>selected<%end if%>>SKT
          			<option value="KTF" <%if searchf="KTF" then%>selected<%end if%>>KTF
          			<option value="LGT" <%if searchf="LGT" then%>selected<%end if%>>LGT
        		</select>
			-->
			<select name="searchf" size="1" class="box_work">
          			<option value=""  <%if searchf="" then%>selected<%end if%>>���۰��
          			<option value="y" <%if searchf="y" then%>selected<%end if%>>����
          			<option value="n" <%if searchf="n" then%>selected<%end if%>>����
        		</select>
			<select name="searcha" size="1" class="box_work">
	          			<option value="" <%if searcha="" then%>selected<%end if%>>�˻����� ����
	          			<option value="tran_phone" <%if searcha="tran_phone" then%>selected<%end if%>>�ڵ�����ȣ
	          			<option value="tran_etc3"  <%if searcha="tran_etc3" then%>selected<%end if%>>ü�����ڵ�
        		</select>
			<input type="Text" name="searchb" size="20" maxlength="20" class="box_work" value="<%=searchb%>">
	        	<input type="button" name="�� ��" value="�� �� "  class="box_work"' onclick="javascript:kindsearchok2(this.form);">
	        	<input type="button" name="�ʱ�ȭ" value="�ʱ�ȭ" class="box_work"' onclick="javascript:frmzerocheck(this.form,'SendList.asp');">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* ��ü <B><%=rslist.recordcount%></b>���� ����Ÿ�� �ֽ��ϴ�.</td>
		<td width=30% align=right><a href="cexcell.asp?searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchh=<%=searchh%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>"><img src="/images/admin/excel.gif" border=0></a></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>��ȣ</td>
		<td width=14%>�ڵ�</td>
		<td width=15%>ü������</td>
		<td width=18%>�����Ͻ�</td>
		<td width=14%>�ڵ�����ȣ</td>
		<td width=10%>��Ż�</td>
		<td width=12%>���۰��</td>
		<td width=12%>�޼���</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i
	tran_rslt  = regsendval(replace(trim(rslist("tran_rslt"))," ",""))
	tran_phone = FunHPCut(rslist("tran_phone"))

	tran_date = Fundate(rslist("tran_date"))
	tran_date = DateFormatReplace(tran_date,"/","1")


%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=rslist("tran_etc3")%></td>
		<td><%=rslist("comname")%></td>
		<td><%=tran_date%></td>
		<td><%=tran_phone%></td>
		<td><%=rslist("tran_net")%></td>
		<td><%=tran_rslt%></td>
		<td><a href="#" onclick="smsmsgpop('<%=replace(rslist("tran_msg"),"""","$$")%>');"><font color=blue><B>����</td>
	</tr>

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
				<a href="SendList.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">ù������</a>&nbsp;
				<a href="SendList.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">���� 10��</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="SendList.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>����10��</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="SendList.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">���� 10��</a>
				&nbsp;<a href="SendList.asp?GotoPage=<%=rslist.pagecount%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>">������</a>
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