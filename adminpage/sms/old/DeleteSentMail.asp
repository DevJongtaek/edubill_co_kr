<!-- #include file = "./DBConnect.inc"  -->
<%
	' �⺻ �۾� ����
	officenum = session("sessionid")
	
	page= Request.Form("page")
	lastpg= Request.Form("lastpg")
	startpage= Request.Form("startpage")
	ten= Request.Form("ten")
	cnt= Request.Form("cnt")

	yea=YEAR(NOW)
	mon=MONTH(NOW)
	if mon < 10 then
		mon= "0" & mon
	end if


	' �Ѿ� �� üũ�ڽ� �� �߿��� on �Ǿ� �ִ� ����� �����.
	chk=0
	For each whatever in Request.Form
		thisvalue=request.form(whatever)
		
		If thisvalue = "on" Then
			sql1="UPDATE em_log_" & yea & mon & " SET tran_etc3='##D#' WHERE tran_etc4= '" & whatever & "'"
			Set rs1=DBConn.Execute(sql1)
			'response.write sql1	
			chk=chk+1
		End If
	Next

	' ���� �������� ���ư�
	if page=1 then
		Response.Redirect "SentMailbox.asp"
	else
		if cint(cnt)=cint(chk) then
			if page=lastpg then
				if page=startpage then
					Response.Redirect "SentMailbox.asp?page=" & page-1 & "&startpage=" & startpage-ten
				else
					Response.Redirect "SentMailbox.asp?page=" & page-1 & "&startpage=" & startpage
				end if
			else
				Response.Redirect "SentMailbox.asp?page=" & page & "&startpage=" & startpage
			end if
		else
			Response.Redirect "SentMailbox.asp?page=" & page & "&startpage=" & startpage
		end if
	end if
%>
