<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_READ] 'strSSN' ")

	IF RS("bitUse") = True AND RS("bitRquired") = True THEN
		RESPONSE.WRITE "ssncheck"
	ELSE
		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_CONFIG_READ] ")

		IF RS("bitUseCertified") = True THEN
			IF RS("bitUseEmailCheck") = True OR  RS("bitUseSmsCheck") = True THEN RESPONSE.WRITE "certified" ELSE RESPONSE.WRITE "dispform"
		ELSE
			RESPONSE.WRITE "dispform"
		END IF
	END IF

	RESPONSE.End()
	
	SET RS = NOTHING : DBCON.CLOSE
%>