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

		DIM strFieldRecord, strFieldName, strFieldType, strDefaultValue, strReadLevel, strReadGroup, strWriteLevel, strWriteGroup
		DIM bitUse, bitRquired, bitSearch, bitReadDisplay, intOrder, strDescription

		SELECT CASE Act
		CASE "boardconfigfieldadd", "boardconfigfieldmodify"

			WITH REQUEST

				strFieldRecord  = GetInputReplce(.FORM("strFieldRecord"), "")
				strFieldName    = GetInputReplce(.FORM("strFieldName"), "")
				strFieldType    = GetInputReplce(.FORM("strFieldType"), "")
				strDefaultValue = GetInputReplce(.FORM("strDefaultValue"), "")
				strReadLevel     = GetInputReplce(.FORM("strReadLevel"), "")
				strReadGroup     = GetInputReplce(.FORM("strReadGroup"), "")
				strWriteLevel    = GetInputReplce(.FORM("strWriteLevel"), "")
				strWriteGroup    = GetInputReplce(.FORM("strWriteGroup"), "")
				bitUse          = GetInputReplce(.FORM("bitUse"), "")
				bitRquired      = GetInputReplce(.FORM("bitRquired"), "")
				bitReadDisplay  = GetInputReplce(.FORM("bitReadDisplay"), "")
				bitSearch       = GetInputReplce(.FORM("bitSearch"), "")
				intOrder        = GetInputReplce(.FORM("intOrder"), "")
				strDescription  = GetInputReplce(.FORM("strDescription"), "")

			END WITH

			SELECT CASE Act
			CASE "boardconfigfieldadd"

response.write "[ARTY30_SP_BOARD_FIELD_ADD] '" & intSrl & "', 'W', '" & strFieldRecord & "', '" & strFieldName & "', '" & strFieldType & "', '" & strDefaultValue & "', '" & strReadLevel & "', '" & strReadGroup & "', '" & strWriteLevel & "', '" & strWriteGroup & "', '" & bitUse & "', '" & bitRquired & "', '" & bitReadDisplay & "', '" & bitSearch & "', '" & strDescription & "' "

				DBCON.EXECUTE("[ARTY30_SP_BOARD_FIELD_ADD] '" & intSrl & "', 'W', '" & strFieldRecord & "', '" & strFieldName & "', '" & strFieldType & "', '" & strDefaultValue & "', '" & strReadLevel & "', '" & strReadGroup & "', '" & strWriteLevel & "', '" & strWriteGroup & "', '" & bitUse & "', '" & bitRquired & "', '" & bitReadDisplay & "', '" & bitSearch & "', '" & strDescription & "' ")

				RESPONSE.WRITE "SW"

			CASE "boardconfigfieldmodify"

				DBCON.EXECUTE("[ARTY30_SP_BOARD_FIELD_ADD] '" & intSrl & "', 'E', '" & strFieldRecord & "', '" & strFieldName & "', '" & strFieldType & "', '" & strDefaultValue & "', '" & strReadLevel & "', '" & strReadGroup & "', '" & strWriteLevel & "', '" & strWriteGroup & "', '" & bitUse & "', '" & bitRquired & "', '" & bitReadDisplay & "', '" & bitSearch & "', '" & strDescription & "' ")

				RESPONSE.WRITE "SE"

			END SELECT

		CASE "remove"

			DIM tmpFor

			FOR tmpFor = 1 TO REQUEST.FORM("strFieldRecord").COUNT

				DBCON.EXECUTE("[ARTY30_SP_BOARD_FIELD_REMOVE] '" & GetInputReplce(REQUEST.QueryString("intSrl"), "") & "', '" & REQUEST.FORM("strFieldRecord")(tmpFor) & "' ")

			NEXT

		CASE "moveup", "movedown"

			DBCON.EXECUTE("[ARTY30_SP_BOARD_FIELD_UPDATE] '" & GetInputReplce(REQUEST.FORM("intSrl"), "") & "', '" & GetInputReplce(REQUEST.FORM("strFieldRecord"), "") & "', '" & Act & "' ")
			
		END SELECT

	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>