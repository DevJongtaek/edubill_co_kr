<%
    file = request("f_name")  '//���� �̸�

    Response.ContentType = "application/unknown"
    Response.AddHeader "Content-Disposition","attachment; filename=" & file

    Set objStream = Server.CreateObject("ADODB.Stream")
    objStream.Open
    objStream.Type = 1
    objStream.LoadFromFile "D:/Webhosting/2004VIVA/edubill_co_kr/fileupdown/pos_error/" & file        '//��� �Դϴ�.

    download = objStream.Read
    Response.BinaryWrite download
    Set objstream = nothing
%>