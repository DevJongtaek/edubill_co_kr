<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<title>���� ����Ʈ</title>
<%

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select idx, sms_form from tb_sms_form "
	SQL = SQL & " where Client_Code = '"& left(session("Ausercode"),5) &"' "
	SQL = SQL & " order by idx"
	'response.write SQL & "<br>"
	rs.Open sql, db, 1
	if not rs.eof then
		smsList = rs.GetRows
		smsListCount = ubound(smsList,2)
	else
		smsList = ""
		smsListCount = ""
	end if
	rs.close
%>
<script language="JavaScript">
function insertform(search){
	form.action = "sms_formok.asp?searcha=0&searchc="+ search.value
	form.submit() ;
}

function deleteform(val){
	form.action = "sms_formok.asp?searcha=1&searchb=" + val
	form.submit() ;
}

function sendparent(messageform)
{
	opener.document.formmessage.searche.value = messageform;
	window.close();
}


function cyberNumchb()
{
	alert("<%=session("Ausername")%>��(��) �� ��û ȸ�����̹Ƿ� �� ���񽺸� �������� �ʽ��ϴ�.!!") ;
}

function maxLengthCheck(maxSize, lineSize, obj, remainObj)
{ 
	var temp;
	var f = obj.value.length;
	var msglen = parseInt(maxSize);
	var tmpstr = "";
	var enter = 0;
	var strlen;

	if (f == 0)//���� ���� byte �� ���� �ֱ�
	{  
		if (remainObj != null)//null �ɼ��� �ƴ� �� �� �����ش�.
		{
			remainObj.value = (80 - msglen) + "/80 Byte";
		}  
	}
	else
	{
		for(k = 0; k < f ; k++)
		{
			temp = obj.value.charAt(k);

			if(temp =="\n")
			{
			enter++;
			}
			if(escape(temp).length > 4)
				msglen -= 2;
			else
				msglen--;
	  
			if(msglen < 0)
			{
				alert("�� ���� "+(maxSize*2)+"�� �ѱ� "+maxSize+"�� ���� ���� �� �ֽ��ϴ�.");
				obj.value = tmpstr;
				break;
			}
			else if (lineSize != null & enter > parseInt(lineSize))// lineSize �ɼ��� nulldl �ƴ� ���� ���
			{
				alert("���μ� "+lineSize+"������ ���� �� �����ϴ�.")
				enter = 0;
				strlen = tmpstr.length -1;
				obj.value = tmpstr.substring(0, strlen);
				break;
			}
			else
			{
				if (remainObj != null)
				{
					remainObj.value = (80 - msglen) + "/80 Byte";
				}      
				tmpstr += temp;
			}
		}  
	}
} 

function winResize()
{
    var Dwidth = parseInt(document.body.scrollWidth);
    var Dheight = parseInt(document.body.scrollHeight);
    var divEl = document.createElement("div");
    divEl.style.position = "absolute";
    divEl.style.left = "0px";
    divEl.style.top = "0px";
    divEl.style.width = "100%";
    divEl.style.height = "100%";

    document.body.appendChild(divEl);

    window.resizeBy(Dwidth - divEl.offsetWidth - 30, Dheight - divEl.offsetHeight);
    document.body.removeChild(divEl);
}


</script>
<body onload="winResize()">
<table width="720" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
<FORM name="form" method="POST" action="sms_formok.asp">
	<tr height="47">
		<td align=center>
		<table border="0" cellspacing="1" cellpadding="1" width=720 bgcolor=#BDCBE7 id="searchlist">
			<tr height=28 bgcolor=#F7F7FF align=center>
				<td width="40">��ȣ</td>
				<td>���� ����</td>
				<td>���</td>
			</tr>
			<%If smsListCount <> "" then
			for i=0 to smsListCount %>
			<tr  bgcolor=#FFFFFF>
				<td align=center><%=i + 1%></td>
				<td><%=smsList(1,i)%></a></td>
				<td align="center" width=100><input type="button" name="del" value="����"  class="box_work"' onclick="javascript:sendparent('<%=smsList(1,i)%>');" >&nbsp;
				<input type="button" name="del" value="����"  class="box_work"' onclick="javascript:deleteform('<%=smsList(0,i)%>');"></td>
			</tr>
			<%Next
			End If %>
		</table>
		</td>
	</tr>
	<tr>
		<td height="5">
		</td>
	</tr>
	<tr>
		<td>
		<table border="1" cellspacing="0" cellpadding="1" bordercolorlight="#999966" bordercolordark="#FFFFFF" width="720">
		<form name="formmessage" action="SendSMSok.asp" method="POST">
			<tr>
				<td nowrap width="81" bgcolor="#F7F7FF" height="25" rowspan="2"> &nbsp;<B>�޽��� �Է�<BR> </td>
				<td nowrap bgcolor="#FFFFFF" height="25">
				<input type="Text" name="searcha" size="80" maxlength="80" class="box_work" value="<%=searchf%>" onKeyup="javascript:maxLengthCheck('80', null, this, byteprint);">

				<input type="button" name="insert" value="�� ��" class="box_work"' onclick="javascript:insertform(searcha);">
					</td>
			</tr>
			<tr align=left>
				<td>
				<span style="color:blue">[ü������]</span><SPAN style="WIDTH: 38em;color:red;">���� �Է��ϸ� ü���� ������ ��ϵ� "ü������"���� �ڵ�����</span>	    
					<input type="Text" name="byteprint" size="10" maxlength="80" class="box_work" style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" readonly="true" value="0/80 Byte">	    
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</body>
</html>
