<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<!--#include virtual="/adminpage/incfile/top.asp"-->
<%
	'--------------------------------------------------------------------------------------------------------------------
	'# �ڹٽ�ũ��Ʈ alertâ
	'# alertFlag     1:���������� �̵�    2:�����������̵�    3:�θ�â ���ΰ�ħ �� �ڽ�â �ݱ�    4:�θ�â ���ΰ�ħ��    
	'#               5:������ ������ �̵�
	'# alertMsgFlag  y: �޼������� �Ѹ�   n:�޼������� �ȻѸ�
	'# alertMsg	 �޼�������
	'# alertURL	 �̵��� �ּ�
	'--------------------------------------------------------------------------------------------------------------------
	searcha = request("searcha") 'oderflag
	searchb = request("searchb") 'idxsub
	searchc = request("searchc") 'bidx
	searchd = request("searchd") '�˻� ����(�ڵ�, ��)
	searche = request("searche") '�˻���
	searchf = request("searchf") '���ڳ���
	searchg = request("searchg")
	searchh = request("searchh")
	CallNumber = request("CallNumber")

	'CallNumber , ���� 
	If CallNumber <> "" Then 
		If Len(CallNumber) > 4 Then 
			clenth = Len(CallNumber) -3
			CallNumber = Left(CallNumber, clenth)
		End  if 
	End If 
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	GotoPage = Request("GotoPage")
	if GotoPage = "" then
		GotoPage = 1
	end If
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select bidx,bname from tb_company_brand "
	SQL = sql & " where idx = "& left(session("Ausercode"),5) &" order by bname asc "
	rs.Open sql, db, 1
	if not rs.eof then
		brand_array    = rs.GetRows
		brand_arraynum = ubound(brand_array,2)
	else
		brand_array    = ""
		brand_arraynum = ""
	end if
	rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx,comname from tb_company where flag='2' and bidxsub = "& left(session("Ausercode"),5) &" order by comname asc"
	rs.Open sql, db, 1
	if not rs.eof then
		jisaarray = rs.GetRows
		jisaarrayint = ubound(jisaarray,2)
	else
		jisaarray = ""
		jisaarrayint = ""
	end if
	rs.close
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'�߰��� �ŷ�ó ���
	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode, comname, hp1 + hp2 + hp3 hp from tb_company"
	SQL = SQL & " where BIDXSUB = '"& left(session("Ausercode"),5) &"' "
	SQL = SQL & " AND flag= '3'"
	SQL = SQL & " AND tcode in ('" & CallNumber &"')"
	'response.write SQL & "<br>"
	rs.Open sql, db, 1

	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode, comname, hp1 + hp2 + hp3 hp from tb_company "
	SQL = SQL & " where BIDXSUB = '"& left(session("Ausercode"),5) &"' "
	SQL = SQL & " AND flag= '3'"
	If searcha <> "a" And  searcha <> "" Then 
		If searcha = "6" Then 
			SQL = SQL & " and 0 > (ye_money - mi_money) "
		Else 
			SQL = SQL & " and orderflag = '" & searcha & "' "     '�����÷���
		End if 
	End If 
	If searchb <> "a" And searchb <> "" Then
	    SQL = SQL & " and idxsub = '" & searchb & "'"     '����
	End If 
	If searchc <> "a" And searchc <> "" Then      '�귣��
		SQL = SQL & " and cbrandchoice = '"& searchc &"' "
	End If 
	If searchd = "chainname" Then      '�귣��
		SQL = SQL & " and comname like '%"& searche &"%' "
	ElseIf searchd = "chaincode" Then 
		SQL = SQL & " and tcode = '"& searche &"' "
	End If 
	'response.write SQL
	rslist.Open SQL, db, 1
%>

<table width="800" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	<tr height="47">
		<td align=center>

		<table width="95%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
			<tr height="47">
				<td align=center>

<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff" align="center">
	<tr height="47">
		<td><font color=blue size=3><B>&nbsp;&nbsp;[ SMS ���� ]</td>
	</tr>
	<tr>
		<td>
		<font color=red>&nbsp;&nbsp;�� 'ü���� �˻�'���� ���ڸ޽����� ������ ü���� �˻�<br>
		&nbsp;&nbsp;�� '�˻����'���� '��ü' �Ǵ� '�Ϻ�'�� ������ ��, [>>]�� �߰�(�ݺ�����)<br>
		&nbsp;&nbsp;�� [���ں�����]�� SMS ����(30��/�� �ΰ�)</font>
		</td>
	</tr>
</table>

<table border="1" cellspacing="0" cellpadding="2" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">

<form action="SendSMS.asp" method="POST" name="form">
	<tr>
		<td nowrap width="85" bgcolor="#F7F7FF" height="25"> &nbsp;<B>ü���� �˻�<BR> </td>
		<td nowrap bgcolor="#FFFFFF" height="25">
			<select name="searcha" size="1" class="box_work">
          		<option value="a" <%if searcha = "a" then%>selected<%end if%>>��ü
          		<option value="y" <%if searcha = "y" then%>selected<%end if%>>�ֹ���
				<option value="4" <%if searcha = "4" then%>selected<%end if%>>���1(�ֹ�)
				<option value="5" <%if searcha = "5" then%>selected<%end if%>>���2(�ֹ�)
				<option value="1" <%if searcha = "1" then%>selected<%end if%>>�̼���(����)
				<option value="2" <%if searcha = "2" then%>selected<%end if%>>���(����)
				<option value="3" <%if searcha = "3" then%>selected<%end if%>>�޾�(����)
				<option value="6" <%if searcha = "6" then%>selected<%end if%>>�����ʰ�
        	</select>
			<select name="searchb" size="1" class="box_work">
          			<option value="a" <%if searchb = "a" then%>selected<%end if%>>����(��)��ü</option>
				<%if jisaarrayint <> "" then%>
					<%for i=0 to jisaarrayint%>
		          		<option value="<%=jisaarray(0,i)%>" <%if searchb=cstr(jisaarray(0,i)) then%>selected<%end if%>><%=jisaarray(1,i)%>
					<%next%>
				<%end if%>
        	</select>
			<select name="searchc" size="1" class="box_work">
        	  		<option value="a">�귣����ü</option>
				<%if brand_arraynum<>"" then%>
					<%for i=0 to brand_arraynum%>
		        	  	<option value="<%=brand_array(0,i)%>" <%if searchc = cstr(brand_array(0,i)) then%>selected<%end if%>><%=brand_array(1,i)%></option>
					<%next%>
				<%end if%>
	        </select>
			<select name="searchd" size="1" class="box_work">
				<option value="a" <%if searchd="a" then%>selected<%end if%>>�˻����� ����
	          	<option value="chaincode" <%if searchd="chaincode" then%>selected<%end if%>>ü�����ڵ�
	          	<option value="chainname" <%if searchd="chainname" then%>selected<%end if%>>ü������
        	</select>
			<input type="Text" name="searche" size="20" maxlength="20" class="box_work" value="<%=searche%>">
	        <input type="button" name="�� ��" value="�� �� "  class="box_work" onclick="javascript:sendSMSSearch(this.form);">
	        <input type="button" name="�ʱ�ȭ" value="�ʱ�ȭ" class="box_work" onclick="javascript:frmzerocheck(this.form,'SendSMS.asp');">
		</td>
	</tr>
	<input name="CallNumber" type=hidden>
</form>
</table>

<table border="1" cellspacing="0" cellpadding="1" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="100%">
<form name="formmessage" action="SendSMSok.asp" method="POST">
	<tr>
		<td nowrap width="81" bgcolor="#F7F7FF" height="25" rowspan="2"> &nbsp;<B>�޽��� �Է�<BR> </td>
		<td nowrap bgcolor="#FFFFFF" height="25" align=right>
		<input type="Text" name="searche" size="80" maxlength="80" class="box_work" value="<%=searchf%>" onKeyup="javascript:maxLengthCheck('80', null, this, byteprint);">

		<input type="button" name="�� ��" value="�� �� "  class="box_work" onclick="window.open('sms_formList.asp','','top=100,left=100,width=760,height=360'); return false;"  >
	        <input type="button" name="�ʱ�ȭ" value="�ʱ�ȭ" class="box_work" onclick="javascript:messageclear(this.form);">
			</td>
	</tr>
	<tr align=left>
		<td>
		<span style="color:blue">[ü������]</span><SPAN style="WIDTH: 43em;color:red;">���� �Է��ϸ� ü���� ������ ��ϵ� "ü������"���� �ڵ�����</span>	    
			<input type="Text" name="byteprint" size="10" maxlength="80" class="box_work" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" readonly="true" value="0/80 Byte">	    
		</td>
	</tr>
		<input name="SendNumber" type=hidden>
	</form>
</table>

			<table border="0" cellspacing="1" cellpadding="1" width=100%>
				<form name="PrintArea">
				<tr valign="bottom" height=10>
					<td width="330"><b>[�˻����]</b><br></td>
					<td></td>
					<td width="230"><b>[������ ü����]</b><br></td>
				</tr>
				<tr height=20>
					<td >* ��ü <B><%=rslist.recordcount%></b>���� ����Ÿ�� �ֽ��ϴ�.</td>
					<td width=40 rowspan=2></td>
					<td>* ������ <B><span id="countArea"><%=rs.recordcount%></span></b>���� ����Ÿ�� �ֽ��ϴ�.<br></td>

					<td align=right><input type="button" name="���� ������" value="���� ������" class="box_work" onclick="javascript:sendSMS();"></td>
				</tr>
				<tr>

				</form>
				</tr>
				<tr>
					<td >
						<div id="tempdiv" style="overflow:auto; height:705px;overflow-y:scroll;width:100%">
							<form name="searchitems">
							<table border="0" cellspacing="1" cellpadding="1" width=100%  bgcolor=#BDCBE7 id="searchlist">
								<tr height=28 bgcolor="#F7F7FF" align="center">
									<td width=24><input type="checkbox"  name="searchChk" onclick="javascript:CheckAll('searchlist');"/></td>
									<td width=35>�ڵ�</td>
									<td width=150>ü������</td>
									<td width=96>�ڵ�����ȣ</td>
								</tr>

								<%do until rslist.EOF %>
								<tr  bgcolor=#FFFFFF>
									<td align=center><INPUT type="checkbox" name="chk"/></td>
									<td align=center><%=rslist("tcode")%></td>
									<td><%=rslist("comname")%></td>
									<td align=center><%=rslist("hp")%></td>
								</tr>
								<% rslist.MoveNext 
								Loop %>
								</form>
							</table>
						</div>
					</td>
					<td align="center" valign="top"><input type="button" name="add" value=">>"  class="box_work" onclick="javascript:addRow('searchlist');"><br>�߰�<br><input type="button" name="del" value="<<"  class="box_work" onclick="javascript:deleteRow('sendlist');"><br>����
					</td>
					<td  valign="top" colspan=2>
					<!-- -->
						<div id="tempdiv" style="overflow:auto; height:705px; overflow-y:scroll">
						<form name="senditems">
						<table border="0" cellspacing="1" cellpadding="1" width=100% bgcolor=#BDCBE7 id="sendlist">
							<tr height=28 bgcolor=#F7F7FF align=center>
								<td width=24 align=center><input type="checkbox" name="sendChk" onclick="javascript:CheckAll('sendlist');"/></td>
								<td width=35 align=center>�ڵ�</td>
								<td width=150>ü������</td>
								<td width=96>�ڵ�����ȣ</td>
							</tr>
							<%do until rs.EOF %>
							<tr bgcolor=#FFFFFF>
								<td align=center><INPUT type="checkbox" name="chk"/></td>
								<td align=center><%=rs("tcode")%></td>
								<td><%=rs("comname")%></td>
								<td align=center><%=rs("hp")%></td>
							</tr>
								<% rs.MoveNext 
								Loop %>
							</form>
						</table>
						</div>
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
if imsierrcnt>0 then
	rslist.close
	set rs=nothing
	set rslist=nothing
end if
	db.close
	set db=nothing
%>

<!--#include virtual="/adminpage/incfile/bottom.asp"-->