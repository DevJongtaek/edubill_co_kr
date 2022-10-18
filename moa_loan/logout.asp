<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%

 response.write "<Script language=javascript>"
					response.write "	alert("" "&session("Areaname")&" "&session("AName")&"("&session("Auserid")&")님 로그아웃되었습니다.!"");"
					response.write "	location.href = ""index.asp"";"
					response.write "</Script>"
session("Auserid") = ""
session("Ausername") = ""
session("Ausercode") = ""
session("Ausergubun") = ""
session("Auserwrite") = ""
session("Afilename") = ""
session("Adcenteridx") = ""
session("Aproflag") = ""
session("Amiorderflag") = ""
session("AchoiceDcenter") = ""



					
					
' response.Redirect("index.asp")   
%>

