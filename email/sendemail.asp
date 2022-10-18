<%
Set MyCDONTSMail = CreateObject("CDONTS.NewMail")
    MyCDONTSMail.From= "somebody@nowhere.com"
    MyCDONTSMail.To= "lemondoly@naver.com"
    MyCDONTSMail.Subject="This is a Test"
    MyBody = "Thank you for ordering that stuff" & vbCrLf
    MyBody = MyBody & "We appreciate your business" & vbCrLf
    MyBody = MyBody & "Your stuff will arrive within 7 business days"
    MyCDONTSMail.Body= MyBody
    MyCDONTSMail.Send
    set MyCDONTSMail=nothing
response.write "send"
%>