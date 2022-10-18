<!--#include virtual="/db/db.asp"-->
<%
	virtual_acnt_bank = request("virtual_acnt_bank")
	bidxsub = request("idx")

	SQL = "update tb_company set "
	SQL = SQL & " virtual_acnt_bank = '"& virtual_acnt_bank &"' "
	SQL = SQL & " where bidxsub = "& bidxsub
	db.Execute SQL
	db.close

	msg = "해당 체인점의 은행명이 모두적용 되었습니다."
	response.write "<Script language=javascript>"
	response.write "	alert('" & msg & "');"
	response.write "	parent.window.close();"
	response.write "</Script>"
%>
