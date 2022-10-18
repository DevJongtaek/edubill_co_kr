<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"
	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "C02"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
	
		DIM strDocCode, strCateCode, strSubject, strContent, bitDefault
	
		SELECT CASE Act
	
		CASE "memberdocadd", "memberdocedit"
	
			WITH REQUEST
	
				strDocCode  = .FORM("strDocCode")
				strCateCode = .FORM("strCateCode")
				strSubject  = GetCutInputData(GetInputReplce(.FORM("strSubject"), ""), 250)
				strContent  = GetInputReplce(.FORM("strContent"), "")
				bitDefault  = .FORM("bitDefault")
	
			END WITH
	
			IF bitDefault = "" THEN bitDefault = "0"
	
			SELECT CASE Act
			CASE "memberdocadd"
	
				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_DOCUMENT_READ] 'Y' ")
	
				IF RS.EOF THEN
					strDocCode = "C000000001"
				ELSE
					strDocCode = INT(REPLACE(RS("strDocCode"), "C", "")) + 1
					FOR tmpFor = LEN(strDocCode) TO 8
						strDocCode = "0" & strDocCode
					NEXT
					strDocCode = "C" & strDocCode
				END IF
	
				DBCON.EXECUTE("[ARTY30_SP_MEMBER_DOCUMENT_ADD] 'W', '" & strDocCode & "', '" & strCateCode & "', N'" & strSubject & "', N'" & strContent & "', '" & bitDefault & "' ")
	
				RESPONSE.WRITE "SW"
	
			CASE "memberdocedit"
	
				DBCON.EXECUTE("[ARTY30_SP_MEMBER_DOCUMENT_ADD] 'E', '" & strDocCode & "', '" & strCateCode & "', N'" & strSubject & "', N'" & strContent & "', '" & bitDefault & "' ")
	
				RESPONSE.WRITE "SE"
	
			END SELECT

		CASE "memberdocremove"

			DIM tmpFor, intSuccessCount
			
			intSuccessCount = 0

			FOR tmpFor = 1 TO REQUEST.FORM("strDocCode").COUNT
	
				SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_DOCUMENT_REMOVE] '" & REQUEST.FORM("strDocCode")(tmpFor) & "' ")

				intSuccessCount = INT(intSuccessCount) + INT(RS(0))

			NEXT

			IF intSuccessCount = 0 THEN RESPONSE.WRITE "E" ELSE RESPONSE.WRITE "S"

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>