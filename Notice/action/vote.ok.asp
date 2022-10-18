<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	IF SESSION("memberSeq") = "" THEN

		RESPONSE.WRITE "ERROR01"
		RESPONSE.End()

	ELSE

		DIM Act, intBoardSrl, intBoardSeq, intCommentSeq
	
		WITH REQUEST
	
			Act           = GetInputReplce(.QueryString("Act"), "")
			intBoardSrl   = GetInputReplce(.FORM("boardSrl"), "")
			intBoardSeq   = GetInputReplce(.FORM("boardSeq"), "")
			intCommentSeq = GetInputReplce(.FORM("commentSeq"), "")
			bitBlamed     = GetInputReplce(.FORM("blamed"), "")
	
		END WITH

		DIM intMemberTargetSrl
	
		SELECT CASE Act
		CASE "boardvote", "boardblamed"

			SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_LEVEL_POINT_READ] '" & intBoardSrl & "' ")

			bitPointUse = RS("bitUsePoint")
			
			IF Act = "boardvote" THEN
				intPoint    = RS("intVotePoint")
				strPoint    = RS("strVotePoint")
			ELSE
				intPoint    = RS("intBlamedPoint")
				strPoint    = RS("strBlamedPoint")
			END IF

			SET RS = DBCON.EXECUTE("[ARTY30_SP_VOTE_ADD] '" & intBoardSrl & "', '" & intBoardSeq & "', '0', '" & SESSION("memberSeq") & "', '" & bitBlamed & "', '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "', '" & intPoint & "' ")

			IF RS(0) = "0" THEN

				IF bitBlamed = "0" THEN RESPONSE.WRITE "ERROR02" ELSE RESPONSE.WRITE "ERROR03"
				RESPONSE.End()

			ELSE

				intMemberTargetSrl = RS(1)

				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & intMemberTargetSrl & "' ")

				DIM bitBoardAdmin

				bitBoardAdmin = GetBoardAdminCheck(intBoardSrl, intMemberTargetSrl, RS("strAdmin"))

				IF bitBoardAdmin = False AND intMemberTargetSrl <> 0 AND INT(intMemberTargetSrl) AND bitPointUse = True AND intPoint <> 0 THEN DBCON.EXECUTE("[ARTY30_SP_POINT_ADD] '" & intMemberTargetSrl & "', '" & SESSION("memberSeq") & "', '" & intPoint & "', '" & strPoint & "', 'vote', '0', '" & intBoardSeq & "' ")

			END IF

		CASE "commentvote", "commentblamed"

			SET RS = DBCON.EXECUTE("[ARTY30_SP_VOTE_ADD] '" & intBoardSrl & "', '" & intBoardSeq & "', '" & intCommentSeq & "', '" & SESSION("memberSeq") & "', '" & bitBlamed & "', '" & REQUEST.SERVERVARIABLES("REMOTE_ADDR") & "', '0' ")

			IF RS(0) = "0" THEN

				IF bitBlamed = "0" THEN RESPONSE.WRITE "ERROR02" ELSE RESPONSE.WRITE "ERROR03"
				RESPONSE.End()

			END IF

		END SELECT

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>