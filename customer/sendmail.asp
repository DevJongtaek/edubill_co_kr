<%
 sendname = request("sName")
 sendphone = request("sPhone")
 email = request("email")
 title = request("title")
 content = request("content")
 admin = "lemondoly@naver.com"

content = Replace(content, vblf, "<br/>")
content = "������ ��� : " & sendname & "<br/>" & "��ȭ��ȣ : " & sendphone & "<br/>" & content  
response.write content

Set MyCDONTSMail = CreateObject("CDONTS.NewMail")
    MyCDONTSMail.From= email
    MyCDONTSMail.To= admin
    MyCDONTSMail.Subject= title
    MyBody = content
    MyCDONTSMail.Body= MyBody
    MyCDONTSMail.Send
set MyCDONTSMail=Nothing
    
response.redirect "customer04_01.asp"
%>
