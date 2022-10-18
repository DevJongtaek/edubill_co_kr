<%
if session("sessionid") = "" or isnull(session("sessionid")) = true then
	response.redirect("check.html")
end if
%>
<%
officenum = session("sessionid")
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html">
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<title>개인 만들기</title>
<SCRIPT LANGUAGE="JavaScript" SRC="formValid.js"></SCRIPT>
<script language="javascript">
<!--
function valid(form)
{
	var nRight = form.elements['sel_group[]'].length;
	var nCur = 0;
	for (i = 0; i < nRight; i++)
	{
		form.elements['sel_group[]'].options[nCur].selected = true ;
	}
	
	
	for (i=0; i < form.elements['sel_group[]'].length; i++) 
		form.elements['sel_group[]'].options[i].selected = true;		
	return true;
}

function to_right(form)
{
	var i;
	var isthere = 0;
	
	for(i = 0; i < form.total_group.length; i++){
		if (form.total_group.options[i].selected) {
			isthere = 1;
			if (!findInSelect(form.elements['sel_group[]'], 
form.total_group.options[i].value)) {
				myOption = new Option(form.total_group.options[i].text, 
form.total_group.options[i].value);
				form.elements['sel_group[]'][form.elements['sel_group[]'].length] = 
myOption;
			}
		}
	}
	
	if (isthere == 0) 
		alert("왼편목록에서 하나이상 선택하셔야 합니다");
}

function to_left(form){
	var i;
	var isthere = 0;
   
	var nRight = form.elements['sel_group[]'].length;
	var nCur = 0;
	for (i = 0; i < nRight; i++)
	{
		if (form.elements['sel_group[]'].options[nCur].selected) {
			isthere = 1;
			form.elements['sel_group[]'][nCur] = null;
		}
		else
			nCur++;
	}
	
	if (isthere == 0) 
		alert("왼편목록에서 하나이상 선택하셔야 합니다");
}

function findInSelect (sel, txt)
{
	var i;
	for (i = 0; i < sel.length; i++) {
		if (sel.options[i].value == txt)
			return true;
	}
	
	return false;
}

//-->
</script>
</head>

<body bgcolor="#FFFFFF">
<table border=0 cellpadding=0 cellspacing=0 width="300">
<tr>
<td align="center"><font face="굴림" size="3"><b>개인 만들기</b></font></td>
</tr>
</table><br>
<table border=0 cellpadding=0 cellspacing=0 width="350">
<tr>
<td><font face="굴림" size="2">주소록에 새로운 사람을 추가 할 수 있습니다 아래에 
추가하고 싶은 사람의 정보를 입력하신후, 
특정그룹에 포함하시고 싶으면 해당 그룹을 선택하여 주십시오.</font>
</td>
</tr>
</table>
<form action="addusr_exe.asp" method="post" onSubmit="return valid(this)">
  <table cellpadding=2 cellspacing=1 border="0" align="center" width="300">
    <tr>
      <td colspan="2" height="26">
      <font face="2" size="2"><b>구성원 정보입력</b></font>
      </td>
    </tr>
    <tr>
      <td bgcolor="#aa8c9b" align="center"><font face="굴림" size="2" color="#FFFFFF">이 름</font></td>
      <td>
      <input type="text" name="name" size="12" maxlength="16">
      <font size="2"><strong><font color="#FF0000">*</font></strong></font></td>
    </tr>
    	
    <tr>
      <td bgcolor="#aa8c9b" align="center"><font face="굴림" size="2" color="#FFFFFF">핸드폰</font></td>
      <td>
      	<input type=text name="pphone" size=20 maxlength="13">
    	</td>
    </tr>    
  </table>
  
  <table cellpadding=2 cellspacing=1 border="0" align="center" width="300">		
    <tr>
      <td colspan="3" height="26"><font face="굴림" size="2">
      <b>속할 그룹 선택</b></font>
      </td>
    </tr>  
	<tr>
	  <td bgcolor="#aa8c9b" width="130" align="center"><font face="굴림" size="2" color="#FFFFFF"><b>전체 그룹</b></font></td>
	  <td width="40"> </td>
	  <td bgcolor="#aa8c9b" width="130" align="center"><font face="굴림" size="2" color="#FFFFFF"><b>속한 그룹</b></font></td>
	</tr>
	<tr>
	  <td class="tblZero" align=center>
	  <select name="total_group" size=6 multiple onDblClick="to_right(this.form)">
<!-- #include file = "./DBConnect.inc"  -->	  
<%
officenum = session("sessionid")
sql = "select PK,groupName from em_addr_group where userId = '"&officenum&"'"
set rs = DBConn.Execute(sql)
%>
<% while not rs.eof %>
<option value="<%=rs("PK")%>"><%=rs("groupName")%></option>
<% 
rs.movenext 
wend
%>
	  </select>
	</td>
	<td align=center>
	
	<input type="button" name="toright" 
		value="&nbsp;&gt;&gt;&nbsp;" onClick="to_right(this.form)"> <br>
	    <input type="button" name="toleft" 
	    value="&nbsp;&lt;&lt;&nbsp;" onClick="to_left(this.form)">
	
		
	</td>
	<td class="tblZero" align=center>
		<select multiple name="sel_group[]" size="6"
		      	onDblClick="to_left(this.form)">	
		</select>
	</td>
	</tr>

    <tr>
      <td class="tblNoColor" colspan="3">
      <font face="굴림" size="2" color="#FF0000">*</font><font face="굴림" size="2">는 필히 기재</font>
      </td>
    </tr>
    <tr>
    <td align="center" colspan=3>
    	<input type="submit" value="확 인"> 
    	<input type="reset" value="취 소">
    	<input type="button" value="창닫기" onClick="window.close();">
    </td>
	</tr>
  </table>
<INPUT TYPE=HIDDEN NAME="submitted" VALUE="hi">  
</form>
</body>
</html>



