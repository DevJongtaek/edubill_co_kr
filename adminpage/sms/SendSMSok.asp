<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp" -->
<!--#include FILE="Sms_db.asp"-->
<%
	searcha = request("SendNumber") '구분
	searchb = request("searche") 'idx
	
	callNumber = ""
	'CallNumber , 삭제 
	If searcha <> "" Then 
		If Len(searcha) > 4 Then 
			clenth = Len(searcha) -3
			callNumber = Left(searcha, clenth)
		End  if 
	End If 

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode, comname, hp1 + hp2 + hp3 hp from tb_company"
	SQL = SQL & " where bidxsub = '"& left(session("Ausercode"),5) &"' "
	SQL = SQL & " AND flag= '3'"
	SQL = SQL & " AND tcode in ('" & callNumber &"')"
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

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode, tel1 + tel2 + tel3 from tb_company "
	SQL = sql & " where idx = '" & left(session("Ausercode"),5) &"' "
	rs.Open sql, db, 1
	if not rs.eof then
		bonsaCode = rs(0)
		bonsaTel  = rs(1)
	else
		bonsaCode = ""
		bonsaTel  = ""
	end If
	rs.close

	For i = 0  To smsListCount
	QSql = "INSERT INTO [dbo].[SC_TRAN] ([TR_SENDDATE], [TR_SENDSTAT], [TR_RSLTSTAT], [TR_MSGTYPE], [TR_PHONE], [TR_CALLBACK],[TR_MSG],[TR_ETC1],[TR_ETC2]) "
    QSql = QSql & " VALUES(getdate(), '0', '00', '0', '" & smsList(2, i) & "', '"& bonsaTel &"', '"& Replace(searchb, "[체인점명]", smsList(1, i)) &"', '"& bonsaCode &"', '"& smsList(0, i) &"' ) "

	'QSql = "insert into em_tran (  tran_refkey  ,tran_id  ,tran_phone  ,tran_callback  ,tran_status  ,tran_date  ,tran_rsltdate  ,tran_reportdate  ,tran_rslt  ,tran_net  ,tran_msg  ,tran_etc1  ,tran_etc2  ,tran_etc3  ,tran_etc4  ,tran_type)  "
	'QSql = QSql & "VALUES (  null  ,null  ,'" & smsList(2, i)&  "'  ,'" & bonsaTel &  "'  ,'1'  ,getdate()  ,null  ,null  ,null  ,null  ,'" &  Replace(searchb, "[체인점명]", smsList(1, i))  &  "'  ,null  ,'" & bonsaCode &  "'  ,'" & smsList(0, i)&  "'   ,0   ,0 )" 
	smsdb.Execute(QSql)
	'response.write QSql
	Next 
	'response.write QSql
	db.Close
	Set db = Nothing
%>

	<Script language=javascript>
		alert("정상적으로 전송되었습니다");
		location.href = "SendSMS.asp";
	</Script>