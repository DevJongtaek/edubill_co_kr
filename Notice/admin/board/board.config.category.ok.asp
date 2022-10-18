<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "D02"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act, intSrl
		Act    = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
		intSrl = GetInputReplce(REQUEST.QueryString("intSrl"), "")

		SELECT CASE Act
		CASE "move"

			DIM source_srl, target_srl, position

			source_srl = GetInputReplce(REQUEST.FORM("source_srl"), "")
			target_srl = GetInputReplce(REQUEST.FORM("target_srl"), "")
			position   = GetInputReplce(REQUEST.FORM("position"), "")

			DBCON.EXECUTE("[ARTY30_SP_BOARD_CATEGORY_UPDATE] '" & intSrl & "', '" & source_srl & "', '" & target_srl & "', '" & position & "' ")

		CASE "add"

			SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CATEGORY_ADD] 'W', '" & intSrl & "', '0', '" & GetInputReplce(REQUEST.FORM("parent_srl"), "") & "', '" & GetInputReplce(REQUEST.FORM("node_position"), "") & "', N'" & GetInputReplce(REQUEST.FORM("node_name"), "")  & "', '#666666', '0', '' ")

			RESPONSE.WRITE RS(0)
			RESPONSE.End()

		CASE "rename"

			DBCON.EXECUTE("[ARTY30_SP_BOARD_CATEGORY_RENAME] '" & intSrl & "', '" & GetInputReplce(REQUEST.FORM("node_srl"), "") & "', N'" & GetInputReplce(REQUEST.FORM("node_name"), "") & "' ")

		CASE "remove"

			SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CATEGORY_REMOVE] '" & intSrl & "', '" & GetInputReplce(REQUEST.FORM("node_srl"), "") & "' ")

			RESPONSE.WRITE RS(0)
			RESPONSE.End()

		CASE "modify"

			DIM strTitle, strFontColor, bitDispArticleCount, strGroupCode

			WITH REQUEST

				strTitle            = .FORM("strTitle")
				strFontColor        = "#" & .FORM("strFontColor")
				bitDispArticleCount = .FORM("bitDispArticleCount")
				strGroupCode        = .FORM("strGroupCode")

			END WITH

			response.write "[ARTY30_SP_BOARD_CATEGORY_ADD] 'E', '" & intSrl & "', '" & GetInputReplce(REQUEST.FORM("intCode"), "") & "', '', '', N'" & strTitle & "', '" & strFontColor & "', '" & bitDispArticleCount & "', '" & strGroupCode & "' "

			DBCON.EXECUTE("[ARTY30_SP_BOARD_CATEGORY_ADD] 'E', '" & intSrl & "', '" & GetInputReplce(REQUEST.FORM("intCode"), "") & "', '', '', N'" & strTitle & "', '" & strFontColor & "', '" & bitDispArticleCount & "', '" & strGroupCode & "' ")

		CASE "config"

			DBCON.EXECUTE("[ARTY30_SP_BOARD_CATEGORY_CONFIG_UPDATE] '" & intSrl & "', '" & GetInputReplce(REQUEST.FORM("bitUseCategory"), "") & "' ")

		CASE "document_move"

			DBCON.EXECUTE("[ARTY30_SP_BOARD_CATEGORY_DOCUMENT_MOVE] '" & GetInputReplce(REQUEST.QueryString("intSrl"), "") & "', '" & GetInputReplce(REQUEST.FORM("intCode"), "") & "', '" & GetInputReplce(REQUEST.FORM("intTargetSrl"), "") & "' ")

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>