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
	
	
    set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select Value,Name "
	SQL = sql & " from StaticOptions "
	SQL = sql & " where Div = 'Bank' "
	SQL = sql & " order by Seq asc"
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
	SQL = " select Value,Name "
	SQL = sql & " from StaticOptions "
	SQL = sql & " where Div = 'Gubun' and Name !='관리자' "
	SQL = sql & " order by Seq asc"
	rs.Open sql, db, 1
	if not rs.eof then
		hgubunarray = rs.GetRows
		hgubunarrayint = ubound(hgubunarray,2)
	else
		hgubunarray = ""
		hgubunarrayint = ""
	end if
	rs.close

	if searchd="" then
		searchd = replace(left(now(),10),"-","")
	end if

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
    
    function fGubun(){
    
       if(form.searcha.options[form.searcha.selectedIndex].value == "1")
       {
           
           
           form.searchc.disabled=true;
           form.searchf.disabled=true;
           form.searchg.disabled=false;
       }
       else if(form.searcha.options[form.searcha.selectedIndex].value == "2")
       {
            form.searchg.disabled=true;
            form.searchc.disabled=false;
           form.searchf.disabled=false;
          
       }
      else 
       {
            form.searchg.disabled=true;
            form.searchc.disabled=true;
           form.searchf.disabled=true;
          
       }
       
       
   
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
						
						<td bgcolor=#FFFFFF align="center" colspan="2"><font style="font-weight: bold">추가하실 금융 기관명을 입력하십시오.</font></td>
					</tr>
					<tr height=28>
						
						<td bgcolor=#FFFFFF align="center" colspan="2"><input type='text' name='Name' style='width:200px;'></td>
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