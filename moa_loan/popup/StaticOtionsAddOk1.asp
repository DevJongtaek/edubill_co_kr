<% @LANGUAGE='VBSCRIPT' CODEPAGE='65001' %> 
<% Response.Charset = "UTF-8" %>

<!--#include virtual="/moa_loan/db/db.asp"-->
<%
  
  loanArea  = replace(request("searchc"),"'","''") '지역
	SName  = replace(request("Name"),"'","''")
  'response.write SName

  set rscount = server.CreateObject("ADODB.Recordset")
	SQL = " select Max(Seq) " 
	SQL = sql & " from tb_Branch "
	SQL = sql & " where AreaIdx = "& loanArea &" "
	rscount.Open sql, db, 1
	if not rscount.eof then
		imsiSeq = rscount(0)
		
	end if
	rscount.close
	
	
	SQL = "insert into tb_Branch ( "
  SQL = SQL & " Name "
  SQL = SQL & " ,AreaIdx "
	SQL = SQL & "  ,Seq "
  SQL = SQL & ") VALUES ( "
  SQL = SQL & " '" & SName & "' "
  SQL = SQL & "  ,'" & loanArea & "' "
	SQL = SQL & "  ,'" & imsiSeq & "' )"


	db.Execute SQL 

	' response.write SQL
	db.close
	set db=Nothing

%>
<Script language=javascript>
	    alert("성공적으로 저장되었습니다");
	    window.opener.location.reload();
	    window.close();
	</Script>
	