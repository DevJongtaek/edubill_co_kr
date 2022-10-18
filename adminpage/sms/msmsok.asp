<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp" -->
 <meta http-equiv="Content-Type" content="text-html; charset=utf-8" />
<%
	searcha = request("searcha") '구분
  searche =    request("searche")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select * from NewSMS"
	
	'response.write SQL & "<br>"
  
    rs.Open sql, db, 1
	if not rs.eof then
		smsList = rs.GetRows
		smsListCount = ubound(smsList,2)
	else
		smsList = ""
		smsListCount = ""
	end if
	rs.close
    	imsitel = session("AAtel")
    sendcount = 0
    errcount = 0
'response.write left(smsList(0, 2),3)
	For i = 0  To smsListCount

  
    if left(smsList(0, i),3)  = "010" or left(smsList(0, i),3)  = "011" or left(smsList(0, i),3)  = "016" or left(smsList(0, i),3)  = "017" or left(smsList(0, i),3)  = "018" or left(smsList(0, i),3)  = "019"  then
	QSql = "INSERT INTO [dbo].[em_tran] ([tran_phone], [tran_callback], [tran_status], [tran_date], [tran_msg], [tran_etc2],[tran_etc3],[tran_etc4]) "
    QSql = QSql & " VALUES('" & smsList(0, i) & "', '"& imsitel &"', '1', getdate(), '" & searche & "', '2201', '0000 ', '13' ) "

    sendcount = sendcount+1
    db.Execute(QSql)
    else
    QSql = ""
    errcount  = errcount + 1
    
    end if
	
	
  
	'response.write QSql
	Next 
	'response.write QSql
	db.Close
	Set db = Nothing
	
%>

	<Script language=javascript>
	    alert("<%=sendcount%>" +"건 정상적으로 전송되었습니다");
	    this.close();
	</Script>