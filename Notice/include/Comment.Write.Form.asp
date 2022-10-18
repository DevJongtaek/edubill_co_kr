<!-- #include file = "Board.Default.asp" -->
<!-- #include file = "../libs/md5.asp" -->
<%
	REQ_intCommentPage = GetInputReplce(REQUEST.QueryString("comment_page"), "")

	IF REQ_intCommentPage = "" THEN
		REQ_intCommentPage = 1
	ELSE
		IF GetNumericCheck(REQ_intCommentPage, "i") = False THEN REQ_intCommentPage = 1
	END IF

	REQ_intCommentSeq = GetInputReplce(REQUEST.QueryString("comment_seq"), "")

	IF REQ_intCommentSeq = "" THEN
		RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, REQ_intCommentSeq, REQ_intCommentPage, "view", subAct, "")
		RESPONSE.End()
	END IF
%>
<!-- #include file = "Comment.Write.asp" -->
<%
	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
	SET AdRs_ExtraForm = NOTHING : SET AdRs_ExtraForm_Count = NOTHING
%>
<script type="text/javascript">

	var set_comment_default = {
		page : "<%=REQ_intCommentPage%>"
	}

</script>