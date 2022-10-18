<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include FILE="Sms_db.asp"--> 
<%
	searcha = request("searcha") '구분
	searchb = request("searchb") 'idx
	searchc = request("searchc") '문자 내용
	
	message = ""

	Select case searcha 
		Case "0"
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select count(idx) from tb_sms_form "
			SQL = SQL & " where Client_Code = '"& left(session("Ausercode"),5) &"' "
			rs.Open sql, db, 1
			if not rs.eof then
				messageCount = rs(0)
			else
				messageCount = ""
			end if
			rs.close
			If messageCount <> "" Then 
				If messageCount >= 10 Then 
					searcha = ""
					message = "미리 등록할 수 있는 메시지는 10개입니다."
				Else
					SQL = " insert into tb_sms_form ( Client_Code, Sms_Form ) "
					SQL = SQL & " VALUES ('"& left(session("Ausercode"),5) &"', '" & searchc & "')"
					message="정상적으로 저장하였습니다."
					db.Execute(SQL)
				End If 
			End If 
		Case "1"
			SQL = " delete tb_sms_form where idx = '" & searchb & "' and Client_Code = '"& left(session("Ausercode"),5) &"' "
			message ="정상적으로 삭제하였습니다."
			db.Execute(SQL)
		Case "2"
		Case "3"
	End Select 

	'response.write SQL
	db.Close
	Set db = Nothing
%>

	<Script language=javascript>
		alert('<%=message%>');
		location.href = "sms_formList.asp";
	</Script>