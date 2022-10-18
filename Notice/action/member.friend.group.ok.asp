<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	IF INSTR(CONF_strSiteUrl, "http://" & REQUEST.ServerVariables("HTTP_HOST")) = 0 THEN

		RESPONSE.WRITE "ERROR"
		RESPONSE.End()

	ELSE

		DIM Act, intMemberSrl, intGroupSrl, strTitle, iCount

		Act          = GetInputReplce(REQUEST.QueryString("Act"), "")
		intMemberSrl = GetInputReplce(REQUEST.FORM("intMemberSrl"), "")

		SELECT CASE LCASE(Act)
		CASE "friendgrouplist"

			RESPONSE.WRITE "["
	
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FRIENDS_GROUP_LIST] '" & intMemberSrl & "' ")
	
			iCount = 0
	
			WHILE NOT(RS.EOF)
	
				IF iCount > 0 THEN RESPONSE.WRITE ","
	
				RESPONSE.WRITE "{""group_srl"":""" & RS("intGroupSrl") & """, ""title"":""" & RS("strTitle") & """}" & CHR(10)
	
				iCount = iCount + 1
	
			RS.MOVENEXT
			WEND
	
			RESPONSE.WRITE "]"

		CASE "friendgroupadd"

			strTitle = REQUEST.FORM("strGroupName")

			DBCON.EXECUTE("[ARTY30_SP_MEMBER_FRIENDS_GROUP_ADD] 'W', '" & intMemberSrl & "', '', N'" & strTitle & "' ")

		CASE "friendgroupmodify"

			intGroupSrl = REQUEST.FORM("intGroupSrl")
			strTitle    = REQUEST.FORM("strGroupName")

			DBCON.EXECUTE("[ARTY30_SP_MEMBER_FRIENDS_GROUP_ADD] 'E', '" & intMemberSrl & "', '" & intGroupSrl & "', N'" & strTitle & "' ")

		CASE "friendgroupremove"

			intGroupSrl = REQUEST.FORM("intGroupSrl")

			DBCON.EXECUTE("[ARTY30_SP_MEMBER_FRIENDS_GROUP_REMOVE] '" & intMemberSrl & "', '" & intGroupSrl & "' ")

		END SELECT

	END IF
	
	DBCON.CLOSE
%>