<!-- #include file = "Board.Default.asp" -->
<%
	DIM msgCode, REQ_prevAct, REQ_intCommentPage

	msgCode            = REQUEST.QueryString("msgCode")
	REQ_prevAct        = GetInputReplce(REQUEST.QueryString("prevAct"), "")
	REQ_intCommentPage = GetInputReplce(REQUEST.QueryString("comment_page"), "")

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>