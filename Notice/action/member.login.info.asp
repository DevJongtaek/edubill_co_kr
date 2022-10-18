<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	IF INSTR(CONF_strSiteUrl, "http://" & REQUEST.ServerVariables("HTTP_HOST")) = 0 THEN

		RESPONSE.WRITE "ERROR"
		RESPONSE.End()

	ELSE

		DIM intMemberSrl
		intMemberSrl = SESSION("memberSeq")

		RESPONSE.WRITE "["
	
		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_LOGIN_INFO] '" & intMemberSrl & "' ")

		IF NOT(RS.EOF) THEN

			RESPONSE.WRITE "{""member_type"":""" & RS("strMemberType") & """, ""group_name"":""" & RS("strGroupName") & """, ""level"":""" & RS("intLevel") & """,""email"":""" & RS("strEmail") & """, ""article:"":""" & RS("intArticle") & """, ""comment"":""" & RS("intComment") & """, ""point"":""" & RS("intPoint") & """, ""visit"":""" & RS("intVisit") & """, ""visit_ip"":""" & RS("strVisitIp") & """, ""visit_date"":""" & RS("strVisitDate") & """, ""memo_count"":""" & RS("intMemoCount") & """}" & CHR(10)

		END IF
	
		RESPONSE.WRITE "]"

	END IF
	
	DBCON.CLOSE
%>