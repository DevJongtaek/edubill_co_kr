<!--#include virtual="/moa_loan/Inc_Files/sessionend.asp"-->
<!--#include virtual="/moa_loan/db/db.asp"-->

<html>
<head>
<link rel="stylesheet" href="http://220.73.136.50:8080/css/dog.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type='text/javascript' src='Inc_Files/Scripts/Common_Script.js'></script>
	<script type='text/javascript' src='Inc_Files/Scripts/javascript_data.js'></script>
<title>아이디수정</title>
<%

'searcha = request("searcha")
'	searchb = request("searchb")
	searchc = request("searchc")
'	searchd = request("searchd")
'	searche = request("searche")
	searchf = request("searchf")
'	searchg = request("searchg")
'	searchh = request("searchh")
'	hgubun = request("hgubun")
'	sWritedate = request("sWritedate")
	
	seq = request("seq")
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
	SQL = sql & " where Div = 'Gubun'  "
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

	'if searchd="" then
	'	searchd = replace(left(now(),10),"-","")
	'end if
	

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select  a.idx, a.Gubun,b.Name as GubunName, a.Bank,c.Name as BankName , a.Area, a.Branch, a.userid, a.userpwd, a.filename,convert(varchar(10),a.WriteDate,111) as WriteDate, d.Name as AreaName, e.Name as BranchName, a.writeyn "
	SQL = sql & " from tb_LoanUser a left join StaticOptions b  on a.Gubun = b.value and b.Div = 'Gubun'"
    SQL = sql & " left join StaticOptions c on a.Bank = c.value and c.Div='Bank' "
    SQL = sql & " left join tb_area d on a.Area = d.Idx "
    SQL = sql & " left join tb_Branch e on a.Area = e.AreaIdx and a.Branch = e.idx"
    SQL = sql& " where a.idx = " & seq
    
   '  response.Write SQL
    rs.Open sql, db, 1
   
	  idx = rs(0)
	  Gubun = rs(1)
    GubunName = rs(2)
    LoanBank = rs(3)
	BankName = rs(4)
	Area = rs(5)
	Branch = rs(6)
	userid = rs(7)
	userpwd = rs(8)
    filename = rs(9)
	writedate = rs(10)
	AreaName = rs(11)
	BranchName = rs(12)
	writeyn = rs(13)
	
	
'response.write rs(3)
    rs.close

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
    
  function delcheck(form) {
	var msg;
	msg=confirm("정말 삭제하겠습니까?");
	if(msg) {
		form.dflag.value="1"
		form.action = "IdDelOk.asp";
		form.submit() ;
		return false ;
	  }
  }
  
  function bkindwrite(frm) {
	form.dflag.value="0"
	form.action = "IdUpdateOk.asp";
	frm.submit() ;
}

  
       
   
    
     

</script>
    </head>
<body onload="winResize()">
<table width="360" border="0" cellspacing="1" cellpadding="0" bgcolor="#ffffff">
	
	
	<tr>
		<td>
		<form name = "form" method=post>
			<table border="0" cellspacing="1" cellpadding="1" width=360 bgcolor=#BDCBE7 id="Table1">
					
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>구분</td>

                       
						<td bgcolor=#FFFFFF>
						         

 <select name="searcha" size="1" class="box_work" disabled=true onChange ="fGubun();">
				           <option value="0">구분</option>
	          			<%if hgubunarrayint<>"" then%>
						<%for i=0 to hgubunarrayint%>
		        	  			<option value="<%=hgubunarray(0,i)%>" <% if hgubunarray(0,i)=Gubun then%>selected<%end if%>>
		        	  			<%=hgubunarray(1,i)%>
						<%next%>
					<%end if%>
					           
                          
        		            </select>
                         
                            
                            </td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>금융기관명&nbsp;</td>
						<td bgcolor=#FFFFFF>
						  
    						<%if GubunName = "지사" then%>
    						    
    						    <select name="searchg" size="1" disabled=true class="box_work">
    				      				  <option value="0">금융기관</option>
    	          			 <%if hcararrayint<>"" then%>
	          			
					           <%for i=0 to hcararrayint%>
        		        	  	<option value="<%=hcararray(0,i)%>" <% if hcararray(0,i)=LoanOrg then%>selected<%end if%>>
        		        	  	<%=hcararray(1,i)%>
    						      <%next%>     
				            <%end if%>
    					        </select>
    					  <%else%>
    				       <select name="searchg" size="1" disabled=true class="box_work">
				            <%if hcararrayint<>"" then%>
	          			 <option value="0">금융기관</option>
					           <%for i=0 to hcararrayint%>
		        	  	<option value="<%=hcararray(0,i)%>" <%if hcararray(0,i)=LoanBank then%>selected<%end if%>>
		        	  	<%=hcararray(1,i)%>
						      <%next%>
				          
				            <%end if%>
        		            </select>
    				    <%end if%>   
    					      &nbsp;
    						  <input type="button" name="추가" value="추가 " class="box_work" onclick="window.open('StaticOptionsAdd.asp','Staticiotion','top=100,left=100,width=385,height=200'); return false" >
						</td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>지역&nbsp;</td>
						<td bgcolor=#FFFFFF>
						<!--#include virtual="/moa_loan/Inc_Files/kind2.asp"-->
						<%if GubunName = "지사" then%>
              			<select name="searchc" size="1" class="box_work" disabled=true  onChange="Select_cate(this.form2,'');">
              	          			<option value="0">지역</option>
              					<%if barrayint<>"" then%>
              						<%for i=0 to barrayint%>
        		        	  			<option value="<%=barray(0,i)%>" >
        		        	  			
        		        	  			<%=barray(1,i)%>
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
                            		
        		<%else%>
        		    <select name="searchc" size="1" class="box_work" disabled=true onChange="Select_cate(this.form2,'');">
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
              						<td bgcolor=#FFFFFF>
              						<select name=searchf disabled=true  class="f">
                              		<option value=0>소속지사</option>
                            		</select>
                            		<script language="JavaScript">set_menu();</script>
        		<%end if%>
            
			
			
			&nbsp;<input type="button" name="추가" value="추가 " class="box_work" onclick="window.open('StaticOptionsAdd1.asp','Staticiotion1','top=100,left=100,width=385,height=200'); return false" >
			</td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>아이디&nbsp;</td>
						<td bgcolor=#FFFFFF><input type='text' name='userid' value="<%=userid%>" style='width:100px;' disabled=true></td>
					</tr>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>비밀번호&nbsp;</td>
						<td bgcolor=#FFFFFF><input type='text' name='userpwd' style='width:100px;'  value="<%=userpwd%>"></td>
					</tr>
					<%if GubunName = "관리자" then%>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>권한&nbsp;</td>
						<td bgcolor=#FFFFFF>
						<%if session("Awriteyn") = 1 then%>
						<input type="checkbox" name="writeyn" <%if writeyn <> "0" then%>checked<%end if%>> 쓰기
						<%else%>
						<input type="checkbox" name="writeyn" disabled=true <%if writeyn <> "0" then%>checked<%end if%>> 쓰기
						<%end if%>
						</td>
					</tr>
					<%else%>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>권한&nbsp;</td>
						<td bgcolor=#FFFFFF><input type="checkbox" name="writeyn" disabled=true> 쓰기</td>
					</tr>
					<%end if%>
					<tr height=28>
						<td width="110" align=right bgcolor=#F7F7FF>등록일자&nbsp;</td>
						<td bgcolor=#FFFFFF><input type="Text" name="searchd" size="8" maxlength="8" value="<%=writedate%>" OnKeypress="onlyNumber();" disabled=true></td>
					</tr>
					<tr  bgcolor=#FFFFFF>
						<td align="center" colspan=2>
						<input type="image" img src="/images/admin/l_bu04.gif" border=0 onclick="return delcheck(this.form);" align=absmiddle >&nbsp;
						<input type ="image" img src="/images/admin/l_bu03.gif" border=0  onclick="return bkindwrite(this.form);" align=absmiddle>&nbsp;
						<input type="image" src="/images/admin/l_bu02.gif" border=0  onclick="javascript:window.close();" align=absmiddle>
						<input type=hidden name=dflag></td>
					</tr>
					<input name="Seq" type=hidden value="<%=seq%>">
					</form>
				</table>
		</td>
	</tr>
</table>
</body>