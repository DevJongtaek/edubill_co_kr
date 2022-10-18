<!--#include virtual="/moa_loan/Inc_Files/sessionend.asp"-->
<!--#include virtual="/moa_loan/db/db.asp"-->

<html>
<head>
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type='text/javascript' src='Inc_Files/Scripts/Common_Script.js'></script>
<title>아이디추가</title>
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
	SQL = sql & " where Div = 'Gubun' "
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

function bIdwrite(frm) {

  if(frm.searcha.value == 0){
    alert("구분을 선택하여 주시기바랍니다.") ;
		frm.searcha.focus() ;
		return false ;
  }
  else if(form.searcha.value== 2 )
  {
    if(frm.searchc.value == 0){
      alert("지역을 선택하여 주시기바랍니다.") ;
  		frm.searchc.focus() ;
  		return false ;
    }
    else if(frm.searchf.value == 0){
      alert("소속지사 선택하여 주시기바랍니다.") ;
  		frm.searchf.focus() ;
  		return false ;
    }
    else if (frm.userid.value=="") {
		alert("아이디를 입력하여 주시기바랍니다.") ;
		frm.userid.focus() ;
		return false ;
	  }
	  else if (frm.userpwd.value=="") {
		alert("비밀번호 입력하여 주시기바랍니다.") ;
		frm.userpwd.focus() ;
		return false ;
	}
  }
	else if (frm.userid.value=="") {
		alert("아이디를 입력하여 주시기바랍니다.") ;
		frm.userid.focus() ;
		return false ;
	}
	else if (frm.userpwd.value=="") {
		alert("비밀번호 입력하여 주시기바랍니다.") ;
		frm.userpwd.focus() ;
		return false ;
	}
	frm.submit() ;
}


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
                      form.writeyn.disabled = true;
       }
       else if(form.searcha.options[form.searcha.selectedIndex].value == "2")
       {
            form.searchg.disabled=true;
            form.searchc.disabled=false;
           form.searchf.disabled=false;
                      form.writeyn.disabled = true;
          
       }
       else if(form.searcha.options[form.searcha.selectedIndex].value == "3")
       {
            form.searchg.disabled=true;
            form.searchc.disabled=true;
           form.searchf.disabled=true;
           form.writeyn.disabled = false;
          
       }
      else
       {
            form.searchg.disabled=true;
            form.searchc.disabled=true;
           form.searchf.disabled=true;
           form.writeyn.disabled = true;
          
       }
       
       
   
    }
    
    function idcheck(){
      id = form.userid.value;
       id = document.signform.user_id.value
	   window.open("IdCheck.asp?user_id=" +id , "idchk" , "toolbar=no,status=yes,width=400,height=300,resizeable=no,menubar=no")

    }
     

</script>
    </head>
<body onload="winResize()">
<table width="360" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	
	
	<tr>
		<td>
		<form name = "form" action="IdAddOk.asp" method=post>
			<table border="0" cellspacing="1" cellpadding="1" width=360 bgcolor=#BDCBE7 id="Table1">
					
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>구분</td>

                       
						<td bgcolor=#FFFFFF>
						         
                            <select name="searcha" size="1" class="box_work" onChange ="fGubun();">
				           <option value="0">구분</option>
	          			<%if hgubunarrayint<>"" then%>
						<%for i=0 to hgubunarrayint%>
		        	  			<option value="<%=hgubunarray(0,i)%>">
		        	  			<%=hgubunarray(1,i)%>
						<%next%>
					<%end if%>
					           
                          
        		            </select>
                         
                         
                            
                            </td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>금융기관명&nbsp;</td>
						<td bgcolor=#FFFFFF>
						    <select name="searchg" size="1" disabled=true class="box_work">
				           
	          			<%if hcararrayint<>"" then%>
						      <%for i=0 to hcararrayint%>
		        	  	<option value="<%=hcararray(0,i)%>">
		        	  	<%=hcararray(1,i)%>
						      <%next%>
					        <%end if%>
					        </select>
						&nbsp;<input type="button" name="추가" value="추가 " class="box_work" onclick="window.open('StaticOptionsAdd.asp','Staticiotion','top=100,left=100,width=385,height=200'); return false" >
						</td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>지역&nbsp;</td>
						<td bgcolor=#FFFFFF>
						<!--#include virtual="/moa_loan/Inc_Files/kind.asp"-->
			<select name="searchc" size="1" class="box_work" disabled=true  onChange="Select_cate(this.form2,'');">
	          			<option value="0">지역</option>
					<%if barrayint<>"" then%>
						<%for i=0 to barrayint%>
		        	  			<option value="<%=barray(0,i)%>"><%=barray(1,i)%>
						<%next%>
					<%end if%>
        		</select>
              		
						
						</td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>소속지사&nbsp;</td>
						<td bgcolor=#FFFFFF><select name=searchf disabled=true  class="f">
                		<option value=0>소속지사</option>
              		</select>
              		
			<script language="JavaScript">set_menu();</script>
			
			&nbsp;<input type="button" name="추가" value="추가 " class="box_work" onclick="window.open('StaticOptionsAdd1.asp','Staticiotion1','top=100,left=100,width=385,height=200'); return false" >
			</td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>아이디&nbsp;</td>
						<td bgcolor=#FFFFFF><input type='text' name='userid' style='width:100px;' readonly=true>&nbsp;<input type="button" name="아이디입력" value="아이디입력" class="box_work" onclick="window.open('IdCheck.asp','IdCheck','top=100,left=100,width=385,height=200'); return false" ></td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>비밀번호&nbsp;</td>
						<td bgcolor=#FFFFFF><input type='text' name='userpwd' style='width:100px;'></td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>권한&nbsp;</td>
						
						
						<td bgcolor=#FFFFFF><input type="checkbox" name="writeyn"  disabled=true> 쓰기</td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>등록일자&nbsp;</td>
						<td bgcolor=#FFFFFF><input type="Text" name="searchd" size="8" maxlength="8" value="<%=searchd%>" OnKeypress="onlyNumber();" ></td>
					</tr>
					<tr  bgcolor=#FFFFFF align=left valign="middle" colspan=2>
						<td align="center" colspan=2><input type="image" src="/images/admin/l_bu01.gif" border=0 onclick="return bIdwrite(this.form);" align=absmiddle>&nbsp;
						<input type="image" src="/images/admin/l_bu02.gif" border=0  onclick="javascript:window.close();" align=absmiddle></td>
					</tr>
					<input name="Seq" type=hidden value="<%=seq%>">
					</form>
				</table>
		</td>
	</tr>
</table>
</body>