<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<%
	if session("Ausergubun")="1" then
		imsiurl = "/adminpage/code/list.asp?flag=1"
	elseif session("Ausergubun")="2" then
		imsiurl = "/adminpage/order/list.asp?imsiflag="&request("imsiflag")&""
	elseif session("Ausergubun")="3" then
		imsiurl = "/adminpage/order/list.asp?gongi=1"
	end if
%>


<html>
<head>
<title>관리자 영역</title>
    <meta http-equiv="content-type" content="text/html; charset=euc-kr">
</head>
<frameset rows="0,*" cols="*" border=0 framespacing="0" frameborder="NO"> 
    <frame name=top src="blank.asp" noresize scrolling="no" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0>
    <frame name=main src="<%=imsiurl%>" noresize topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 border=0>
</frameset>
</html>
