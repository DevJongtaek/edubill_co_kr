<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "D01"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM intSrl, strBoardID, strTitle, strLayoutCode, strCateCode, strSkinName, strSkinColor, strSkinLang, strBrowserTitle
		DIM bitUseConsult, bitUseSecret, strHeaderHtml, strFooterHtml

		WITH REQUEST

			strBoardID      = GetInputReplce(.FORM("strBoardID"), "")
			strTitle        = GetInputReplce(.FORM("strTitle"), "")
			strLayoutCode   = GetInputReplce(.FORM("strLayoutCode"), "")
			strCateCode     = GetInputReplce(.FORM("strCateCode"), "")
			strSkinName     = GetInputReplce(.FORM("strSkinName"), "")
			strSkinColor    = GetInputReplce(.FORM("strSkinColor"), "")
			strSkinLang     = GetInputReplce(.FORM("strSkinLang"), "")
			strBrowserTitle = GetInputReplce(.FORM("strBrowserTitle"), "")
			bitUseConsult   = GetInputReplce(.FORM("bitUseConsult"), "")
			bitUseSecret    = GetInputReplce(.FORM("bitUseSecret"), "")
			strHeaderHtml   = GetInputReplce(.FORM("strHeaderHtml"), "")
			strFooterHtml   = GetInputReplce(.FORM("strFooterHtml"), "")

		END WITH

		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_ID_CHECK] '', '" & strBoardID & "' ")

		IF RS(0) > 0 THEN

			RESPONSE.WRITE "ER"
			RESPONSE.End()

		ELSE

			SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_ID_CHECK] '', '', 'Y' ")

			intSrl = RS(0)

			DIM strPath

			strPath = GetNowFolderPath("../../" & CONF_strFilePath) & "\"

			CALL ActFolderMake(strPath & "board\" & intSrl)
			CALL ActFolderMake(strPath & "board\" & intSrl & "\config")
			CALL ActFolderMake(strPath & "board\" & intSrl & "\files")
			CALL ActFolderMake(strPath & "board\" & intSrl & "\images")
			CALL ActFolderMake(strPath & "board\" & intSrl & "\images\temp")
			CALL ActFolderMake(strPath & "board\" & intSrl & "\images\thrum")

			CALL ActFolderMake(strPath & "comment\" & intSrl)
			CALL ActFolderMake(strPath & "comment\" & intSrl & "\files")
			CALL ActFolderMake(strPath & "comment\" & intSrl & "\images")
			CALL ActFolderMake(strPath & "comment\" & intSrl & "\images\temp")
			CALL ActFolderMake(strPath & "comment\" & intSrl & "\images\thrum")

			DBCON.EXECUTE("[ARTY30_SP_BOARD_MAKE] '" & intSrl & "', '" & strBoardID & "', N'" & strTitle & "', '" & strLayoutCode & "', '" & strCateCode & "', '" & strSkinName & "', '" & strSkinColor & "', '" & strSkinLang & "', N'" & strBrowserTitle & "', '" & bitUseConsult & "', '" & bitUseSecret & "', N'" & strHeaderHtml & "', N'" & strFooterHtml & "' ")
		
		
		END IF

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	DBCON.CLOSE
%>