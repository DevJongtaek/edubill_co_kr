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

			CASE "adminadd", "adminremove"
	
				DIM memberSrl
				memberSrl = GetInputReplce(REQUEST.FORM("memberSrl"), "")

			SELECT CASE Act
			CASE "adminadd"
				DBCON.EXECUTE("[ARTY30_SP_BOARD_ADMIN_UPDATE] 'W', '" & GetInputReplce(REQUEST.FORM("intSrl"), "") & "', '" & memberSrl & "' ")
			CASE "adminremove"
				DBCON.EXECUTE("[ARTY30_SP_BOARD_ADMIN_UPDATE] 'R', '" & GetInputReplce(REQUEST.FORM("intSrl"), "") & "', '" & memberSrl & "' ")
			END SELECT

		CASE "config"

			DIM strListLevel, strListGroup, strListAction, strReadLevel, strReadGroup, strReadAction, strWriteLevel
			DIM strWriteGroup, strWriteAction, strCmtWriteLevel, strCmtWriteGroup, strUploadLevel, strUploadGroup
			DIM strDownLevel, strDownGroup

			WITH REQUEST

				strListLevel     = GetInputReplce(.FORM("strListLevel"), "")
				strListGroup     = GetInputReplce(.FORM("strListGroup"), "")
				strListAction    = .FORM("strListAction1") & "^$$^" & .FORM("strListAction2")
				strReadLevel     = GetInputReplce(.FORM("strReadLevel"), "")
				strReadGroup     = GetInputReplce(.FORM("strReadGroup"), "")
				strReadAction    = .FORM("strReadAction1") & "^$$^" & .FORM("strReadAction2")
				strWriteLevel    = GetInputReplce(.FORM("strWriteLevel"), "")
				strWriteGroup    = GetInputReplce(.FORM("strWriteGroup"), "")
				strWriteAction   = .FORM("strWriteAction1") & "^$$^" & .FORM("strWriteAction2")
				strCmtWriteLevel = GetInputReplce(.FORM("strCmtWriteLevel"), "")
				strCmtWriteGroup = GetInputReplce(.FORM("strCmtWriteGroup"), "")
				strUploadLevel   = GetInputReplce(.FORM("strUploadLevel"), "")
				strUploadGroup   = GetInputReplce(.FORM("strUploadGroup"), "")
				strDownLevel     = GetInputReplce(.FORM("strDownLevel"), "")
				strDownGroup     = GetInputReplce(.FORM("strDownGroup"), "")

			END WITH

			IF RIGHT(strListAction, 4) = "^$$^" THEN strListAction = strListAction & "0"
			IF RIGHT(strReadAction, 4) = "^$$^" THEN strReadAction = strReadAction & "0"
			IF RIGHT(strWriteAction, 4) = "^$$^" THEN strWriteAction = strWriteAction & "0"

			DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_LEVEL_UPDATE] '" & intSrl & "', '" & strListLevel & "', '" & strListGroup & "', N'" & strListAction & "', '" & strReadLevel & "', '" & strReadGroup & "', N'" & strReadAction & "', '" & strWriteLevel & "', '" & strWriteGroup & "', N'" & strWriteAction & "', '" & strCmtWriteLevel & "', '" & strCmtWriteGroup & "', '" & strUploadLevel & "', '" & strUploadGroup & "', '" & strDownLevel & "', '" & strDownGroup & "' ")

		END SELECT
		
	ELSE

		RESPONSE.WRITE "ERROR"

	END IF

	DBCON.CLOSE
%>