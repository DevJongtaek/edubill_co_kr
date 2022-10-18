<%
'컬럼 구분 : chr(9)
'로우 구분 : chr(13) & chr(10)

'Sql만 받아온다..
    '타이틀
	arrTitle = split(xlsHeader, "|") 
	for i=0 to ubound(arrTitle)
	    response.write arrTitle(i) & chr(9)
	next
	Response.Write chr(13) & chr(10)
    '내용
    	Do Until rs1.EOF
    		For i = 0 to rs1.Fields.Count-1 step 1
        		Response.Write rs1(i).Value & chr(9)
    		Next
        	Response.Write chr(13) & chr(10)
    		rs1.MoveNext
    	Loop

Response.Buffer = True
Response.Expires = 0
Response.ContentType  = "application/x-msexcel"
Response.CacheControl  = "public"
Response.AddHeader  "Content-Disposition" , "attachment; filename=" & xlsFileName
%>
