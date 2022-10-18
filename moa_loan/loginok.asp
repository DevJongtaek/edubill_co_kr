<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include virtual="/moa_loan/db/db.asp" -->

<%
	imsi_userid = request("mid")
	imsi_userpwd = request("mpwd")
    imsi_Gubun = request("r_gubun")
    


	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select a.idx, a.Gubun, a.Bank, a.Area, a.Branch, a.userid, a.userpwd, a.filename, a.WriteDate,b.Name,c.Name,d.Name,e.Name,writeyn from tb_LoanUser a  "
    SQL = sql+ " left join StaticOptions b on a.gubun = b.value and b.Div = 'Gubun' "
    SQL = sql + " left join StaticOptions c on a.bank = c.value and c.Div = 'Bank'"
     SQL = sql + " left join tb_Area d on a.Area = d.Idx "
     SQL = sql + " left join tb_Branch e on a.Branch = e.Idx and e.AreaIdx = a.Area"
    SQL =sql+" where userid = '"&imsi_userid&"' and userpwd = '"&imsi_userpwd&"'  "
    SQL = sql + " and a.gubun = '"&imsi_Gubun&"'"
   
	'response.Write SQL
    rs.Open sql, db, 1
 
   
	if not rs.eof then
		imsinum = 1
		gubun = rs(1)
		bank = rs(2)
		area = rs(3)
		branch = rs(4)
		userid = rs(5)
    userpwd = rs(6)
    usergubun = rs(9)
    bankname = rs(10)
    Areaname = rs(11)
    Branchname = rs(12)
    writeyn=rs(13)
	else
		imsinum = 0
	end if
	rs.close

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "select filename from tb_LoanUser where userid = '"& userid &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		filename = rs(0)
	end if
	rs.close

	


  '  if session("Ausergubun")="3" and (LCase(session("Auserid"))="root" or LCase(session("Auserid"))="Root" )then
	'					
						
	'					  response.write "<Script language=javascript>"
	'				response.write "	alert("" "&session("AName")&"("&session("Auserid")&")님 안녕하세요!"");"
	'				response.write "	location.href = ""list.asp"";"
	'				response.write "</Script>"
					
					
						'response.redirect "/moa_loan/list.asp"
						'response.end
   ' else
      if imsinum = 0 then
      response.write "<Script language=javascript>"
  		response.write "	alert(""아이디 또는 비밀번호가 틀립니다.\n다시 입력하여 주시기 바랍니다."");"
  		response.write "	history.go(-1);"
  		response.write "</Script>"

      else
      
          session("Auserid") = imsi_userid '아이디
          session("Auserpwd") = imsi_userpwd	'비밀번호
  	      'session("Ausername") = username		'이름
          session("Ausergubun")   = gubun
          session("Ausergubunname") = usergubun
          session("Afilename")    = filename
          session("Aarea")   = area
          session("Abranch")   = branch
          session("Abank")   = bank
          
          
          
          if gubun = "1" then
          session("Aname") = bankname
          session("Areaname") = ""
          
          elseif gubun="2" then
          session("Areaname") = Areaname
           session("Aname") = Branchname
          else
           session("Aname") = "관리자"
           session("Awriteyn") = writeyn
           session("Areaname") = ""
          end if
          
          if session("Ausergubun") = 2 then
             response.write "<Script language=javascript>"
  					response.write "	alert("" "& session("Areaname") &" "&session("AName")&"("&session("Auserid")&")님 안녕하세요!"");"
  					response.write "	location.href = ""list.asp"";"
  					response.write "</Script>"
          
          else 
          
           response.write "<Script language=javascript>"
					response.write "	alert("" "&session("AName")&"("&session("Auserid")&")님 안녕하세요!"");"
					response.write "	location.href = ""list.asp"";"
					response.write "</Script>"
					
					end if
					
      end if
    
              
'					end if
   
    
%>
