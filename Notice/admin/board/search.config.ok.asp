<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "D10"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM strBrowserTitle, strLayoutCode, strSkinName, strSkinColor, strSkinLang, strSearchTarget, bitSearchDocument
		DIM bitSearchComment, bitSearchImage, bitSearchFile, bitSearchBoardTotal, strSearchBoard, intCutTitle, intCutContent
		DIM intImageWidth, intImageHeight, intDefaultListCount, intListCount, strLinkTarget

		WITH REQUEST

			strBrowserTitle     = GetInputReplce(.FORM("strBrowserTitle"), "")
			strLayoutCode       = .FORM("strLayoutCode")
			strSkinName         = .FORM("strSkinName")
			strSkinColor        = .FORM("strSkinColor")
			strSkinLang         = .FORM("strSkinLang")
			strSearchTarget     = .FORM("strSearchTarget")
			bitSearchDocument   = .FORM("bitSearchDocument")
			bitSearchComment    = .FORM("bitSearchComment")
			bitSearchImage      = .FORM("bitSearchImage")
			bitSearchFile       = .FORM("bitSearchFile")
			bitSearchBoardTotal = .FORM("bitSearchBoardTotal")

			FOR tmpFor = 1 TO REQUEST.FORM("strSearchBoard").COUNT
				IF strSearchBoard <> "" THEN strSearchBoard = strSearchBoard & ","
				strSearchBoard = strSearchBoard & REQUEST.FORM("strSearchBoard")(tmpFor)
			NEXT

			intCutTitle         = .FORM("intCutTitle")
			intCutContent       = .FORM("intCutContent")
			intImageWidth       = .FORM("intImageWidth")
			intImageHeight      = .FORM("intImageHeight")
			intDefaultListCount = .FORM("intDefaultListCount")
			intListCount        = .FORM("intListCount")
			strLinkTarget       = .FORM("strLinkTarget")

		END WITH

		IF bitSearchDocument = "" THEN bitSearchDocument = "0"
		IF bitSearchComment  = "" THEN bitSearchComment  = "0"
		IF bitSearchImage    = "" THEN bitSearchImage    = "0"
		IF bitSearchFile     = "" THEN bitSearchFile     = "0"

		DBCON.EXECUTE("[ARTY30_SP_SEARCH_CONFIG_UPDATE] N'" & strBrowserTitle & "', '" & strLayoutCode & "', '" & strSkinName & "', '" & strSkinColor & "', '" & strSkinLang & "', '" & strSearchTarget & "', '" & bitSearchDocument & "', '" & bitSearchComment & "', '" & bitSearchImage & "', '" & bitSearchFile & "', '" & bitSearchBoardTotal & "', '" & strSearchBoard & "', '" & intCutTitle & "', '" & intCutContent & "', '" & intImageWidth & "', '" & intImageHeight & "', '" & intDefaultListCount & "', '" & intListCount & "', '" & strLinkTarget & "' ")
			
	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	DBCON.CLOSE
%>