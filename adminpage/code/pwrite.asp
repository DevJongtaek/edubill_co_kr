<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<!--#include virtual="/db/db.asp"-->

<%
	searcha = request("searcha")
	searchb = request("searchb")
	GotoPage = Request("GotoPage")
	idx = Request("idx")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select brandflag,dcenterflag,proflag1,proflag2,tcode,fileflag,fileflagchb,productorderweek,usesetmenu , isnull(UseReturn,'n')"
	SQL = sql & " from tb_company "
	SQL = sql & " where idx = '"& left(session("Ausercode"),5) &"' "
	rs.Open sql, db, 1
	imsibrandflag = rs(0)
	imsidcenterflag = rs(1)
	ProFlag1 = rs(2)
	ProFlag2 = rs(3)
	BonsaTcode = rs(4)
	fileflag = rs(5)
	fileflagchb = rs(6)
	productorderweek = rs(7)
	usesetmenu = rs(8)
    usereturn = rs(9)
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select bidx,bname "
	SQL = sql & " from tb_company_brand "
	SQL = sql & " where idx = '"& left(session("Ausercode"),5) &"' order by bname asc"
	rs.Open sql, db, 1
	if not rs.eof then
		imsibrandboxarry = rs.GetRows
		imsibrandboxarry_int = ubound(imsibrandboxarry,2)
	else
		imsibrandboxarry = ""
		imsibrandboxarry_int = ""
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select sidx,sname "
	SQL = sql & " from tb_product_submenu "
	SQL = sql & " where idx = '"& left(session("Ausercode"),5) &"' order by sname asc"
	rs.Open sql, db, 1
	if not rs.eof then
		proFlagArray = rs.GetRows
		proFlagArrayInt = ubound(proFlagArray,2)
	else
		proFlagArray    = ""
		proFlagArrayInt = ""
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select bidx,bname "
	SQL = sql & " from tb_company_dcenter "
	SQL = sql & " where idx = '"& left(session("Ausercode"),5) &"' order by bname asc"
	rs.Open sql, db, 1
	if not rs.eof then
		imsidcenterarry = rs.GetRows
		imsidcenterarry_int = ubound(imsidcenterarry,2)
	else
		imsidcenterarry = ""
		imsidcenterarry_int = ""
	end if
	rs.close

	if idx <> "" then
		set rslist = server.CreateObject("ADODB.Recordset")
		SQL = " select idx,pcode,pname,pprice,ptitle,gubun,bigo,soundfile,fileregcode,cbrandchoice,proout,qty_code,dcenterchoice,prochoice,proimage,order_weekchoice,setmenuitems,isnull(ReturnYn,'n') "
		SQL = sql & " from tb_product "
		SQL = sql & " where idx = "& idx
		rslist.Open sql, db, 1
		imsipcode = rslist(1)
		imsipname = rslist(2)
		imsipprice = rslist(3)
		imsiptitle = rslist(4)
		imsigubun = rslist(5)
		imsibigo = rslist(6)
		imsisoundfile = rslist(7)
		imsifileregcode = rslist(8)
		imsicbrandchoice = rslist(9)
		imsiproout = rslist(10)
		imsiqty_code = rslist(11)
		imsidcenterchoice = rslist(12)
		imsiprochoice = rslist(13)
		imsiproimage = rslist(14)
		imsiorder_weekchoice = rslist(15)
		imsisetmenuitems = rslist(16)
    imsiReturnYn = rslist(17)
		rslist.close
	end If
	
	if imsiorder_weekchoice<>"" then
	if InStrRev(imsiorder_weekchoice,"1") > 0 then
		imsiorder_weekchoice1 = "1"
	end if
	if InStrRev(imsiorder_weekchoice,"2") > 0 then
		imsiorder_weekchoice2 = "2"
	end if
	if InStrRev(imsiorder_weekchoice,"3") > 0 then
		imsiorder_weekchoice3 = "3"
	end if
	if InStrRev(imsiorder_weekchoice,"4") > 0 then
		imsiorder_weekchoice4 = "4"
	end if
	if InStrRev(imsiorder_weekchoice,"5") > 0 then
		imsiorder_weekchoice5 = "5"
	end if
	if InStrRev(imsiorder_weekchoice,"6") > 0 then
		imsiorder_weekchoice6 = "6"
	end if
	if InStrRev(imsiorder_weekchoice,"7") > 0 then
		imsiorder_weekchoice7 = "7"
	end if
end if

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select * from  tb_qtyment order by qty_ment asc"
	rs.Open sql, db, 1
	if not rs.eof then
		qtyarry = rs.GetRows
		qtyarry_int = ubound(qtyarry,2)
	else
		qtyarry = ""
		qtyarry_int = ""
	end if
	rs.close

	db.close
	set db=nothing
%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>[ ��ǰ��� ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>

<script language="JavaScript">
<!--
<%if imsibrandflag="y" then%>
	<%if imsibrandboxarry_int<>"" then%>
		function allcheckgubun() {
			if (form.cbrandchoice_all.checked) {
				<%for i=0 to imsibrandboxarry_int%>
					form.cbrandchoice[<%=i%>].disabled = true;
					form.cbrandchoice[<%=i%>].style.background="#C0C0C0";
				<%next%>
			} else {
				<%for i=0 to imsibrandboxarry_int%>
					form.cbrandchoice[<%=i%>].disabled = false;
					form.cbrandchoice[<%=i%>].style.background="white";
				<%next%>
			}
		}
	<%end if%>
<%end if%>

<%if imsidcenterflag="y" then%>
	<%if imsidcenterarry_int<>"" then%>
		function allcheckgubun2() {
			if (form.dcenterchoice_all.checked) {
				<%for i=0 to imsidcenterarry_int%>
					form.dcenterchoice[<%=i%>].disabled = true;
					form.dcenterchoice[<%=i%>].style.background="#C0C0C0";
				<%next%>
			} else {
				<%for i=0 to imsidcenterarry_int%>
					form.dcenterchoice[<%=i%>].disabled = false;
					form.dcenterchoice[<%=i%>].style.background="white";
				<%next%>
			}
		}
	<%end if%>
<%end if%>

function characterCheck(itemname) {
            var RegExp = /[\'\"]/gi;//���Խ� ����
            var obj = document.getElementsByName(itemname)[0]
            if (RegExp.test(obj.value)) {
                alert("�Է��� �� ���� Ư�������Դϴ�.");
                obj.value = obj.value.substring(0, obj.value.length - 1);//Ư�����ڸ� ����� ����
            }

        }
//-->
</script>

<script language="JavaScript">
<!--
function checkval(val1,val2,val3){
	tmp = val2;
	if (tmp.length < 4) {
		alert("��ǰ�ڵ�� ���� 4���� �Դϴ�!!") ;
		return false ;
	}
	window.open ('/adminpage/jdregok2.asp?val='+val2+'&gubun='+val3,'CheckID','width=0,height=0,top=30000,left=30000')
	return false ;
}

function productwrite333() {
	if (form.pcode.value=="") {
		alert("��ǰ�ڵ带 �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.pcode.focus() ;
		return false ;
	}
	if (form.pname.value=="") {
		alert("��ǰ���� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.pname.focus() ;
		return false ;
	}
	if (form.pprice.value=="") {
		alert("��ǰ�ܰ��� �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.pprice.focus() ;
		return false ;
	}

	<%if fileflag="a" and fileflagchb="y" then%>
	if (form.fileregcode.value=="") {
		alert("���ϻ����ڵ带 �Է��Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.fileregcode.focus() ;
		return false ;
	}
	<%end if%>

	if (form.qty.value=="") {
		alert("�ֹ�����������Ʈ�� �����Ͽ� �ֽñ�ٶ��ϴ�.") ;
		form.qty.focus() ;
		return false ;
	}
	form.submit() ;
	return false ;
}

function allregsave2() {
	var msg;
	msg=confirm("���� ��� ��ǰ�� �����Ͻðڽ��ϱ�?");
	if(msg) {
		form.action="allregsave3.asp";
		form.encoding="application/x-www-form-urlencoded";
		form.submit() ;
		return false ;
	}
}

function allregsave3() {
	var msg;
	var value = "";
	msg=confirm("���� ��� ��ǰ�� �����Ͻðڽ��ϱ�?");
	if(msg) {
		if (form.order_weekchoice1.checked)
		{
			value = value + "1";
		}
		if (form.order_weekchoice2.checked)
		{
			value = value + "2";
		}
		if (form.order_weekchoice3.checked)
		{
			value = value + "3";
		}
		if (form.order_weekchoice4.checked)
		{
			value = value + "4";
		}
		if (form.order_weekchoice5.checked)
		{
			value = value + "5";
		}
		if (form.order_weekchoice6.checked)
		{
			value = value + "6";
		}
		if (form.order_weekchoice7.checked)
		{
			value = value + "7";
		}		
		form.action="allregsave4.asp?value=" + value;
		form.encoding="application/x-www-form-urlencoded";
		form.submit() ;
		return false ;
	}
}

function onlyNumberComma()
{
   if(((event.keyCode<48)||(event.keyCode>57))&&(event.keyCode!=44))
      event.returnValue=false;
}
//-->
</script>

<form action="pwriteok.asp" name=form method=post ENCTYPE="MULTIPART/FORM-DATA" >
<input type=hidden name=idx value="<%=idx%>">
<input type=hidden name=gotopage value="<%=gotopage%>">
<input type="hidden" name="searcha" value="<%=searcha%>">
<input type="hidden" name="searchb" value="<%=searchb%>">
<input type="hidden" name="BonsaTcode" value="<%=BonsaTcode%>">
<input type="hidden" name="fileflag" value="<%=fileflag%>">
<input type="hidden" name="fileflagchb" value="<%=fileflagchb%>">
<input type="hidden" name="old_fileregcode" value="<%=imsifileregcode%>">
<input type="hidden" name="dflag">

	<tr bgcolor=#F7F7FF height=22 align=center>
		<td width=16%><font color=red>*</font><B>��ǰ�ڵ�</td>
		<td width=21%><font color=red>*</font><B>��ǰ��</td>
		<td width=12%><B>�԰ݳ���</td>
		<td width=12%><font color=red>*</font><B>�ܰ�</td>
		<td width=14%><B>����</td>
		<td width=10%><B>���</td>
	</tr>
	<tr bgcolor=white height=22 align=center>
		<td><input type="text" name="pcode" maxlength="4" size=4 OnKeypress="onlyNumber();" class="box_write" value="<%=imsipcode%>" <%if idx <> "" then%>readonly<%end if%>><%if idx="" then%><input type=image src="/images/admin/member_01.gif" border=0 name=cdsds  onClick="return checkval(form,form.pcode.value,4)"><%end if%>
<BR>���� 4�ڸ�
		</td>
		<td>
			<input type="hidden" name="old_pname" maxlength="30" size=20 class="box_write" value="<%=imsipname%>">
			<input type="text" name="pname" maxlength="30" size=20 class="box_write" value="<%=imsipname%>" onkeyup="characterCheck('pname')" onkeydown="characterCheck('pname')">
		</td>
		<td><input type="text" name="ptitle" size=10 class="box_write" value="<%=imsiptitle%>" onkeyup="characterCheck('ptitle')" onkeydown="characterCheck('ptitle')"></td>
		<td><input type="text" name="pprice" maxlength="8" size=10 style="ime-mode:disabled;" class="box_write" value="<%=imsipprice%>" OnKeypress="onlyNumber();">��</td>
		<td>
			<input type="radio" name="gubun" value="����" <%if imsigubun="����" or gubun="" then%>checked<%end if%>>����
			<input type="radio" name="gubun" value="�����" <%if imsigubun="�����" then%>checked<%end if%>>�����
		</td>
		<td><input type="text" name="bigo" size=10 class="box_write" value="<%=imsibigo%>" onkeyup="characterCheck('bigo')" onkeydown="characterCheck('bigo')"></td>
	</tr>
	<tr bgcolor=#F7F7FF height=22 align=center>
		<td colspan=2><B>���ϻ����ڵ�</td>
		<td colspan=2>ǰ������</td>
		<td>�ֹ�����������Ʈ</td>
		<td><%if ProFlag1="2" then%>����Ŵ�<%end if%></td>
	</tr>
	<tr bgcolor=white height=22 align=center>
		<td colspan=2><input type="text" name="fileregcode" size=20 class="box_write" value="<%=imsifileregcode%>"></td>
		<td colspan=2>
			<input type="radio" name="proout" value="y" <%if imsiproout="y" or imsiproout="" then%>checked<%end if%>>�ֹ�����
			<input type="radio" name="proout" value="n" <%if imsiproout="n" then%>checked<%end if%>>ǰ��
		</td>
		<td>
			<select name="qty">
				<option value="">�����ϼ���
				<%if qtyarry_int<>"" then%>
					<%for i=0 to qtyarry_int%>
						<option value="<%=qtyarry(0,i)%>" <%if imsiqty_code=qtyarry(0,i) then%>selected<%end if%>><%=qtyarry(1,i)%>
					<%next%>
				<%end if%>
			</select>
		</td>
		<td>
			<%if ProFlag1="2" then%>
				<%if proFlagArrayInt<>"" then%>
					<select name="prochoice">
						<option value="">
						<%
						for i=0 to proFlagArrayInt
							if isnull(imsiprochoice) then
								imsippp = ""
							else
								imsippp = imsiprochoice
							end if
						%>

							<option value="<%=proFlagArray(0,i)%>" <%if imsippp=cstr(proFlagArray(0,i)) then%>selected<%end if%>><%=proFlagArray(1,i)%>
						<%next%>
					</select>
				<%end if%>
			<%end if%>
		</td>
	</tr>
	<!-- �ֹ����� ���� ����, ��Ʈ�޴� �ڵ� -->
	<% If productorderweek = "y" Or usesetmenu = "y" Then %>
	<tr bgcolor=#F7F7FF height=22 align=center>
	<% End If %>
	<!-- �ֹ����� ���� ����-->
	<% If productorderweek = "y" Then %>
		<td colspan=2><B>�ֹ����� ���ϼ��� <%If idx <> "" Then %><input type="button" value="����ֹ�"  style="background:lightblue;" onclick="return allregsave2();"><%End If%><%If idx <> "" Then %>&nbsp;<input type="button" value="�������"  style="background:lightblue;" onclick="return allregsave3();"><%End If%></td>
	<% End If %>
	<!-- ��Ʈ�޴� -->
	<% If usesetmenu = "y" Then %>
		<td colspan=<%If productorderweek="y" Then %>4<%else%>3<%End If%>>��Ʈ�޴��ڵ� <font color=red>(�ػ�ǰ�ڵ� ������ (,)�� �մϴ�.(��:1000,1001,1002))</font></td>
	<% ElseIf productorderweek = "y" And usesetmenu = "n" Then %>
		<td colspan=4></td>
	<% End If %>
	<!-- �ֹ����ɿ��� ���� ����, ��Ʈ�޴� ���-->
	<% If productorderweek = "n" And usesetmenu = "y" Then %>
		<td colspan=4></td>
	<% End If %>
	<% If productorderweek = "y" Or usesetmenu = "y" Then %>
		</tr>
		<tr bgcolor=white height=22 align=center>
	<%End If %>
	<!-- �ֹ����� ���� ����-->
	<% If productorderweek = "y" Then %>
		<td colspan=2>
			<input type="checkbox" name="order_weekchoice2" value="2" <%If imsiorder_weekchoice2 = "2" Or idx = "" Then %> checked <%End If %>>��
			<input type="checkbox" name="order_weekchoice3" value="3" <%If imsiorder_weekchoice3 = "3" Or idx = "" Then %> checked <%End If %>>ȭ
			<input type="checkbox" name="order_weekchoice4" value="4" <%If imsiorder_weekchoice4 = "4" Or idx = "" Then %> checked <%End If %>>��
			<input type="checkbox" name="order_weekchoice5" value="5" <%If imsiorder_weekchoice5 = "5" Or idx = "" Then %> checked <%End If %>>��
			<input type="checkbox" name="order_weekchoice6" value="6" <%If imsiorder_weekchoice6 = "6" Or idx = "" Then %> checked <%End If %>>��
			<input type="checkbox" name="order_weekchoice7" value="7" <%If imsiorder_weekchoice7 = "7" Or idx = "" Then %> checked <%End If %>>��
			<input type="checkbox" name="order_weekchoice1" value="1" <%If imsiorder_weekchoice1 = "1" Or idx = "" Then %> checked <%End If %>>��
			</td>
	<% End If %>
	<!-- ��Ʈ�޴� -->
	<% If usesetmenu = "y" Then %>
		<td colspan=<%If productorderweek="y" Then %>4<%else%>3<%End If%>><input type="text" name="setmenuitems" maxlength=200 size=30 value="<%=imsisetmenuitems%>" OnKeypress="onlyNumberComma();" ></td>
	<% ElseIf productorderweek = "y" And usesetmenu = "n" Then %>
		<td colspan=4></td>
	<% End If %>
	<!-- �ֹ����ɿ��� ���� ����, ��Ʈ�޴� ���-->
	<% If productorderweek = "n" And usesetmenu = "y" Then %>
		<td colspan=4></td>
	<% End If %>
	<% If productorderweek = "y" Or usesetmenu = "y" Then %>
	</tr>
	<%End If %>
	<%if imsibrandflag="y" then%>
	<tr bgcolor=#F7F7FF height=22 align=center>
		<td colspan=6><B>�귣��</td>
	</tr>
	<tr bgcolor=white height=22 align=center>
		<td colspan=6>
			<%if imsibrandboxarry_int<>"" then%>
				<input type=checkbox name=cbrandchoice_all value="00000" <%if instrrev(imsicbrandchoice,"00000") > 0 then%>checked<%end if%> onclick="allcheckgubun();">�����ǰ &nbsp;
				<%for i=0 to imsibrandboxarry_int%>
					<input type=checkbox name=cbrandchoice value="<%=imsibrandboxarry(0,i)%>" <%if instrrev(imsicbrandchoice,"00000") > 0 then%><%else%><%if instrrev(imsicbrandchoice,imsibrandboxarry(0,i)) > 0 then%>checked<%end if%><%end if%>><%=imsibrandboxarry(1,i)%> &nbsp;
				<%next%>
			<%end if%>
		</td>
	</tr>
<%end if%>

<%if imsidcenterflag="y" then%>
	<tr bgcolor=#F7F7FF height=22 align=center>
		<td colspan=6><B>��������</td>
	</tr>
	<tr bgcolor=white height=22 align=center>
		<td colspan=6>

			<%if imsidcenterarry_int<>"" then%>
				<%for i=0 to imsidcenterarry_int%>
					<input type=radio name=dcenterchoice value="<%=imsidcenterarry(0,i)%>" <%if i=0 then%><%if instrrev(imsidcenterchoice,trim(imsidcenterarry(0,i))) > 0 or imsidcenterchoice="0" or imsidcenterchoice="" or imsidcenterchoice="00000" then%>checked<%end if%><%else%><%if instrrev(imsidcenterchoice,trim(imsidcenterarry(0,i))) > 0 then%>checked<%end if%><%end if%>><%=imsidcenterarry(1,i)%> &nbsp;
				<%next%>
			<%end if%>
		</td>
	</tr>
<%end if%>

<%if ProFlag1="2" and ProFlag2="1" then%>
	<tr bgcolor=#F7F7FF height=22 align=center>
		<td colspan=2><B>��ǰ���� (320�ȼ�x260�ȼ�, GIF)</td>
		<td colspan=4 align=left bgcolor=white><input type=file name=bfile2 size=35> <%if imsiproimage<>"" then%><a href="#" onclick="bwinopenXY('/adminpage/agency/zoom.asp?tcode=<%=BonsaTcode%>&filename=<%=imsiproimage%>', title, '100', '100')"><img src="/fileupdown/pr_image/<%=BonsaTcode%>/<%=imsiproimage%>" border=0 width=25 height=25><%end if%></td>
	</tr>
<%end if%>

    <%if usereturn = "y" then %>

    <tr bgcolor=#F7F7FF height=22 align=center>
		<td colspan=6><B>��ǰ����ǰ��</td>
	</tr>
	<tr bgcolor=white height=22 align=center>
		<td colspan=6>
			
				<input type=checkbox name=chkReturnyn value="y" <%if imsiReturnYn = "y" then %>checked<%end if%>>��ǰ���� &nbsp;
			
				
		</td>
	</tr>
    <%end if%>
</table>

<BR>

<table align=center>
	<tr> 
		<td height=30 align=center>

<%if session("Ausergubun")="2" then%>
	<%if session("Auserwrite")="y" then%>
		<%if idx="" then%>
			<input type="image" src="/images/admin/l_bu01.gif" border=0 onclick="return productwrite333();">
		<%else%>
			<input type="image" src="/images/admin/l_bu03.gif" border=0 onclick="return productwrite333();">
			<a href="#" onclick="javascript:productdel(this.form);"><img src="/images/admin/l_bu04.gif" border=0></a>
		<%end if%>
	<%end if%>
<%end if%>
			<a href="plist.asp?GotoPage=<%=GotoPage%>"><img src="/images/admin/l_bu07.gif" border=0></a>

		</td>
	</tr>

</form>

</table>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
<FORM NAME="sms" method="post" action="send_save.asp" ENCTYPE="MULTIPART/FORM-DATA" onsubmit="return smscheck()">
	<tr height="47">
		<td><font color=blue size=3><B>[ ��ǰ�ϰ���� �� ���� ]</td>
	</tr>
</table>

<table cellspacing=1 cellpadding=1 width="100%" border=0 bgcolor=#BDCBE7>
	<tr bgcolor=#F7F7FF height=22 align=center>
		<td width=30%><font color=red>*</font><B>�������ϼ���</td>
		<td width=70% bgcolor=white>
<select name=excell_gubun>
	<option value="">�ű�
	<option value="1">���ݼ���
</select>
<INPUT TYPE="FILE" NAME="bfile1" size="40"> </td>
	</tr>
</table>

<table align=center>
	<tr> 
		<td height=30 align=center>

<%if session("Ausergubun")="2" then%>
	<%if session("Auserwrite")="y" then%>
		<%if idx="" then%>
			<input type="image" src="/images/admin/l_bu01.gif" border=0 name=sddsds>
		<%else%>
			<input type="image" src="/images/admin/l_bu03.gif" border=0>
			<a href="#" onclick="javascript:productdel(this.form);"><img src="/images/admin/l_bu04.gif" border=0></a>
		<%end if%>
	<%end if%>
<%end if%>
			<a href="plist.asp?GotoPage=<%=GotoPage%>" ><img src="/images/admin/l_bu07.gif" border=0></a>

		</td>
	</tr>

</form>

</table>

				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

<BR><BR>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->