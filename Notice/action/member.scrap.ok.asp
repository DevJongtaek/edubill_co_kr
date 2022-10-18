<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	IF SESSION("memberSeq") = "" THEN

		RESPONSE.WRITE "ERROR01"
		RESPONSE.End()

	ELSE

		DIM Act
		Act = GetInputReplce(REQUEST.QueryString("Act"), "")
	
		SELECT CASE Act
		CASE "scrapadd"

			DIM intBoardSeq
			intBoardSeq = GetInputReplce(REQUEST.FORM("board_seq"), "")
		
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_SCRAP_ADD] '" & SESSION("memberSeq") & "', '" & intBoardSeq & "' ")

			IF RS(0) = "0" THEN RESPONSE.WRITE "ERROR02"
			RESPONSE.End()

		CASE "scrapremove"

			DIM tmpFor
			FOR tmpFor = 1 TO REQUEST.FORM("seq").COUNT
				DBCON.EXECUTE("[ARTY30_SP_MEMBER_SCRAP_REMOVE] '" & SESSION("memberSeq") & "', '" & REQUEST.FORM("seq")(tmpFor) & "' ")
			NEXT

		END SELECT

	END IF

	SET RS = NOTHING : DBCON.CLOSE
%>