<!-- #include file = "Board.Default.asp" -->
<!-- #include file = "../libs/md5.asp" -->
<%
	IF CONF_bitBoardAdmin = False THEN

		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_READ] '" & CONF_intSrl & "', '" & REQ_intSeq & "', '', '', '0' ")

		IF RS.EOF THEN

			RESPONSE.REDIRECT GetBoardAuthScript("", "0", "", "", "", "list", "msg_invalid_request")
			RESPONSE.End()

		ELSE

			IF RS("intMemberSrl") = 0 THEN

				IF GetPasswordSessionCheck(REQ_intSeq, SESSION("boardSeq")) = False THEN

					RESPONSE.REDIRECT GetPasswordFormScript(REQ_intSeq, "", "", "view", "remove")
					RESPONSE.End()

				END IF

			ELSE

				IF SESSION("memberSeq") = "" THEN

					RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, "", "", "view", "msg_not_permitted_remove")
					RESPONSE.End()

				ELSE

					IF INT(RS("intMemberSrl")) <> INT(SESSION("memberSeq") ) THEN

						RESPONSE.REDIRECT GetBoardAuthScript("", "0", REQ_intSeq, "", "", "view", "msg_not_permitted_remove")
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
</form>