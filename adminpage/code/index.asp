<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<html>
<head>
<title>관리자 영역</title>
</head>
  <frameset cols="130,*" rows="*" border=0 framespacing="0" frameborder="NO"> 
    <frame name=left src="left.asp" noresize scrolling="auto" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 border=0>

<%if session("Ausercode")="000000000000000" then%>
    <frame name=smain src="list.asp?flag=1" noresize topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 border=0>
<%else%>
    <frame name=smain src="plist.asp" noresize topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 border=0>
<%end if%>

  </frameset>
</frameset>
<noframes> 
</noframes> 
</html>
