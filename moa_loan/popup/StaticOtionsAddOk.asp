<% @LANGUAGE='VBSCRIPT' CODEPAGE='65001' %> 
<% Response.Charset = "UTF-8" %>

<!--#include virtual="/moa_loan/db/db.asp"-->
<%
  
    
   
  set rscount = server.CreateObject("ADODB.Recordset")
	SQL = " select Max(Seq)+1,Max(Value)+1"
	SQL = sql & " from StaticOptions "
	SQL = sql & " where Div = 'Bank' "
	rscount.Open sql, db, 1
	if not rscount.eof then
		imsiSeq = rscount(0)
		imsiValue = rscount(1)
	end if
	rscount.close
	
	
	SName  = replace(request("Name"),"'","''")

	SQL = "insert into StaticOptions ( "
	SQL = SQL & "  Div "
    SQL = SQL & " ,Name "
    SQL = SQL & " ,Seq "
	SQL = SQL & "  ,Value "

	SQL = SQL & ") VALUES ( "
	
    SQL = SQL & " 'Bank' "
    SQL = SQL & "  ,'" & SName & "' "
	SQL = SQL & "  ,'" & imsiSeq & "' "
	SQL = SQL & "  ,'" & imsiValue & "' )"


	db.Execute SQL 

	'response.write SQL
	db.close
	set db=Nothing
%>
<Script language=javascript>
	    alert("성공적으로 저장되었습니다");
	    window.opener.location.reload();
	    window.close();
	</Script>
	