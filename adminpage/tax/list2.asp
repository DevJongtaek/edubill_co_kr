<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")

	if searcha = "" then
		searcha = replace(left(now()-1,10),"-","")
	end if
	if searchd = "" then
		searchd = replace(left(now(),10),"-","")
	end if
	if searchb="" then
		searchb="0"
	end if

	imsilink="searcha="&searcha&"&searchb="&searchb&"&searchc="&searchc&"&searchd="&searchd

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

	set rs = server.CreateObject("ADODB.Recordset")
	if session("Ausergubun")="3" and session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then
		SQL = " select comname,carname,usercode,sum(rordermoney), sum(c.rordernum*c.pprice) as aaaaa,tcode "
		SQL = sql & " from (select b.*,a.rordernum,a.pprice, d.tcode,d.comname from tb_order_product a, tb_order b ,tb_company  d where right(usercode,5) = d.idx and  a.idx = b.idx AND a.idx = b.idx AND ISNULL(b.Rgubun,0) != 1 and a.dcenterchoice = '"& trim(session("Adcenteridx")) &"') c "
	else
		'SQL = " select comname2,carname,usercode,sum(rordermoney) "
		'SQL = sql & " from tb_order "
		SQL = " select comname,carname,usercode,sum(rordermoney), sum(c.rordernum*c.pprice) as aaaaa,tcode  "
		SQL = sql & " from (select b.*,a.rordernum,a.pprice , d.tcode,d.comname from tb_order_product a, tb_order b ,tb_company  d where right(usercode,5) = d.idx AND a.idx = b.idx  AND ISNULL(b.Rgubun,0) != 1  ) c "

   
	end if

	SQL = sql & " where flag='y' "
	'SQL = sql & " and rordermoney > 0 "
   
	if session("Ausergubun")="3" then
		SQL = sql & " and substring(usercode,1,10) = '"& left(session("Ausercode"),10) &"' "
	else
		SQL = sql & " and substring(usercode,1,5) = '"& left(session("Ausercode"),5) &"' "
	end if

	SQL = sql & " and orderday >= '"& searcha &"' and orderday <= '"& searchd &"' "

	if searchb<>"0" then
		SQL = sql & " and carname = '"& searchb &"' "
	end if

	if searchc="flag" then
		SQL = sql & " and deflag = 'n' "
	elseif searchc="deflag" then
		SQL = sql & " and deflag = 'y' "
	end if

	SQL = sql & " group by comname,tcode,carname,usercode"
	SQL = sql & " order by comname asc"
	rs.Open sql, db, 1

    ' response.Write sql

%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ ��ǥ��� ]</td>
	</tr>
	<tr height="6">
		<td><font color=red size=2>��.�ֹ�����->�ֹ������� '�������' �׸��� '�ֹ�Ȯ��'(�ֹ�����) Ȥ�� '�������'(��޿Ϸ�)�� ������ �ֹ� ��, ��ǥ��� ����.</td>
	</tr>
	<tr height="6">
		<td><font color=red size=2>��.����(���ݰ�꼭) : ��ǰ�ڵ忡 '����' ǥ���ǰ, �鼼(��꼭) : ��ǰ�ڵ忡 '�����' ǥ���ǰ, �ŷ�(�ŷ�����) : ��� ��ǰ</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<script language="JavaScript">
<!--
function nwinopen33(imsival_1){
	url	= "newwin22.asp?pgubun="+imsival_1+"&<%=imsilink%>";
	window.open(url,"AutoAddr","toolbar=no,menubar=no,scrollbars=yes,resizable=yes,width=700,height=700");
}
//-->
</script>

<form action="list2.asp" method="POST" name=kindform>
	<tr>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>�ֹ�����</td>
		<td nowrap width="20%" bgcolor="#FFFFFF" height="25">
			<input type="Text" name="searcha" size="8" maxlength="8" class="box_work" value="<%=searcha%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<input type="button" name="����" value="����" class="box_work"' onclick="javascript:serchtodaycheck(document.kindform.searcha, document.kindform.searchb);">
		</td>
		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>ȣ��</td>
		<td nowrap width="15%" bgcolor="#FFFFFF" height="25">
			<select name="searchb" size="1" class="box_work">
				<%if hcararrayint<>"" then%>
	          			<option value="0" <%if searchb = "" then%>selected<%end if%>>ȣ����ü</option>
					<%for i=0 to hcararrayint%>
	        	  			<option value="<%=hcararray(1,i)%>" <%if searchb=hcararray(1,i) then%>selected<%end if%>><%=hcararray(1,i)%>ȣ��
					<%next%>
				<%else%>
	          			<option value="0" <%if searchb = "" then%>selected<%end if%>>ȣ����Ͼ���</option>
				<%end if%>
        		</select>
		</td>

		<td nowrap width="10%" bgcolor="#F7F7FF" height="25" align=center><B>����</td>
		<td nowrap width="20%" bgcolor="#FFFFFF" height="25">
			<select name="searchc" size="1" class="box_work">
          			<option value="" <%if searchc = "" then%>selected<%end if%>>��ü</option>
          			<option value="flag" <%if searchc = "flag" then%>selected<%end if%>>�ֹ�Ȯ��</option>
          			<option value="deflag" <%if searchc = "deflag" then%>selected<%end if%>>��޿Ϸ�</option>
	       		</select>
		</td>

		<td nowrap width="15%" bgcolor="#FFFFFF" height="25">
	        	<input type="button" name="�� ��" value="�� �� " class="box_work"' onclick="javascript:kindsearchok2(this.form);">
	        	<input type="button" name="�ʱ�ȭ" value="�ʱ�ȭ" class="box_work"' onclick="javascript:frmzerocheck(this.form,'list2.asp');">
		</td>
	</tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
	<tr height=30 valign=bottom>
		<td width=70%>* ��ü <B><%=rs.recordcount%></b>���� ����Ÿ�� �ֽ��ϴ�.</td>
		<td width=30% align=right>* �ϰ��μ�
			<input type="button" name="����1" value="����" class="box_work"' onclick="javascript:nwinopen33('1')" <%if session("Ausergubun")="3" and session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then%>disabled<%end if%>>
			<input type="button" name="�鼼1" value="�鼼" class="box_work"' onclick="javascript:nwinopen33('2')" <%if session("Ausergubun")="3" and session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then%>disabled<%end if%>>
			<input type="button" name="�ŷ�1" value="�ŷ�" class="box_work"' onclick="javascript:nwinopen33('3')">
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>��ȣ</td>
		<td width=15%>ü�����ڵ�</td>
		<td width=20%>ü������</td>
		<td width=10%>ȣ��</td>
		<td width=20%>�ݾ�</td>
		<td width=20%><%if searchc="1" then%>���ݰ�꼭<%else%>�ŷ�����<%end if%></td>
	</tr>

<form name=form2 method=post>

<%
i=1
do until rs.EOF

	imsirs2tcode=""
	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode from tb_company where idx = "& right(rs(2),5) &" "
	rs2.Open sql, db, 1
	if not rs2.eof then
		imsirs2tcode = rs2(0)
	end if
	rs2.close

if session("Ausergubun")="3" and session("Adcenteridx")<>"" and len(session("Adcenteridx")) > 1 then

	set rs2 = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode from tb_company where idx = "& right(rs(2),5) &" "
	rs2.Open sql, db, 1
	if not rs2.eof then
		imsirs2tcode = rs2(0)
	end if
	rs2.close
%>
	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=i%></td>
		<td><%=imsirs2tcode%></td>
		<td><%=rs(0)%></td>
		<td><%=rs(1)%>ȣ��</td>
		<td align=right><%=FormatCurrency(rs(4),0)%> &nbsp; </td>
		<td>
			<input type=button value="����" onclick="javascript:nwinopen3('1','<%=rs(0)%>','<%=searcha%>','<%=searchb%>','<%=searchc%>','<%=searchd%>','<%=rs(2)%>')" disabled>
			<input type=button value="�鼼" onclick="javascript:nwinopen3('2','<%=rs(0)%>','<%=searcha%>','<%=searchb%>','<%=searchc%>','<%=searchd%>','<%=rs(2)%>')" disabled>
			<input type=button value="�ŷ�" onclick="javascript:nwinopen3('3','<%=rs(0)%>','<%=searcha%>','<%=searchb%>','<%=searchc%>','<%=searchd%>','<%=rs(2)%>')">
		</td>
	</tr>
<%
else

	imsimoney = rs(3)
	if imsimoney="" or isnull(imsimoney) then imsimoney = rs(4)
%>
	<tr height=22 bgcolor=#FFFFFF align=center align=center>
		<td><%=i%></td>
		<td><%=imsirs2tcode%></td>
		<td><%=rs(0)%></td>
		<td><%=rs(1)%>ȣ��</td>
		<td align=right><%=FormatCurrency(rs(4),0)%> &nbsp; </td>
		<td>
			<input type=button value="����" onclick="javascript:nwinopen3('1','<%=rs(0)%>','<%=searcha%>','<%=searchb%>','<%=searchc%>','<%=searchd%>','<%=rs(2)%>')">
			<input type=button value="�鼼" onclick="javascript:nwinopen3('2','<%=rs(0)%>','<%=searcha%>','<%=searchb%>','<%=searchc%>','<%=searchd%>','<%=rs(2)%>')">
			<input type=button value="�ŷ�" onclick="javascript:nwinopen3('3','<%=rs(0)%>','<%=searcha%>','<%=searchb%>','<%=searchc%>','<%=searchd%>','<%=rs(2)%>')">
		</td>
	</tr>
<%
end if

rs.MoveNext 
i=i+1
loop 
%>

</form>

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