<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	searchd = request("searchd")
	searche = request("searche")
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if searchd="" then searchd = replace(left(now()-14,10),"-","")
	if searche="" then searche = replace(left(now(),10),"-","")
	linksql = "searchd="&searchd&"&searche="&searche
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	sessionSql1 = "bidxsub = "& left(session("Ausercode"),5) &" and idxsub = "& mid(session("Ausercode"),6,5) &" "
	sessionSql2 = "substring(a.usercode,1,10) = '"& mid(session("Ausercode"),1,10) &"' "
	sessionSql3 = "a.orderday >= '"& searchd &"' and a.orderday <= '"& searche &"' "
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	sql = " select "
	SQL = sql & " 	aa.tcode, aa.comname, aa.name, aa.wdate, "
	SQL = sql & " 	isnull(bb.pcnt,0), isnull(bb.hapmoney,0), bb.usercode "
	SQL = sql & " from "
	SQL = sql & " ( "
	SQL = sql & " select bidxsub as bcode, idxsub as mcode, idx as scode, tcode,comname,name,substring(wdate,1,10) as wdate "
	SQL = sql & " from tb_company "
	SQL = sql & " where flag = '3' "	'���ϻ�����
	SQL = sql & " and " & sessionSql1
	SQL = sql & " ) aa "
	SQL = sql & " right outer join "
	SQL = sql & " ( "
	SQL = sql & " select a.usercode, sum(b.rordernum) as pcnt, sum(b.rordernum*b.pprice) as hapmoney "
	SQL = sql & " from tb_order a, tb_order_product b "
	SQL = sql & " where a.idx = b.idx "
	SQL = sql & " and " & sessionSql2
	SQL = sql & " and b.flag = 'T'  "
	SQL = sql & " and " & sessionSql3
	SQL = sql & " group by a.usercode "
	SQL = sql & " ) bb "
	SQL = sql & " on aa.bcode = substring(bb.usercode,1,5) and aa.mcode = substring(bb.usercode,6,5) and aa.scode = substring(bb.usercode,11,5) "
	SQL = sql & " order by aa.tcode asc "
	rs.Open sql, db, 1
	if not rs.eof then
		groupArr = rs.GetRows
		groupArrint = ubound(groupArr,2)
	else
		groupArrint = ""
	end if
	rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	sql = " select "
	sql = sql & " 	aa.comname, aa.tcode,  "
	sql = sql & " 	bb.orderday, bb.pcode, bb.pname, cc.ptitle , isnull(bb.pprice,0) as pprice, isnull(bb.pcnt,0) as pcnt, isnull(bb.hapmoney,0) as hapmoney "
	sql = sql & " from "
	sql = sql & " ( "
	sql = sql & " select bidxsub as bcode, idxsub as mcode, idx as scode, tcode,comname "
	sql = sql & " from tb_company "
	sql = sql & " where flag = '3' "
	sql = sql & " and " & sessionSql1
	sql = sql & " ) aa "
	sql = sql & " right outer join "
	sql = sql & " ( "
	sql = sql & " select a.usercode, a.orderday, b.pcode, b.pname, sum(b.pprice) as pprice, sum(b.rordernum) as pcnt, sum(b.rordernum*b.pprice) as hapmoney "
	sql = sql & " from tb_order a, tb_order_product b "
	sql = sql & " where a.idx = b.idx "
	sql = sql & " and " & sessionSql2
	sql = sql & " and b.flag = 'T'  "
	sql = sql & " and " & sessionSql3
	sql = sql & " group by a.usercode, a.orderday, b.pcode, b.pname "
	sql = sql & " ) bb "
	sql = sql & " on aa.bcode = substring(bb.usercode,1,5) and aa.mcode = substring(bb.usercode,6,5) and aa.scode = substring(bb.usercode,11,5) "

	sql = sql & " left outer join "
	sql = sql & " ( select pcode,ptitle from tb_product where substring(usercode,1,5) = '"& mid(session("Ausercode"),1,5) &"' ) cc "
	sql = sql & " on bb.pcode = cc.pcode "
	sql = sql & " order by aa.tcode asc, bb.orderday asc, bb.pcode asc "
	rs.Open sql, db, 1
	if not rs.eof then
		PrivateArr = rs.GetRows
		PrivateArrint = ubound(PrivateArr,2)
	else
		PrivateArrint = ""
	end if
	rs.close
%>


<script language="JavaScript">
<!--
function posorderwin(){
	window.open ('jisaSu_print.asp?<%=linksql%>','dssdsd','width=800,height=600,left=100,top=100,scrollbars=yes');
	return false ;
}

function stxtcheck(form) {
	if ((form.searchd.value=="")||(form.searche.length < 8)) {
		alert("����Ⱓ�� 8�ڸ��� �ùٸ��� �Է��� �ּ���.") ;
		form.searchd.focus() ;
		return false ;
        }
	form.submit() ;
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
		<td><font color=blue size=3><B>[ ������ ���곻�� ]</td>
	</tr>
	<tr height="40">
		<td>
			<font color=red>
�� ���ñ��� �ֱ� 2�ְ� ���곻�� �Դϴ�. ( ����Ⱓ ���� ��, ���� 1�������� ��ȸ���� )
<BR>
�� �� ȭ���� ����ǥ�ۼ� �۾��� �̷�����Ƿ� �ð��� ����(�� 20�� ����) �ɸ� �� �ֽ��ϴ�. 
<BR>
�� �����Ḧ ������ �ִ� ���� : ��� �� ���ݱ��� �Ϸ�� �ֹ� �� ( ��, �ֹ������� ������ڿ� '*' �� �� - �ٿ�ε� �� ��)  
			</font>
		</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="jisaSu.asp" method="POST" name=form>

	<tr>
		<td nowrap width="16%" bgcolor="#F7F7FF" height="25" align=center><B>����Ⱓ</td>
		<td nowrap width="84%" bgcolor="#FFFFFF" height="25">
		<table border="0" cellspacing="0" cellpadding="0" width="100%">
			<tr>
				<td>
					<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
					~
					<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			        	<input type="button" name="�� ��" value="�� �� " class="box_work"' onclick="javascript:stxtcheck(this.form);">
					( ����� ������� )
				</td>
				<td align=right>
	        			<input type="button" name="�μ�" value="�μ�" class="box_work"' onclick="javascript:posorderwin();">
	        			<input type="button" name="����" value="����" class="box_work"' onclick="javascript:location.href='jisaSu_excel.asp?<%=linksql%>';">
				</td>
			</tr>
		</table>
		</td>
	</tr>

</form>

</table>

<table border="0" cellspacing="0" cellpadding="0" width=100%><tr height=20><td><B>[ ü������ �հ�ǥ ]</td></tr></table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#B4B4B4>
	<tr height=25 bgcolor=#EFEFEF align=center>
		<td width=5%>��ȣ</td>
		<td width=10%>ü�����ڵ�</td>
		<td width=40%>ü������</td>
		<td width=10%>��ǥ��</td>
		<td width=10%>�������</td>
		<td width=10%>�ڽ��հ�</td>
		<td width=15%>�������հ�</td>
	</tr>

<%
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	if groupArrint<>"" then
		hap1 = 0
		hap2 = 0
		for i=0 to groupArrint
			hap1 = cdbl(hap1)+cdbl(groupArr(4,i))
			hap2 = cdbl(hap2)+cdbl(groupArr(5,i))
			imsifate = trim(groupArr(3,i))
			if isnull(imsifate) or imsifate = "" then
			else
				imsifate = replace(groupArr(3,i),"-","/")
			end if
%>

			<tr height=20 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
				<td><%=i+1%></td>
				<td><%=groupArr(0,i)%></td>
				<td align=left>&nbsp;<%=groupArr(1,i)%></td>
				<td><%=groupArr(2,i)%></td>
				<td><%=imsifate%></td>
				<td align=right><%=formatnumber(groupArr(4,i),0)%>&nbsp;</td>
				<td align=right><%=formatnumber(groupArr(5,i),0)%>&nbsp;</td>
			</tr>

<%
		next
	end if
%>

	<tr height=25 bgcolor=#EFEFEF align=center>
		<td colspan=5>�� ��</td>
		<td align=right><%=formatnumber(hap1,0)%>&nbsp;</td>
		<td align=right><%=formatnumber(hap2,0)%>&nbsp;</td>
	</tr>
</table>

<BR>

<%
	if PrivateArrint<>"" then
		hap1=0
		hap2=0
		for i=0 to PrivateArrint
			imsihtm = "<table border='0' cellspacing=0 cellpadding=0 width='100%'><tr height=20><td><B>["& PrivateArr(0,i) &" ("& PrivateArr(1,i) &")]</td></tr></table>"
			imsihtm = imsihtm & " <table border=0 cellspacing=1 cellpadding=1 width='100%' bgcolor='#BDCBE7'>"
			imsihtm = imsihtm & " 	<tr height=25 bgcolor=#F7F7FF align=center>"
			imsihtm = imsihtm & " 		<td width='7%'>����</td>"
			imsihtm = imsihtm & " 		<td width='10%'>��ǰ�ڵ�</td>"
			imsihtm = imsihtm & " 		<td width='33%'>��ǰ��</td>"
			imsihtm = imsihtm & " 		<td width='15%'>�԰�</td>"
			imsihtm = imsihtm & " 		<td width='10%'>�ܰ�</td>"
			imsihtm = imsihtm & " 		<td width='10%'>�ڽ�</td>"
			imsihtm = imsihtm & " 		<td width='15%'>������</td>"
			imsihtm = imsihtm & " 	</tr>"
			'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			newTcode = PrivateArr(1,i)
			if i=0 or newTcode<>oldTcode then
				if i>0 then 
					response.write "<tr height=25 bgcolor=#F7F7FF align=center> "
					response.write "		<td colspan=5>�� ��</td> "
					response.write "		<td align=right>"& formatnumber(hap1,0) &"&nbsp;</td> "
					response.write "		<td align=right>"& formatnumber(hap2,0) &"&nbsp;</td> "
					response.write "	</tr> "
					response.write "</table><BR>"
					hap1=0
					hap2=0
				end if
				response.write imsihtm
			end if
			hap1 = cdbl(hap1) + cdbl(PrivateArr(7,i))
			hap2 = cdbl(hap2) + cdbl(PrivateArr(8,i))
%>

				<tr height=20 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
					<td><%=mid(PrivateArr(2,i),5,2)%>/<%=right(PrivateArr(2,i),2)%></td>
					<td><%=PrivateArr(3,i)%></td>
					<td align=left>&nbsp;<%=PrivateArr(4,i)%></td>
					<td><%=PrivateArr(5,i)%></td>
					<td align=right><%=formatnumber(PrivateArr(6,i),0)%></td>
					<td align=right><%=formatnumber(PrivateArr(7,i),0)%>&nbsp;</td>
					<td align=right><%=formatnumber(PrivateArr(8,i),0)%>&nbsp;</td>
				</tr>
<%
			oldTcode = newTcode
		next
	end if

	response.write "<tr height=25 bgcolor=#F7F7FF align=center> "
	response.write "		<td colspan=5>�� ��</td> "
	response.write "		<td align=right>"& formatnumber(hap1,0) &"&nbsp;</td> "
	response.write "		<td align=right>"& formatnumber(hap2,0) &"&nbsp;</td> "
	response.write "	</tr> "
	response.write "</table><BR>"
%>

				</table>
				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<%
	db.close
	set rs=nothing
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->
