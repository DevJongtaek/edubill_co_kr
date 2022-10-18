<!-- #include file = "Board.Default.asp" -->
<%
	DIM strPrevAct, strNextAct, intCommentSeq, intCommentPage

	strPrevAct     = GetInputReplce(REQUEST.QueryString("prevAct"), "")
	strNextAct     = GetInputReplce(REQUEST.QueryString("nextAct"), "")
	intCommentSeq  = GetInputReplce(REQUEST.QueryString("comment_seq"), "")
	intCommentPage = GetInputReplce(REQUEST.QueryString("comment_page"), "")

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>
<form id="passwordForm" name="passwordForm">
<input type="hidden" id="prevAct" value="<%=strPrevAct%>" />
<input type="hidden" id="nextAct" value="<%=strNextAct%>" />
<input type="hidden" id="comment_seq" value="<%=intCommentSeq%>" />
<input type="hidden" id="comment_page" value="<%=intCommentPage%>" />
<input type="submit" class="none" />
</form>