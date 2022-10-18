<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "E01"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
		
		SELECT CASE Act
		CASE "add", "modify"

			DIM strStartDate, strStartHour, strStartMinute, strEndDate, strEndHour, strEndMinute, strTitle, strContent, strIcon
			DIM strStartDateTime, strEndDateTime

			WITH REQUEST

				strStartDate   = GetInputReplce(.FORM("strStartDate"), "")
				strStartHour   = GetInputReplce(.FORM("strStartHour"), "")
				strStartMinute = GetInputReplce(.FORM("strStartMinute"), "")
				strEndDate     = GetInputReplce(.FORM("strEndDate"), "")
				strEndHour     = GetInputReplce(.FORM("strEndHour"), "")
				strEndMinute   = GetInputReplce(.FORM("strEndMinute"), "")
				strTitle       = GetInputReplce(.FORM("strTitle"), "")
				strContent     = GetInputReplce(.FORM("strContent"), "")
				strIcon        = GetInputReplce(.FORM("strIcon"), "")

			END WITH

			strStartDateTime = REPLACE(strStartDate, ".", "-") & " " & strStartHour & ":" & strStartMinute
			strEndDateTime = REPLACE(strEndDate, ".", "-") & " " & strEndHour & ":" & strEndMinute

			SELECT CASE Act
			CASE "add"

				IF GetInputReplce(REQUEST.fORM("bitRepeat"), "") = "1" THEN

					DIM tmpFor

					FOR tmpFor = 0 TO DATEDIFF("d", REPLACE(strStartDate, ".", "-"), REPLACE(strEndDate, ".", "-"))

						DBCON.EXECUTE("[ARTY30_SP_SCHEDULE_ADD] 'W', '', '" & SESSION("memberSeq") & "', '" & DATEADD("d", tmpFor, REPLACE(strStartDate, ".", "-")) & " " & strStartHour & ":" & strStartMinute & "', '" & strEndDateTime & "', N'" & strTitle & "', N'" & strContent & "', '" & strIcon & "' ")

					NEXT

				ELSE

					DBCON.EXECUTE("[ARTY30_SP_SCHEDULE_ADD] 'W', '', '" & SESSION("memberSeq") & "', '" & strStartDateTime & "', '" & strEndDateTime & "', N'" & strTitle & "', N'" & strContent & "', '" & strIcon & "' ")

				END IF
	
				RESPONSE.WRITE "SW"
				RESPONSE.End()

			CASE "modify"

				DBCON.EXECUTE("[ARTY30_SP_SCHEDULE_ADD] 'E', '" & GetInputReplce(REQUEST.FORM("intSeq"), "") & "', '" & SESSION("memberSeq") & "', '" & strStartDateTime & "', '" & strEndDateTime & "', N'" & strTitle & "', N'" & strContent & "', '" & strIcon & "' ")
	
				RESPONSE.WRITE "SE"
				RESPONSE.End()

			END SELECT

		CASE "read"

			SET RS = DBCON.EXECUTE("[ARTY30_SP_SCHEDULE_READ] '" & GetInputReplce(REQUEST.FORM("intSeq"), "") & "' ")

			RESPONSE.WRITE "["
			RESPONSE.WRITE "{""sdate"":""" & REPLACE(LEFT(RS("strStartDate"), 10), "-", ".") & """, ""shour"":""" & HOUR(RS("strStartDate")) & """, ""sminute"":""" & MINUTE(RS("strStartDate")) & """, ""edate"":""" & REPLACE(LEFT(RS("strEndDate"), 10), "-", ".") & """, ""ehour"":""" & HOUR(RS("strEndDate")) & """, ""eminute"":""" & MINUTE(RS("strEndDate")) & """, ""enddate"":""" & RS("strEndDate") & """, ""title"":""" & RS("strTitle") & """, ""content"":""" & GetReplaceTag2Text(GetStripTags(RS("strContent"))) & """, ""icon"":""" & RS("strIcon") & """}"
			RESPONSE.WRITE "]"

		CASE "remove"

			DBCON.EXECUTE("[ARTY30_SP_SCHEDULE_REMOVE] '" & GetInputReplce(REQUEST.FORM("intSeq"), "") & "' ")

		END SELECT
			
	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	DBCON.CLOSE
%>