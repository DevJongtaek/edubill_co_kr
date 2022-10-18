<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "B02"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
	
		DIM intSeq, strStartDate, strEndDate, strPosition, intWidth, intHeight, bitScroll, strPopupType, strTitle
		DIM strContentType, strContent, strContentHtml, strFooter, bitUse
	
		DIM tmpFor
	
		SELECT CASE Act
	
		CASE "popupadd", "popupmodify"
	
			WITH REQUEST
	
				intSeq         = .FORM("intSeq")
				strStartDate   = REPLACE(.FORM("strStartDate"), ".", "")
				strEndDate     = REPLACE(.FORM("strEndDate"), ".", "")
				strPosition    = .FORM("strPosition1") & "," & .FORM("strPosition2") & "," & .FORM("strPosition3") & "," & .FORM("strPosition4")
				intWidth       = .FORM("intWidth")
				intHeight      = .FORM("intHeight")
				bitScroll      = .FORM("bitScroll")
				strPopupType   = .FORM("strPopupType")
				strTitle       = GetInputReplce(.FORM("strTitle"), "")
				strContentType = .FORM("strContentType")
				strContent     = .FORM("strContent")
				strContentHtml = .FORM("strContentHtml")
				strFooter      = .FORM("strFooter")
				bitUse         = .FORM("bitUse")

			END WITH
	
			SELECT CASE Act
			CASE "popupadd"
	
				DBCON.EXECUTE("[ARTY30_SP_POPUPS_ADD] 'W', '', '" & strStartDate & "', '" & strEndDate & "', '" & strPosition & "', '" & intWidth & "', '" & intHeight & "', '" & bitScroll & "', '" & strPopupType & "', N'" & strTitle & "', '" & strContentType & "', N'" & strContent & "', N'" & strContentHtml & "', N'" & strFooter & "', '" & bitUse & "' ")
	
				RESPONSE.WRITE "SW"
		
			CASE "popupmodify"
	
				DBCON.EXECUTE("[ARTY30_SP_POPUPS_ADD] 'E', '" & intSeq & "', '" & strStartDate & "', '" & strEndDate & "', '" & strPosition & "', '" & intWidth & "', '" & intHeight & "', '" & bitScroll & "', '" & strPopupType & "', N'" & strTitle & "', '" & strContentType & "', N'" & strContent & "', N'" & strContentHtml & "', N'" & strFooter & "', '" & bitUse & "' ")
	
				RESPONSE.WRITE "SE"
	
			END SELECT
	
		CASE "popupremove"
	
			FOR tmpFor = 1 TO REQUEST.FORM("intSeq").COUNT
	
				DBCON.EXECUTE("[ARTY30_SP_POPUPS_REMOVE] '" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), "") & "' ")
	
			NEXT
	
		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>