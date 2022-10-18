<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "dbconn.asp" -->
<!-- #include file = "function.asp" -->
<%
	DIM searchWord
	searchWord = GetInputReplce(REQUEST("searchWord"), "")

	RESPONSE.WRITE "["

	IF TRIM(searchWord) <> "" THEN

		SET RS = DBCON.EXECUTE("[ARTY30_SP_ZIPCODE_LIST] N'" & searchWord & "' ")

		IF NOT(RS.EOF) THEN

			DIM iCount
			iCount = 0
	
			WHILE NOT(RS.EOF)
		
				iCount = iCount + 1
		
				IF iCount > 1 THEN RESPONSE.WRITE ","
	
				RESPONSE.WRITE "{""dispcode"":""" & LEFT(RS("ZIPCODE"),3) & "-" & RIGHT(RS("ZIPCODE"),3) & """, ""zipcode"":""" & RS("ZIPCODE") & """, ""sido"":""" & RS("SIDO") & """, ""gugun"":""" & RS("GUGUN") & """, ""dong"":""" & RS("DONG") & """, ""bunji"":""" & RS("BUNJI") & """, ""ri"":""" & RS("RI") & """, ""apt"":""" & RS("APT") & """}" & CHR(10)
	
			RS.MOVENEXT
			WEND
	
		END IF

	END IF

	RESPONSE.WRITE "]"

	SET RS = NOTHING : DBCON.CLOSE
%>