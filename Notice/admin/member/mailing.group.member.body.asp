<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM langXmlPath, langXmlFile

	langXmlPath = Server.MapPath("../") & "\"
	langXmlFile = "lang.member.mailing.xml"

	DIM xmlDOM, objRoot, firstLoop, secondLoop, thirdLoop

	Set xmlDOM = Server.CreateObject("Microsoft.XMLDOM")
	xmlDOM.async = false
%>
<!-- #include file = "../lang/lang.admin.page.control.asp" -->
<%
	DIM pageMode, strGroupCode, intPage, intPageSize, strGradeCode, intLevel, searchMode, searchText

	WITH REQUEST

		pageMode     = LCASE(GetInputReplce(.FORM("pageMode"), ""))
		strGroupCode = GetInputReplce(.FORM("strGroupCode"), "")
		intPage      = GetInputReplce(.FORM("intPage"), False)
		intPageSize  = GetInputReplce(.FORM("intPageSize"), False)
		strGradeCode = GetInputReplce(.FORM("strGradeCode"), "")
		intLevel     = GetInputReplce(.FORM("intLevel"), "")
		searchMode   = GetInputReplce(.FORM("searchMode"), "")
		searchText   = GetInputReplce(.FORM("searchText"), "")

	END WITH

	DIM iCount, intNumber
	iCount = 0

	SELECT CASE pageMode
	CASE "list1", "list2"

		SELECT CASE pageMode
		CASE "list1"
		
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_GROUP_MEMBER_LIST] 'Y', '1', '" & strGroupCode & "', '" & intPageSize & "', '" & intPage & "', '" & strGradeCode & "', '" & intLevel & "', '" & searchMode & "', '" & searchText & "' ")
	
			intTotalCount = RS(0)
	
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_GROUP_MEMBER_LIST] 'N', '1', '" & strGroupCode & "', '" & intPageSize & "', '" & intPage & "', '" & strGradeCode & "', '" & intLevel & "', '" & searchMode & "', '" & searchText & "' ")

		CASE "list2"

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_GROUP_MEMBER_LIST] 'Y', '2', '" & strGroupCode & "', '" & intPageSize & "', '" & intPage & "', '" & strGradeCode & "', '" & intLevel & "', '" & searchMode & "', '" & searchText & "' ")
	
			intTotalCount = RS(0)
	
			SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_GROUP_MEMBER_LIST] 'N', '2', '" & strGroupCode & "', '" & intPageSize & "', '" & intPage & "', '" & strGradeCode & "', '" & intLevel & "', '" & searchMode & "', '" & searchText & "' ")

		END SELECT

		RESPONSE.WRITE "["
	
		WHILE NOT(RS.EOF)
	
			iCount = iCount + 1
			intNumber = INT(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
	
			IF iCount > 1 THEN RESPONSE.WRITE ","

			RESPONSE.WRITE "{""total"":""" & intTotalCount & """, ""seq"":""" & RS("intSeq") & """, ""number"":""" & intNumber & """, ""groupname"":""" & RS("strGroupname") & """, ""level"":""" & RS("intLevel") & """, ""userid"":""" & RS("strLoginID") & """, ""username"":""" & RS("strUserName") & """, ""nickname"":""" & RS("strNickName") & """, ""regdate"":""" & REPLACE(LEFT(RS("strRegDate"),10), "-", ".") & """, ""visitdate"":"""

			IF ISNULL(RS("strVisitDate")) = False THEN RESPONSE.WRITE REPLACE(LEFT(RS("strVisitDate"),10), "-", ".") ELSE RESPONSE.WRITE "-"
			RESPONSE.WRITE """, ""visit"":""" & RS("intVisit") & """}" & CHR(10)

		RS.MOVENEXT
		WEND

		RESPONSE.WRITE "]"

	CASE "page1", "page2"

		SELECT CASE pageMode
		CASE "page1"

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_GROUP_MEMBER_LIST] 'Y', '1', '" & strGroupCode & "', '" & intPageSize & "', '" & intPage & "', '" & strGradeCode & "', '" & intLevel & "', '" & searchMode & "', '" & searchText & "' ")

			intTotalCount = RS(0)
			intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
	
			RESPONSE.WRITE GetPageHTML(intPage, intPageCount, objXmlLang("text_prevpage"), objXmlLang("text_nextpage"), "goPage1")
	
		CASE "page2"

			SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_GROUP_MEMBER_LIST] 'Y', '2', '" & strGroupCode & "', '" & intPageSize & "', '" & intPage & "', '" & strGradeCode & "', '" & intLevel & "', '" & searchMode & "', '" & searchText & "' ")
			
			intTotalCount = RS(0)
			intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
	
			RESPONSE.WRITE GetPageHTML(intPage, intPageCount, objXmlLang("text_prevpage"), objXmlLang("text_nextpage"), "goPage2")

		END SELECT
	
	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET objRoot = NOTHING : SET rootNode = NOTHING
%>
