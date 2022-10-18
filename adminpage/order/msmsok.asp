<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp" -->
 <meta http-equiv="Content-Type" content="text-html; charset=utf-8" />
<%
	searcha = request("searcha") '구분
  searche =    request("searche")

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = " select tcode, comname, hp1 + hp2 + hp3 hp from tb_company"
	SQL = SQL & " where bidxsub = '"& left(session("Ausercode"),5) &"' "
	SQL = SQL & " AND flag= '3'"
	SQL = SQL & " AND tcode in (" & searcha &")"
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
   ' bonsaTel  = "02-853-5111"
	else
		bonsaCode = ""
		bonsaTel  = ""
	end If
	rs.close

	For i = 0  To smsListCount
	QSql = "INSERT INTO [dbo].[em_tran] ([tran_phone], [tran_callback], [tran_status], [tran_date], [tran_msg], [tran_etc2],[tran_etc3],[tran_etc4]) "
    QSql = QSql & " VALUES('" & smsList(2, i) & "', '"& bonsaTel &"', '1', getdate(), '" & searche & "', '"& bonsaCode &"', '"& smsList(0, i) &"', '13' ) "

	
	db.Execute(QSql)
	'response.write QSql
	Next 
	'response.write QSql
	db.Close
	Set db = Nothing
	
%>

	<Script language=javascript>
	    alert("정상적으로 전송되었습니다");
	    this.close();
	</Script>