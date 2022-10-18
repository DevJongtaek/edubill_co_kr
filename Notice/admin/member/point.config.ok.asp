<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM menuID, isStaffCheck, isStaffAddLog
	menuID = "C08"
	isStaffAddLog = True
%>
<!-- #include file = "../comm/staff.check.log.asp" -->
<%
	IF isStaffCheck = True THEN

		DIM Act
		Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), "S"))
	
		SELECT CASE Act
		CASE "grouplevel"
	
			DIM strGroupCode, intUpLevel
	
			strGroupCode = GetInputReplce(REQUEST.FORM("groupcode"), "")
			intUpLevel   = GetInputReplce(REQUEST.FORM("level"), "")

			DBCON.EXECUTE("[ARTY30_SP_POINT_CONFIG_GROUP] '" & strGroupCode & "', '" & intUpLevel & "' ")
	
		CASE "config"

			DIM bitPointUse, strLevelUpdate, bitGroupUpdate

			bitPointUse    = GetInputReplce(REQUEST.FORM("bitPointUse"), "")
			strLevelUpdate = GetInputReplce(REQUEST.FORM("strLevelUpdate"), "")
			bitGroupUpdate = GetInputReplce(REQUEST.FORM("bitGroupUpdate"), "")

			DBCON.EXECUTE("[ARTY30_SP_POINT_CONFIG_UPDATE] '" & bitPointUse & "', '" & strLevelUpdate & "', '" & bitGroupUpdate & "' ")

		CASE "remove"

			DIM tmpFor

			FOR tmpFor = 1 TO REQUEST.FORM("intSeq").COUNT
				DBCON.EXECUTE("[ARTY30_SP_POINT_REMOVE] '" & GetInputReplce(REQUEST.FORM("intSeq")(tmpFor), "") & "' ")
			NEXT

		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>