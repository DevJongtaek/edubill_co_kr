<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM strLeaveMemo, strPassword

	strLeaveMemo = GetInputReplce(REQUEST.FORM("strLeaveMemo"), "")
	strPassword  = GetInputReplce(REQUEST.FORM("strPassword"), "")

	IF SESSION("memberSeq") = "" THEN
	
		RESPONSE.WRITE "ERROR01"
		RESPONSE.End()
	
	END IF

	DIM strAdmin

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & SESSION("memberSeq") & "', '" & strPassword & "' ")

	IF RS.EOF THEN

		RESPONSE.WRITE "ERROR02"
		RESPONSE.End()

	END IF

	strAdmin = RS("strAdmin")

	DIM strOutOption

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_CONFIG_READ] ")

	strOutOption = RS("strOutOption")

	IF strAdmin = "A" THEN 
		RESPONSE.WRITE "ERROR03"
		RESPONSE.End()
	ELSE
		IF strOutOption = "1" THEN
			CALL ActMemberRemove(SESSION("memberSeq"), strAdmin, GetNowFolderPath("../../") & "\" & CONF_strFilePath)
		ELSE
			DBCON.EXECUTE("[ARTY30_SP_MEMBER_LEAVE] '" & SESSION("memberSeq") & "', N'" & GetInputReplce(REQUEST.FORM("strLeaveMemo"), "") & "' ")
		END IF
	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>