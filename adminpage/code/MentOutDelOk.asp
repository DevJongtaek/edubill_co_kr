<!--#include virtual="/adminpage/incfile/sessionend.asp"-->
<!--#include virtual="/db/db.asp"-->
<%
	searcha = request("searcha") '구분 0: insert 1: delete
	searchb = request("searchb") 'idx
	searchc = request("searchc") 'tcode
	
	message = ""

	Select case searcha 
		Case "0"
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select COUNT(clientcode) from tb_MentOut "
			rs.Open sql, db, 1
			if not rs.eof then
				messageCount = rs(0)
			else
				messageCount = 0
			end if
			rs.close
				If messageCount > 21844 Then 
					searcha = ""
					message = "더 이상 추가할 수 없습니다."
				Else
					SQL = " insert into tb_MentOut (ClientCode, WriteDate)  "
					SQL = SQL & " values ('"& searchc & "', GETDATE())"
					db.Execute(SQL)

					tcode = ""
					set rs = server.CreateObject("ADODB.Recordset")
					SQL = " select clientcode from tb_mentout order by clientcode"
					rs.Open sql, db, 1	

					do until rs.EOF 
						tcode = tcode & rs("clientcode") & ", "
					rs.movenext
					Loop
					rs.close
					
					tcode = Mid(tcode, 1, Len(tcode) - 2)

					SQL = "update tb_adminuser set mentout = '" & tcode & "' where userid = 'root'"
					db.Execute(SQL)

					message="정상적으로 저장하였습니다."

				End If 
		Case "1"
			SQL = " delete tb_mentout where clientcode = '" & searchc & "'"
			db.Execute(SQL)
			
			tcode = ""
			set rs = server.CreateObject("ADODB.Recordset")
			SQL = " select clientcode from tb_mentout order by clientcode"
			rs.Open sql, db, 1	

			do until rs.EOF 
				tcode = tcode & rs("clientcode") & ", "
			rs.movenext
			Loop
			rs.close
			
			tcode = Mid(tcode, 1, Len(tcode) - 2)

			SQL = "update tb_adminuser set mentout = '" & tcode & "' where userid = 'root'"
			db.Execute(SQL)

			message ="정상적으로 삭제하였습니다."
	End Select 
	'response.write SQL
	db.Close
	Set db = Nothing
%>

	<Script language=javascript>
		alert('<%=message%>');
		location.href = "root.asp";
	</Script>