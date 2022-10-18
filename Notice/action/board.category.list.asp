<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/dbconn.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM intSrl, intCategory, intMemberSrl, strMemberGroup, staff, bitSpace

	intSrl       = GetInputReplce(REQUEST.FORM("board_srl"), "")
	intCategory  = GetInputReplce(REQUEST.FORM("category_srl"), "")
	intMemberSrl = GetInputReplce(REQUEST.FORM("member_srl"), "")
	staff        = GetInputReplce(REQUEST.FORM("staff"), "")
	bitSpace     = GetInputReplce(REQUEST.FORM("space"), "")

	IF bitSpace = "" THEN bitSpace = "1"

	IF intMemberSrl <> "" AND intMemberSrl <> "0" AND staff = "0" THEN

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & intMemberSrl & "' ")

		strMemberGroup = RS("strGroupCode")

	END IF

	IF intCategory = "" THEN intCategory = 0

	RESPONSE.WRITE "["

	DIM iCount, tmpFor
	iCount = 0

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CATEGORY_LIST] '" & intSrl & "' ")

	WHILE NOT(RS.EOF)

		iCount = iCount + 1
		IF iCount > 1 THEN RESPONSE.WRITE ","

		RESPONSE.WRITE "{""code"":""" & RS("intModuleCode") & """, ""sys_code"":""" & RS("intCode") & """, ""parent_code"":""" & RS("intParentCode") & """, ""board_count"":""" & RS("intBoardCount") & """, ""title"":"""

		IF bitSpace = "1" THEN
			IF (LEN(RS("sortcol")) / 2) - 1 > 0 THEN
				FOR tmpFor = 1 TO (LEN(RS("sortcol")) / 2) - 1
					RESPONSE.WRITE "&nbsp;&nbsp;"
				NEXT
			END IF
		END IF
		
		RESPONSE.WRITE RS("strTitle") & """, ""color"":""" & RS("strFontColor") & """, ""depth"":""" & (LEN(RS("sortcol")) / 2) - 1 & """, ""disable"":"""

		IF staff = "0" THEN
			IF RS("strGroupCode") <> "" AND ISNULL(RS("strGroupCode")) = False THEN
				IF intMemberSrl = "" THEN
					RESPONSE.WRITE "true"
				ELSE
					IF INSTR(RS("strGroupCode"), strMemberGroup) = 0 THEN RESPONSE.WRITE "true"
				END IF
			END IF
		END IF

		RESPONSE.WRITE """, ""selected"":"""

		IF INT(RS("intModuleCode")) = INT(intCategory) THEN RESPONSE.WRITE "true"
		
		RESPONSE.WRITE """}" & CHR(10)

	RS.MOVENEXT
	WEND

	RESPONSE.WRITE "]"

	SET RS = NOTHING : DBCON.CLOSE
%>