<script language=javascript>
function nextstep() {
	if(event.keyCode==13) {
		document.all.fsearchbtn.focus();
	}
}

function excell_up(){
	window.open ('misuup.asp','ExcellID','width=450,height=120,left=100,top=100')
	return false ;
}

function account_up(){
	window.open ('accountup.asp','ExcellID','width=450,height=120,left=100,top=100')
	return false ;
}

function allsaveok(){
	findkindform.action = "orderflagAllsaveok.asp?gotopage=<%=gotopage%>&flag=<%=flag%>";
	findkindform.submit();
}
</script>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="list.asp" method="POST" name=findkindform>
<input type=hidden name=flag value="<%=flag%>">

	<tr> 
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>ü������������<BR> &nbsp;<B>ü�������� �˻�</td>
		<td nowrap width="84%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			��)20040928 ~ 20041004
			<BR>
			<select name="searchh" size="1" class="box_work">
        	  		<option value="">�귣����ü</option>
				<%if brand_arraynum<>"" then%>
					<%for i=0 to brand_arraynum%>
		        	  		<option value="<%=brand_array(0,i)%>" <%if searchh = cstr(brand_array(0,i)) then%>selected<%end if%>><%=brand_array(1,i)%></option>
					<%next%>
				<%end if%>
	        	</select>
		<%if session("Ausergubun")<>"3" then%>
			<select name="searchc" size="1" class="box_work">
          			<option value="0" <%if searchc = "0" then%>selected<%end if%>>����(��)��ü</option>
				<%if jisaarrayint <> "" then%>
					<%for i=0 to jisaarrayint%>
		          			<option value="<%=jisaarray(0,i)%>" <%if int(searchc)=int(jisaarray(0,i)) then%>selected<%end if%>><%=jisaarray(1,i)%>
					<%next%>
				<%end if%>
        		</select>
		<%end if%>
			<select name="searchg" size="1" class="box_work">
          			<option value="0" <%if searchg = "0" then%>selected<%end if%>>ȣ����ü</option>
				<%if hcararrayint <> "" then%>
					<%for i=0 to hcararrayint%>
		          			<option value="<%=hcararray(0,i)%>" <%if int(searchg)=int(hcararray(0,i)) then%>selected<%end if%>><%=hcararray(1,i)%>ȣ��
					<%next%>
				<%end if%>
        		</select>

			<select name="searchi" size="1" class="box_work">
          			<option value="">��ü</option>
          			<option value="1" <%if searchi = "1" then%>selected<%end if%>>����</option>
          			<option value="2" <%if searchi = "2" then%>selected<%end if%>>���</option>
          			<option value="3" <%if searchi = "3" then%>selected<%end if%>>����<%If left(session("Ausercode"),5) = "19209" or left(session("Ausercode"),5) = "96338" Then %>1</option><option value="4" <%if searchi = "4" then%>selected<%end if%>>����2</option><%End if%>
        		</select>

			<select name="searcha" size="1" class="box_work">
          			<option value="">��ü</option>
          			<option value="tcode" <%if searcha = "tcode" then%>selected<%end if%>>ü�����ڵ�</option>
          			<option value="comname" <%if searcha = "comname" then%>selected<%end if%>>ü������</option>
          			<option value="name" <%if searcha = "name" then%>selected<%end if%>>��ǥ�ڸ�</option>
    	      			<option value="tel3" <%if searcha = "tel" then%>selected<%end if%>>��ȭ��ȣ</option>
          			<option value="hp3" <%if searcha = "hp" then%>selected<%end if%>>�ڵ�����ȣ</option>
        		</select>
        		<input type="Text" name="searchb" size="10" maxlength="20" class="box_work" value="<%=searchb%>" onkeypress='nextstep();'>
	        	<input type="button" name="fsearchbtn" value="�� �� " class="box_work" onclick="javascript:kindsearchok(this.form);">
	        	<input type="button" name="�ʱ�ȭ" value="�ʱ�ȭ" class="box_work" onclick="javascript:frmzerocheck(this.form,'list.asp?flag=3');">

		</td>
	</tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
        
		<td width=70%>* ��ü <B><%=rslist.recordcount%></b>���� ����Ÿ�� �ֽ��ϴ�.</td>
		<td width=30% align=right>
			<!--<%If cybernum="y" Then %>
			<%if session("Ausergubun")="3" then%><input type="button" name="�̼�UP" value="���¼���" class="box_work"  onclick="javascript:account_up();"><%end if%>
			<%End if%>-->
			<%if imsimyflag="y" then%>
				<%if session("Ausergubun")="3" then%><%if session("Auserwrite")="y" then%><input type="button" name="�̼�DOWN" value="�̼�DOWN" class="box_work" onclick="javascript:location.href='misudown.asp?flag=<%=flag%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>';"><%end if%><%end if%>
				<%if session("Ausergubun")="3" then%><%if session("Auserwrite")="y" then%><input type="button" name="�̼�UP" value="�̼�UP" class="box_work"  onclick="javascript:excell_up();"><%end if%><%end if%>
			<%else%>
            		<%if session("Ausergubun")="3" then%><%if session("Auserwrite")="y" then%><input type="button" name="�̼�UP" value="�̼�UP" class="box_work"  onclick="javascript: excell_up();"><%end if%><%end if%>
			<%end if%>
			<%if session("Ausergubun")="3" then%><%if session("Auserwrite")="y" then%><input type="button" name="ü�������" value="ü�������" class="box_work"' onclick="javascript:location.href='write.asp?flag=<%=flag%>';"><%end if%><%end if%>
			<%if session("Ausergubun")="3" then%><%if session("Auserwrite")="y" then%><input type="button" name="��ü����" value="��ü����" class="box_work"' onclick="allsaveok()"><%end if%><%end if%>
			<%if rslist.recordcount>0 then%><a href="excell2.asp?flag=<%=flag%>&idx=<%=rslist("idx")%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>"><img src="/images/admin/excel.gif" border=0></a><%end if%>
            
		</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>��ȣ</td>
		<td width=9%>ü�����ڵ�</td>
		<td width=20%>ü������</td>

		<td width=12%>�ֹ�����</td>
		<td width=10%>�ֹ����</td>

		<td width=14%>�귣���</td>
		<td width=15%>��������(��)</td>
		<td width=10%>��ǥ��</td>

		<td width=5%>����</td>

	</tr>

<%
set rs = server.CreateObject("ADODB.Recordset")
SQL = " select myflag from tb_company where idx = "& int(left(session("Ausercode"),5)) &" "
rs.Open sql, db, 1
if not rs.eof then
	imsimyflag = rs(0)
else
	imsimyflag = ""
end if
rs.close

i=1
'j=(gotopage*10)-9
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i

	orderflag = rslist("orderflag")

	imsidcarno = ""
	imsicomname = ""
	imsiusername = ""

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select dcarno"
	SQL = SQL & " from tb_car where idx = "& rslist("dcarno") &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsidcarno = rs(0)
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select distinct comname from tb_company where idx = "& rslist("idxsub") &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsicomname = rs(0)
	end if
	rs.close

	if rslist("cbrandchoice")<>"" then
		set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select bname from tb_company_brand "
		SQL = sql & " where bidx = "& rslist("cbrandchoice") &" "
		rs.Open sql, db, 1
		if not rs.eof then
			imsibname = rs(0)
		end if
		rs.close
	else
		imsibname = ""
	end if

	orderflag_fcolor = ""

	mi_money = rslist("mi_money")
	ye_money = rslist("ye_money")
	if orderflag="4" or orderflag="5" then
		orderflag_fcolor = "<font color=blue>"
	elseif orderflag="1" or orderflag="2" or orderflag="3" Or orderflag="6" then
		orderflag_fcolor = "<font color=red>"
	elseif orderflag="y" then
		orderflag_fcolor = ""
		if imsimyflag="y" then		'�ֹ� �� && (���� < �̼�)
			if orderflag="y" and ye_money < mi_money then
				orderflag_fcolor = "<font color=red>"
			end if
		end if
	end if

	imsich_gongi = ""
	imsich_gongi = rslist("ch_gongi")
	if imsich_gongi<>"" then
		imsich_gongi = "*&nbsp;"
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''
	If left(session("Ausercode"),5) = "19209" or left(session("Ausercode"),5) = "96338" Then 
		'misugum = "�̼���1"
         misugum = "�ֹ�����"
	Else
		misugum = "�̼���"
	End if 
	if orderflag="y" or orderflag="" then
		imsiorderflag = "�ֹ���"
	elseif orderflag="1" then
		imsiorderflag = "<font color='red'>" & misugum & "(����)"
	elseif orderflag="2" then
		imsiorderflag = "<font color='red'>���(����)"
	elseif orderflag="3" then
		imsiorderflag = "<font color='red'>�޾�(����)"
	elseif orderflag="4" then
		imsiorderflag = "<font color='blue'>���1(�ֹ�)"
	elseif orderflag="5" then
		imsiorderflag = "<font color='blue'>���2(�ֹ�)"
	elseif orderflag="6" then
		'imsiorderflag = "<font color='red'>�̼���2(����)"
        imsiorderflag = "<font color='red'>���������(����)"
	end if

	order_weekchoice = rslist("order_weekchoice")
	order_weekgubun  = rslist("order_weekgubun")
	if order_weekgubun="1" then
		order_weekgubun = "�����ֹ�"
	else
		'order_weekgubun = "���������ֹ�"
		imsi_val  = ""
		if len(order_weekchoice)>0 then
			for k=1 to len(order_weekchoice)
				select case mid(order_weekchoice,k,1)
					case "2"
						imsival = "��"
					case "3"
						imsival = "ȭ"
					case "4"
						imsival = "��"
					case "5"
						imsival = "��"
					case "6"
						imsival = "��"
					case "7"
						imsival = "��"
					case "1"
						imsival = "��"
				end select
				imsi_val = imsi_val & imsival
			next
		end if
		order_weekgubun = imsi_val
	end if

	com_notice = rslist("ch_gongi")
	if len(com_notice) > 0 then
		com_notice = "��"
	else
		com_notice = "��"
	end if
	''''''''''''''''''''''''''''''''''''''''''''''''
%>

		<input type=hidden name="idx" value="<%=rslist("idx")%>">

		<tr height=22 bgcolor=#FFFFFF align=center align=center>
			<td><%=orderflag_fcolor%><%=j%></td>
			<td><a href="write.asp?gotopage=<%=gotopage%>&flag=<%=flag%>&idx=<%=rslist("idx")%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>"><b><%=orderflag_fcolor%><%=rslist("tcode")%></a></td>
			<td align=left>&nbsp;<%=orderflag_fcolor%><%=imsich_gongi%><%=rslist("comname")%></td>
			<td>
				<%if session("Ausergubun")="3" then%>
					<!--<select name=orderflag style="BACKGROUND-COLOR: #FFFF00;">-->
					<select name=orderflag style="BACKGROUND-COLOR: #F2F1EA;">
						<option value="y" <%if orderflag="y" then%>selected<%end if%>>�ֹ���
						<option value="1" <%if orderflag="1" then%>selected<%end if%> style='color:red;'><%=misugum%>
						<%If left(session("Ausercode"),5) = "19209" or left(session("Ausercode"),5) = "96338" Then %>
						<!--<option value="6" <%if orderflag="6" then%>selected<%end if%> style='color:red;'>�̼���2-->
                            <option value="6" <%if orderflag="6" then%>selected<%end if%> style='color:red;'>���������
						<%End if%>
						<option value="2" <%if orderflag="2" then%>selected<%end if%> style='color:red;'>���
						<option value="3" <%if orderflag="3" then%>selected<%end if%> style='color:red;'>�޾�
						<option value="4" <%if orderflag="4" then%>selected<%end if%> style='color:blue;'>���1
						<option value="5" <%if orderflag="5" then%>selected<%end if%> style='color:blue;'>���2
					</select>
				<%else%>
					<%=imsiorderflag%>
				<%end if%>
			</td>
			<td><%=orderflag_fcolor%><%=order_weekgubun%></td>
			<td><%=orderflag_fcolor%><%=imsibname%></td>
			<td><%=orderflag_fcolor%><%=imsicomname%></td>
			<td><%=orderflag_fcolor%><%=rslist("name")%></td>
			<td><%=orderflag_fcolor%><%=com_notice%></td>
		</tr>

<%
rslist.MoveNext 
i=i+1
j=j+1
loop 
%>

</form>

</table>