<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")
	'�ֹ� �ð�
	searchi = request("searchi")
	searchj = request("searchj")

  


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
		searchd = replace(left(now()-1,10),"-","")
	end if

	if searche="" then
		searche = replace(left(now(),10),"-","")
	end If

  
   if searchh <> "" then
	searchhArr = split(searchh,",")
  
   
    for i=0 to ubound(searchhArr)
			imsival = trim(searchhArr(i))
			if i=0 then
    	    inCnt = "'"& imsival &"'"
            else 
			inCnt =  inCnt &","& "'"& imsival &"'"
			end if
		next

    else

     
    inCnt = "'y','4','5','1','6','2','3'"
   
	end if
   
    
 
		
	
    



	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end If
	
	 
	
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select SearchOrderTime, SearchStartTime, SearchEndTime "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
	if not rs.eof then
		SearchOrderTime = rs(0)    '�ð����
		SearchStartTime = rs(1)	   '���۽ð�
		SearchEndTime = rs(2)      '����ð�
	else
		SearchOrderTime = "n"
		SearchStartTime = ""
		SearchEndTime = ""
	end if
	rs.close
	
   
	

   
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select myflag,smsflag,tcode,smsflagType "
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = "& left(session("Ausercode"),5) &" "
	rs.Open sql, db, 1
    rs_myflag = rs(0)	'�̼�üũ����
	smsflag = rs(1)
	smsttcode1 = rs(2)
	smsflagType = rs(3)
    
	rs.close

	
		
	'�ֹ��ð�
	If searchi = "" Then 
		If  SearchStartTime = "" Then 
			searchi = "000000"
		Else 
			If Len(SearchStartTime) = 4 Then 
				searchi = SearchStartTime & "00"
			Else
				searchi = "000000"
			End If 
		End If 
	End If 

	If searchj = "" Then 
		If SearchEndTime = ""Then 
			searchj = "235959"
		Else 
			If Len(SearchEndTime) = 4 Then 
				searchj = SearchEndTime & "59"
			Else
				searchj = "235959"
			End If 
		End If
	End If 
	
	startdate = searchd + searchi
	enddate = searche + searchj


  
  


	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select * "
	SQL = sql & " from tb_company "
	SQL = sql & " where bidxsub = '"& left(session("Ausercode"),5) &"' "
   
	if session("Ausergubun")="3" then
		SQL = sql & " and idxsub = '"& mid(session("Ausercode"),6,5) &"' "
	end if
	SQL = sql & " and flag = '3' "
	SQL = sql & " and orderflag  in ("&inCnt&")"
	SQL = sql & " and idx not in ( "
	SQL = sql & " 	select distinct substring(usercode,11,5) "
	SQL = sql & " 	from tb_order where substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
     SQL = sql & " AND ISNULL(Rgubun,0) != 1 "
	If searchordertime = "n" Or searchordertime ="" Then 
		SQL = sql & " 	and orderday >= '"& searchd &"' and orderday <= '"& searche &"' "
	Else 
		SQL = sql & "  and (convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) >= convert(datetime, left('" & startdate & "', 4) + '-' + substring('" & startdate & "', 5, 2) + '-' + substring('" & startdate & "', 7, 2) + ' ' + substring('" & startdate & "', 9, 2) + ':' + substring('" & startdate & "', 11, 2) + ':' + substring('" & startdate & "', 13, 2)) "
		SQL = sql & " and convert(datetime, left(idx, 4) + '-' + substring(idx, 5, 2) + '-' + substring(idx, 7, 2) + ' ' + substring(idx, 9, 2) + ':' + substring(idx, 11, 2) + ':' + substring(idx, 13, 2)) <= convert(datetime, left('" & enddate & "', 4) + '-' + substring('" & enddate & "', 5, 2) + '-' + substring('" & enddate & "', 7, 2) + ' ' + substring('" & enddate & "', 9, 2) + ':' + substring('" & enddate & "', 11, 2) + ':' + substring('" & enddate & "', 13, 2)) )  "
	End If 
  
	SQL = sql & " 	) "
	SQL = sql & " order by orderflag desc "
	
  ' response.write sql
 
	

	'response.write sql
	rslist.PageSize=20

	rslist.Open sql, db, 1



       if not rslist.eof then
		hcararray = rslist.GetRows
		hcararrayint = ubound(hcararray,2)
	else
		hcararray = ""
		hcararrayint = ""
	end if


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
function posorderwin(){
	window.open ('posDatatorder.asp','dssdsd','width=300,height=180,left=100,top=100');
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
		<td><font color=blue size=3><B>[ ���ֹ� ü���� ]</td>
	</tr>
	<tr height="6">
		<td><font color=red size=2>��.'�ֹ�����'�� �ֹ� �� ��, ������ �Ⱓ ���ȿ� �ֹ��� ���� �� �ǵ� ���� ü���� ����Ʈ</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="MOrderList.asp" method="POST" name=form>
	<tr>
		<td nowrap width="20%" bgcolor="#F7F7FF" height="25"> &nbsp;<B>�� �ֹ����� �˻�</td>
		<td nowrap width="80%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<%If searchordertime = "y" Then %><input type="Text" name="searchi" size="6" maxlength="6" class="box_work" value="<%=searchi%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;"><%End If %>
			~
			<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<%If searchordertime = "y" Then %><input type="Text" name="searchj" size="6" maxlength="6" class="box_work" value="<%=searchj%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;"><%End If %>
			<input type="button" name="����" value="����" class="box_work"' onclick="javascript:serchtodaycheck(document.form.searchd, document.form.searche);"> ��)20040928 ~ 20041004
			<BR>
			
			
			<select name="searchh" size="3" class="box_work" multiple>
	          			<option value="" <%if searchh="" then%>selected<%end if%>>�ֹ�������ü
        	  			<option value="y" <%if searchh="y" then%>selected<%end if%>>�ֹ���
        	  			<option value="4" <%if searchh="4" then%>selected<%end if%>>���1(�ֹ�)
        	  			<option value="5" <%if searchh="5" then%>selected<%end if%>>���2(�ֹ�)
        	  		<%	If left(session("Ausercode"),5) = "19209"  or left(session("Ausercode"),5) = "96338" Then %>
		<!--<option value="1" <%if searchh="1" then%>selected<%end if%>>�̼���1(����)
        	  			<option value="6" <%if searchh="6" then%>selected<%end if%>>�̼���2(����)-->
                              <option value="1" <%if searchh="1" then%>selected<%end if%>>�ֹ�����(����)
        	  			<option value="6" <%if searchh="6" then%>selected<%end if%>>���������(����)
	 <% else %>
		<option value="1" <%if searchh="1" then%>selected<%end if%>>�̼���(����)
        	  		
	<%	end if %>
        	  			
	        	  		<option value="2" <%if searchh="2" then%>selected<%end if%>>���(����)
        	  			<option value="3" <%if searchh="3" then%>selected<%end if%>>�޾�(����)
        		</select>
        		
	        	<input type="button" name="�� ��" value="�� �� " class="box_work"  onclick="javascript:kindsearchok2(this.form);">
	        	<input type="button" name="�ʱ�ȭ" value="�ʱ�ȭ" class="box_work" onclick="javascript:frmzerocheck(this.form,'MOrderList.asp');">
	      
            <%if smsflag= "y" then%>	
            <%if rslist.recordcount =0 then%>

            <%else %>
            <input type="button" name="��������" value="��������" class="box_work"  onclick="javascript: bwinopenXY('Msms.asp?sms=<%=rslist.recordcount%>&tcode=<%if hcararrayint<>"" then%>	<%for i=0 to hcararrayint%> <%=hcararray(1,i)%>, <%next%><%end if%>', 'domain', 500, 400)">
            <%end if %>
            <%end if%>
          
          	
	        
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* ��ü <B><%=rslist.recordcount%></b>���� ����Ÿ�� �ֽ��ϴ�.</td>
		<td width=30% align=right><a href="MOrderListExcel.asp?searcha=<%=searcha%>&searchh=<%=searchh%>&searche=<%=searche%>&searchd=<%=searchd%>&searchg=<%=searchg%>&fclass1=<%=fclass1%>&sclass2=<%=sclass2%>&tclass3=<%=tclass3%>"><img src="/images/admin/excel.gif" border=0></a></td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>��ȣ</td>
		<td width=10%>�ڵ�</td>
		<td width=15%>ü������</td>
		<td width=15%>�귣��</td>
		<td width=11%>�����</td>
		<td width=12%>��ȭ��ȣ</td>
		<td width=12%>�ڵ���</td>
		<td width=8%>ȣ��</td>
		<td width=12%>�ֹ�����</td>
	</tr>

<%
i=1
j=((gotopage-1)*19)+gotopage
do until rslist.EOF or rslist.PageSize<i
   
	
	
	tel = rslist("tel1")&"-"&rslist("tel2")&"-"&rslist("tel3")
	hp  = rslist("hp1")&"-"&rslist("hp2")&"-"&rslist("hp3")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select dcarno "
	SQL = sql & " from tb_car "
	SQL = sql & " where usercode = '"& left(session("Ausercode"),5) &"' "
	SQL = sql & " and idx = "& rslist("dcarno") &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsidcarname = rs(0)
	ELSE
		imsidcarname = ""
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

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select distinct comname from tb_company where idx = "& rslist("idxsub") &" "
	rs.Open sql, db, 1
	if not rs.eof then
		imsicomname = rs(0)
	end if
	rs.close
	
	orderflag = rslist("orderflag")
	
	If left(session("Ausercode"),5) = "19209" or left(session("Ausercode"),5) = "96338" Then 
		'misugum = "�̼���1"
        misugum = "�ֹ�����"
	Else
		misugum = "�̼���"
	End if 
	
	if orderflag="y" then
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
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=rslist("tcode")%></td>
		<td align="left">&nbsp;<%=rslist("comname")%></td>

		<td><%=imsibname%></td>
		<td><%=imsicomname%></td>
		<td><%=tel%></td>
		<td><%=hp%></td>
		<td><%=imsidcarname%></td>
		<td align="left">&nbsp;
				
					<%=imsiorderflag%>
				
		</td>
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
				<a href="MOrderList.asp?GotoPage=1&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">ù������</a>&nbsp;
				<a href="MOrderList.asp?GotoPage=<%=blockPage-10%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">���� 10��</a>&nbsp;[&nbsp;
		<% 	End If
			i=1
			Do Until i > 10 or blockPage > rslist.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>
				<%Else%>
					<a href="MOrderList.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">[<font color=blue><%=blockPage%></font>]</a>
				<%End If

				blockPage=blockPage+1
				i = i + 1
			Loop
			if blockPage > rslist.pagecount Then
				   Response.Write " ] <font color=#8B9494>����10��</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="MOrderList.asp?GotoPage=<%=blockPage%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">���� 10��</a>
				&nbsp;<a href="MOrderList.asp?GotoPage=<%=rslist.pagecount%>&searcha=<%=searcha%>&searchb=<%=searchb%>&searchc=<%=searchc%>&searchd=<%=searchd%>&searche=<%=searche%>&searchf=<%=searchf%>&searchg=<%=searchg%>&searchh=<%=searchh%>&searchi=<%=searchi%>&searchj=<%=searchj%>">������</a>
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