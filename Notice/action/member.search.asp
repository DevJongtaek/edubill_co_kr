<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	IF INSTR(CONF_strSiteUrl, "http://" & REQUEST.ServerVariables("HTTP_HOST")) = 0 THEN

		RESPONSE.WRITE "ERROR"
		RESPONSE.End()

	ELSE

		DIM strSearchTarget, strSearchKeyword, iCount

		strSearchTarget  = GetInputReplce(REQUEST.FORM("strSearchTarget"), "")
		strSearchKeyword = GetInputReplce(REQUEST.FORM("strSearchKeyword"), "")

		SELECT CASE LCASE(strSearchTarget)
		CASE "nick_name" : strSearchTarget = "strNickName"
		CASE "user_id"   : strSearchTarget = "strLoginID"
		CASE "user_name" : strSearchTarget = "strLoginName"
		CASE ELSE        : strSearchTarget = "strNickName"
		END SELECT

		RESPONSE.WRITE "["

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '', '', '" & strSearchTarget & "', '" & strSearchKeyword & "' ")

		iCount = 0

		WHILE NOT(RS.EOF)

			IF iCount > 0 THEN RESPONSE.WRITE ","

			RESPONSE.WRITE "{""member_seq"":""" & RS("intSeq") & """, ""userid"":""" & RS("strLoginID") & """, ""nick_name"":""" & RS("strNickName") & """}" & CHR(10)

			iCount = iCount + 1

		RS.MOVENEXT
		WEND

		RESPONSE.WRITE "]"

	END IF
	
	DBCON.CLOSE
%>