<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM strPassword, strPassword2

	strPassword  = GetInputReplce(REQUEST.FORM("strPassword"), "")
	strPassword2 = GetInputReplce(REQUEST.FORM("strPassword2"), "")

	IF SESSION("memberSeq") = "" THEN

		RESPONSE.WRITE "ERROR01"

	ELSE

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & SESSION("memberSeq") & "', '" & strPassword & "' ")

		IF RS.EOF THEN

			RESPONSE.WRITE "ERROR02"

		ELSE

			DBCON.EXECUTE("[ARTY30_SP_MEMBER_PASSWORD_UPDATE] '" & SESSION("memberSeq") & "', '" & strPassword2 & "' ")
			
		END IF

	END IF

	RESPONSE.End()
	
	SET RS = NOTHING : DBCON.CLOSE
%>