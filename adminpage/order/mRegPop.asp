<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	searcha = request("searcha")
	searchd = request("searchd")
	searche = request("searche")
	if searchd="" then searchd = replace(left(now()-31,10),"-","")
	if searche="" then searche = replace(left(now(),10),"-","")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select c.* "
	SQL = sql & " from tb_company b , tb_virtual_acnt c "
	SQL = sql & " where b.virtual_acnt = c.va_no "
	SQL = sql & " and   b.flag = '3' "
	SQL = sql & " and   c.dep_st = '1' "


	if searcha<>"" then SQL = sql & " and c.orderCheck = '"& searcha &"' "

	if session("Ausergubun")="3" then
		SQL = sql & " and   b.bidxsub = "& mid(session("Ausercode"),1,5) &" "
		SQL = sql & " and   b.idxsub  = "& mid(session("Ausercode"),6,5) &" "
	else
		SQL = sql & " and   b.bidxsub = "& mid(session("Ausercode"),1,5) &" "
	end if

	SQL = sql & " and   c.tr_il >= '"& searchd &"' "
	SQL = sql & " and   c.tr_il <= '"& searche &"' "

	SQL = sql & " order by c.idx desc "
'response.write sql
	rs.Open sql, db, 1
	imsicnt = rs.recordcount
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>��Ȯ�� �Ա�</title>
<link href="/css/jin.css" rel="stylesheet" type="text/css" />

<script language="JavaScript">
<!--
function CheckAll(objChkBox)
{ 
    bChecked = (objChkBox.checked)?true:false
    for (x=0;x<objChkBox.form.length;x++)
    {
	if (objChkBox.form.elements[x].disabled==false){
	        objChkBox.form.elements[x].checked = bChecked;
	}
    }
}

function choicedel(form) {
	var imsicnt = 0;
	for(var i=0; i<document.form.snum.length;i++) 	//üũ�ڽ� ����
	{
		if(document.form.snum[i].checked == true){
			imsicnt = 1
		}
	}
	if(document.form.snum.checked == true){
		imsicnt = 1
	}
	if (imsicnt<1) {
		alert("����Ÿ�� ������ �ּ���.") ;
		return false ;
	}
	document.form.target="up_ingflag";
	document.form.action="mRegPopOk.asp";
	document.form.submit();
	return false ;
}

function schb(form) {
	if (form.searchd.value=="") {
		alert("��¥�� �Է��� �ּ���.") ;
		return false ;
	}
	if (form.searche.value=="") {
		alert("��¥�� �Է��� �ּ���.") ;
		return false ;
	}
	document.form.target="_self";
	document.form.action="mRegPop.asp";
	document.form.submit();
	return false ;
}

function onlyNumber(){
   if((event.keyCode<48)||(event.keyCode>57))
      event.returnValue=false;
}
//-->
</script>

</head>
<body topmargin="0" leftmargin="10">

<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height=45><font color=blue size=3><B>[������� �Աݳ���]</td>
	</tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width=100%0>

<iframe name=up_ingflag frameborder=0 width=0 height=0></iframe>
<form action="mRegPopOk.asp" name=form method=post>
<input type=hidden name=sgubun value="6">

	<tr height=10>
		<td align=right>
		  <font color=black>�˻��Ⱓ :
			<input type="Text" name="searchd" size="8" maxlength="8" class="box_work" value="<%=searchd%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			~
			<input type="Text" name="searche" size="8" maxlength="8" class="box_work" value="<%=searche%>" OnKeypress="onlyNumber();" style="ime-mode:disabled;">
			<select name="searcha">
				<option value=""  <%if searcha="" then response.write "selected"%>>��ü
				<option value="n" <%if searcha="n" then response.write "selected"%>>��Ȯ�� �Ա�
				<option value="y" <%if searcha="y" then response.write "selected"%>>�ֹ�Ȯ�� �Ա�
			</select>
	        	<input type="button" name="�� ��" value="�� �� " class="box_work"' onclick="javascript:schb(this.form);">
			<input type=button value="����Ȯ��" onclick="return choicedel(this.form);">
		</td>
	</tr>
</table>

<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7>
	<tr height=28 bgcolor=#F7F7FF align=center>
		<td width=5%>��ȣ</td>
		<td width=18%>������¹�ȣ</td>
		<td width=14%>�Ա�����</td>
		<td width=23%>�Ա���</td>
		<td width=12%>�Ա�����</td>
		<td width=10%>�Աݽð�</td>
		<td width=13%>�Աݾ�</td>
		<td width=5%><input type=checkbox name="canta" onclick="CheckAll(this)"></td>
	</tr>

<%
	j=imsicnt
	do until rs.eof
%>

	<tr height=22 bgcolor=#FFFFFF align=center align=center onMouseOver="this.style.background='#F7F7FF'" onMouseOut="this.style.background='#FFFFFF'">
		<td><%=j%></td>
		<td><%=rs("va_no")%></td>
		<td><%=rs("depbnk_nm")%></td>
		<td><%=rs("cust_nm")%></td>
		<td><%=mid(rs("tr_il"),1,4)%>/<%=mid(rs("tr_il"),5,2)%>/<%=mid(rs("tr_il"),7,2)%></td>
		<td><%=mid(rs("tr_si"),1,2)%>:<%=mid(rs("tr_si"),3,2)%></td>
		<td align=right><%=formatnumber(rs("dep_amt"),0)%>&nbsp;</td>
		<td><%if rs("orderCheck")="n" then%><input type=checkbox name=snum value="<%=rs("idx")%>"><%end if%></td>
	</tr>

<%
	rs.movenext
	j=j-1
	loop
	rs.close
	db.close
%>

</table>

</body>
</html>