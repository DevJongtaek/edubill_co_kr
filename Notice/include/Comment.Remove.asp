<!-- #include file = "Board.Default.asp" -->
<!-- #include file = "../libs/md5.asp" -->
<%
	DIM intCommentSeq, intCommentPage
	
	intCommentSeq  = GetInputReplce(REQUEST.QueryString("comment_seq"), "")
	intCommentPage = GetInputReplce(REQUEST.QueryString("comment_page"), "")
	
	IF CONF_bitBoardAdmin = False THEN

		SET RS = DBCON.EXECUTE("[ARTY30_SP_COMMENTS_READ] '" & intCommentSeq & "' ")

		IF RS.EOF THEN

			RESPONSE.REDIRECT GetBoardAuthScript("", "0", "", "", "", "list", "list", "msg_invalid_request")
			RESPONSE.End()

		ELSE

			IF RS("intMemberSrl") = 0 THEN

				IF GetPasswordSessionCheck(intCommentSeq, SESSION("commentSeq")) = False THEN
					RESPONSE.REDIRECT GetPasswordFormScript(REQ_intSeq, intCommentSeq, intCommentPage, "view", "comment_remove")
					RESPONSE.End()
				END IF
			ELSE
				IF SESSION("memberSeq") = "" THEN
					RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, "", "", "list", "list", "code06")
					RESPONSE.End()
				ELSE
					IF INT(RS("intMemberSrl")) <> INT(SESSION("memberSeq") ) THEN
						RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, "", "", "list", "list", "code06")
						RESPONSE.End()
					END IF
				END IF
			END IF
		END IF
	END IF

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET rootNode = NOTHING
%>
<form id="removeForm" name="removeForm">
<input type="hidden" id="intCommentSeq" name="intCommentSeq" value="<%=intCommentSeq%>" />
<input type="hidden" id="intCommentPage" name="intCommentPage" value="<%=intCommentPage%>" />
<input type="hidden" id="strPassword" name="strPassword" value="<%=strPassword%>" />
</form>