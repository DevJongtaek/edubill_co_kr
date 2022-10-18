<% str = "20110101"

	today = Left(str, 4) & "-" & Mid(str, 5, 2) & "-" & Mid(str, 7, 2)
	jjjj = FormatDateTime(Time, 9)



	response.write jjjj
%>