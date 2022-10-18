<!--#include virtual="/moa_loan/Inc_Files/sessionend.asp"-->
<!--#include virtual="/moa_loan/db/db.asp"-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
	<script type='text/javascript' src='Inc_Files/Scripts/Common_Script.js'></script>
<title>금융기관 추가</title>
<%

searcha = request("searcha")
	searchb = request("searchb")
	searchc = request("searchc")
	searchd = request("searchd")
	searche = request("searche")
	searchf = request("searchf")
	searchg = request("searchg")
	searchh = request("searchh")
	hgubun = request("hgubun")
	sWritedate = request("sWritedate")
	
	
  

%>
<script language="JavaScript">

    function onlyNumber() {
        if ((event.keyCode < 48) || (event.keyCode > 57))
            event.returnValue = false;
    }

    function FloatNumber() {
        if ((event.keyCode < 46) || (event.keyCode > 57) && (event.keyCode = 47))
            event.returnValue = false;
    }

    function DateNumber() {
        if ((event.keyCode < 47) || (event.keyCode > 57))
            event.returnValue = false;
    }

</script>
    </head>
<body onload="winResize()">
<table width="360" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	
	
	<tr>
		<td>
		<form name = "form" action="StaticOtionsAddOk.asp" method=post>
			<table border="0" cellspacing="1" cellpadding="0" width=360  id="Table1">
					
				
					<tr height=28>
						
						<td bgcolor=#FFFFFF align="center" colspan="2"><font style="font-weight: bold">추가하실 소속 금융기관명을 입력하십시오.</font></td>
					</tr>
					<tr height=28>
						
						<td bgcolor=#FFFFFF align="center" colspan="2">
						  <!--#include virtual="/moa_loan/Inc_Files/kind.asp"-->
			      <input type='text' name='Name' style='width:200px;'>
						</td>
					</tr>
					
					<tr  bgcolor=#FFFFFF>
						<td align="center" colspan=2><input type="image" src="/images/admin/l_bu01.gif" border=0>&nbsp;
						<input type="image" src="/images/admin/l_bu02.gif" border=0  onclick="javascript:window.close();"></td>
					</tr>
					<input name="Seq" type=hidden value="<%=seq%>">
					</form>
				</table>
		</td>
	</tr>
</table>
</body>