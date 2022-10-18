<!--#include virtual="/moa_loan/db/db.asp"-->
<html> 
<head> 
<title>아이디중복확인</title> 
<style type="text/css"> 
<!-- 
    BODY, table, tr, td, font,input, textarea, select 
    { 
        font-family: 굴림; 
        font-size: 9pt; 
    } 
--> 
</style> 
<script Language="JavaScript"> 
<!-- 
function confirm(idck) 
{ 
    var id = idck.id.value 
    opener.form.userid.value = id; 
    opener.form.userpwd.focus(); 
    self.close(); 
} 
//--> 
</script> 
</head> 

<body> 

<center> 
<font color=Green size=3>아이디 중복 검사</font> 
<form method='POST' action="IdCheck.asp"> 
<hr size=0 width=300> 
<input type=text name=id size=15 maxlength=10 style='border:solid 1;'> 
<!--<input type=submit name="중복확인" value="중복확인 "  alt='중복확인'> -->
<input type=image src= "/images/admin/member_01.gif" alt='중복확인' align=absmiddle>
<hr size=0 width=300> 
</form> 

<% 
Dim id 
id = Request.form("id") 
if(id = "") then 
    Response.Write "<font>원하시는 아이디(ID)를 입력하시오 <br>(영문과 숫자를 이용한 4자 이상 10자 이하)</font>" 
elseif(Len(id) < 4 or Len(id) > 15) then 
    Response.Write "<font>4자 이상의 아이디만 가능합니다.</font>" 
else 
  
    '중복아이디체크 
    set rs = server.CreateObject("ADODB.Recordset")
		SQL = " select count(*) from tb_LoanUser where userid = '" & id &"'"
		rs.Open sql, db, 1
		uid = rs(0)
		rs.close
    
    if uid = 0 then 
        Response.Write "입력하신 아이디 <font color=blue style='font-weight: bold'>" & id & "</font>은 사용가능합니다.<br>" & _ 
            "이 아이디를 사용하시겠습니까? <p>" &_ 
            "<form method='POST' name='check'>" & _ 
            "<input type=hidden name=id value='" & id & "'>" &_ 
            "<input type=image src='/images/admin/l_bu16.gif' BORDER=0 OnClick='confirm(document.check);' align=absmiddle>" & _ 
            "</form>" 
    else 
        Response.Write "입력하신 아이디 <font color=blue><b>" & _ 
            id & "</font></b>은(는) " & _ 
            "<font color=red>존재하는 아이디</font>입니다.<p>" & _ 
            "다른 아이디를 입력하세요" 
    end if 

end if 
%> 
</center> 
<body> 
</html>