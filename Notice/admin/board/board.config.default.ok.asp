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

		DIM intSrl, strBoardID, strTitle, strLayoutCode, strCateCode, strSkinName, strSkinColor, strSkinLang, strBrowserTitle
		DIM bitUseConsult, bitUseSecret, strHeaderHtml, strFooterHtml

		WITH REQUEST

			intSrl          = GetInputReplce(.QueryString("intSrl"), "")
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
			bitUseTrash     = GetInputReplce(.FORM("bitUseTrash"), "")
			strHeaderHtml   = GetInputReplce(.FORM("strHeaderHtml"), "")
			strFooterHtml   = GetInputReplce(.FORM("strFooterHtml"), "")

		END WITH

		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_ID_CHECK] '" & intSrl & "', '" & strBoardID & "' ")

		IF RS(0) = 0 THEN
			DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_DEFAULT_UPDATE] '" & intSrl & "', '" & strBoardID & "', N'" & strTitle & "', '" & strLayoutCode & "', '" & strCateCode & "', '" & strSkinName & "', '" & strSkinColor & "', '" & strSkinLang & "', N'" & strBrowserTitle & "', '" & bitUseConsult & "', '" & bitUseSecret & "', '" & bitUseTrash & "', N'" & strHeaderHtml & "', N'" & strFooterHtml & "' ")
		ELSE
			RESPONSE.WRITE "ER"
		END IF
		
	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	DBCON.CLOSE
%>