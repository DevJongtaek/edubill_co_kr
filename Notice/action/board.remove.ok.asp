<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<!-- #include file = "../libs/md5.asp" -->
<%
	Response.CharSet = "utf-8"

	IF INSTR(CONF_strSiteUrl, "http://" & REQUEST.ServerVariables("HTTP_HOST")) = 0 THEN

		RESPONSE.WRITE "ERROR"
		RESPONSE.End()

	ELSE

		DIM intSrl, intBoardSeq
	
		WITH REQUEST
	
			intSrl         = GetInputReplce(.QueryString("board_srl"), "")
			intBoardSeq    = GetInputReplce(.QueryString("board_seq"), "")
	
		END WITH

		DIM bitBoardAdmin, bitUseTrash
		bitBoardAdmin =  GetBoardAdminCheck(intSrl, SESSION("memberSeq"), SESSION("staff"))

		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_READ] '" & intSrl & "' ")

		bitUseTrash = GetBitTypeNumberChg(RS("bitUseTrash"))

		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_READ] '" & intSrl & "', '" & intBoardSeq & "', '', '', '0' ")
	
		IF RS.EOF THEN

			RESPONSE.WRITE "ERROR01"
			RESPONSE.End()

		ELSE

			IF bitBoardAdmin = False THEN

				IF RS("intMemberSrl") = 0 THEN
					
					IF GetPasswordSessionCheck(intBoardSeq, SESSION("boardSeq")) = False THEN

						RESPONSE.WRITE "ERROR01"
						RESPONSE.End()

					END IF

				ELSE

					IF SESSION("memberSeq") = "" THEN

						RESPONSE.WRITE "ERROR01"
						RESPONSE.End()

					ELSE

						IF INT(RS("intMemberSrl")) <> INT(SESSION("memberSeq") ) THEN

							RESPONSE.WRITE "ERROR01"
							RESPONSE.End()

						END IF

					END IF

				END IF

			END IF

		END IF

		DIM intMemberSrl
		intMemberSrl = RS("intMemberSrl")

		CALL ActBoardRemove(intSrl, intBoardSeq, intMemberSrl, bitUseTrash, GetNowFolderPath("../" & CONF_strFilePath))

		RESPONSE.WRITE "SUCCESS"
		RESPONSE.End()

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>