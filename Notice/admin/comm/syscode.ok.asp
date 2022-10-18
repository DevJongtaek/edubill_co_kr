<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	DIM Act, strFirstCode, strSecondCode, tmpFor, strName
	Act          = LCASE(GetInputReplce(REQUEST.QueryString("Act"), ""))
	strFirstCode = GetInputReplce(REQUEST.QueryString("strFirstCode"), "")
	strName      = GetInputReplce(REQUEST.FORM("strName"), "")

	SELECT CASE Act
	CASE "add"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_SYSCODE_READ] '" & strFirstCode & "', '', 'I', '" & strName & "' ")

		IF NOT(RS.EOF) THEN
			RESPONSE.WRITE "error"
			RESPONSE.End()
		END IF

		SET RS = DBCON.EXECUTE("[ARTY30_SP_SYSCODE_READ] '" & strFirstCode & "', '', 'C' ")

		IF RS.EOF THEN
			strSecondCode = "C000000001"
		ELSE
			strSecondCode = INT(RIGHT(RS("strSecondCode"), 9)) + 1
			FOR tmpFor = LEN(strSecondCode) TO 8
				strSecondCode = "0" & strSecondCode
			NEXT
			strSecondCode = "C" & strSecondCode
		END IF

		DBCON.EXECUTE("[ARTY30_SP_SYSCODE_ADD] 'W', '" & strFirstCode & "', '" & strSecondCode & "', N'" & strName & "' ")

		RESPONSE.WRITE strSecondCode
		RESPONSE.End()

	CASE "edit"

		strSecondCode = GetInputReplce(REQUEST.FORM("strSecondCode"), "")

		SET RS = DBCON.EXECUTE("[ARTY30_SP_SYSCODE_READ] '" & strFirstCode & "', '" & strSecondCode & "', 'S', '" & strName & "' ")

		IF NOT(RS.EOF) THEN
			RESPONSE.WRITE "error"
			RESPONSE.End()
		END IF

		DBCON.EXECUTE("[ARTY30_SP_SYSCODE_ADD] 'E', '" & strFirstCode & "', '" & strSecondCode & "', N'" & strName & "' ")

	CASE "remove"

		strSecondCode = GetInputReplce(REQUEST.FORM("strSecondCode"), "")

		DBCON.EXECUTE("[ARTY30_SP_SYSCODE_REMOVE] '" & strFirstCode & "', '" & strSecondCode & "' ")

	CASE "list"

		DIM iCount
		iCount = 0

		RESPONSE.WRITE "["
	
		SET RS = DBCON.EXECUTE("[ARTY30_SP_SYSCODE_READ] '" & strFirstCode & "' ")
	
		WHILE NOT(RS.EOF)
	
			iCount = iCount + 1
	
			IF iCount > 1 THEN RESPONSE.WRITE ","

			RESPONSE.WRITE "{""code"":""" & RS("strSecondCode") & """, ""name"":""" & RS("strName") & """}" & CHR(10)

		RS.MOVENEXT
		WEND

		RESPONSE.WRITE "]"

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
%>