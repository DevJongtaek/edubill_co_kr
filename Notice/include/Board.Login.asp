<!-- #include file = "Board.Default.asp" -->
<%
	DIM prevAct, nextAct, intCommentSeq, intCommentPage

	prevAct        = GetInputReplce(REQUEST.QueryString("prevAct"), "")
	nextAct        = GetInputReplce(REQUEST.QueryString("nextAct"), "")
	intCommentSeq  = GetInputReplce(REQUEST.QueryString("comment_seq"), "")
	intCommentPage = GetInputReplce(REQUEST.QueryString("comment_page"), "")

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<form id="loginForm" name="loginForm" method="post">
<input type="hidden" id="prevAct" value="<%=prevAct%>" />
<input type="hidden" id="nextAct" value="<%=nextAct%>" />
<input type="hidden" id="comment_seq" value="<%=intCommentSeq%>" />
<input type="hidden" id="comment_page" value="<%=intCommentPage%>" />
<input type="hidden" id="strLoginID" name="strLoginID" />
<input type="hidden" id="strPassword" name="strPassword" />
</form>