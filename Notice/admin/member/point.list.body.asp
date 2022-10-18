<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM langXmlPath, langXmlFile

	langXmlPath = Server.MapPath("../") & "\"
	langXmlFile = "lang.member.point.xml"

	DIM xmlDOM, objRoot, firstLoop, secondLoop, thirdLoop

	Set xmlDOM = Server.CreateObject("Microsoft.XMLDOM")
	xmlDOM.async = false
%>
<!-- #include file = "../lang/lang.admin.page.control.asp" -->
<%
	DIM pageMode, intPage, intPageSize, intTotalCount, intPageCount, strSortID, strSordDsc, searchMode, searchText
	DIM intYear, intMonth, intDay, pointType

	WITH REQUEST

		pageMode    = LCASE(GetInputReplce(.FORM("pageMode"), ""))
		intPage     = GetInputReplce(.FORM("intPage"), False)
		intPageSize = GetInputReplce(.FORM("intPageSize"), False)
		strSortID   = LCASE(GetInputReplce(.FORM("sortid"), ""))
		strSordDsc  = LCASE(GetInputReplce(.FORM("sortdsc"), ""))
		searchMode  = GetInputReplce(.FORM("searchMode"), "")
		searchText  = GetInputReplce(.FORM("searchText"), "")
		intYear     = GetInputReplce(.FORM("intYear"), "")
		intMonth    = GetInputReplce(.FORM("intMonth"), "")
		intDay      = GetInputReplce(.FORM("intDay"), "")
		pointType   = GetInputReplce(.FORM("pointType"), "")

	END WITH

	IF pageMode = "" THEN pageMode = "list"
	IF isNumeric(intPage) = False THEN intPage = ""
	IF intPage = "" THEN intPage = 1
	IF isNumeric(intPageSize) = False THEN intPageSize = ""
	IF intPageSize = "" THEN intPageSize = 15

	IF isNumeric(intYear)  = False THEN intYear  = ""
	IF isNumeric(intMonth) = False THEN intMonth = ""
	IF isNumeric(intDay)   = False THEN intDay   = ""

	SELECT CASE strSortID
	CASE "threg"     : strSortID = "strRegDate"
	CASE "thpoint"   : strSortID = "intPoint"
	CASE ELSE : strSortID = ""
	END SELECT

	SELECT CASE strSordDsc
	CASE "dsc" : strSordDsc = "DESC"
	CASE "asc" : strSordDsc = "ASC"
	CASE ELSE : strSordDsc = ""
	END SELECT

	SELECT CASE pageMode
	CASE "list"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_POINT_LIST] 'Y', '" & intPageSize & "', '" & intPage & "', '" & strSortID & "', '" & strSordDsc & "', '" & searchMode & "', '" & searchText & "', '" & intYear & "', '" & intMonth & "', '" & intDay & "', '" & pointType & "' ")

		intTotalCount = RS(0)

		SET RS = DBCON.EXECUTE("[ARTY30_SP_POINT_LIST] 'N', '" & intPageSize & "', '" & intPage & "', '" & strSortID & "', '" & strSordDsc & "', '" & searchMode & "', '" & searchText & "', '" & intYear & "', '" & intMonth & "', '" & intDay & "', '" & pointType & "' ")

		DIM iCount, intNumber
		iCount = 0

		RESPONSE.WRITE "["
	
		WHILE NOT(RS.EOF)
	
			iCount = iCount + 1
			intNumber = INT(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
	
			IF iCount > 1 THEN RESPONSE.WRITE ","

			RESPONSE.WRITE "{""total"":""" & intTotalCount & """, ""number"":""" & intNumber & """, ""seq"":""" & RS("intSeq") & """, ""userid"":""" & RS("strLoginID") & """, ""username"":""" & RS("strUserName") & """, ""nickname"":""" & RS("strNickName") & """, ""point"":""" & FormatNumber(RS("intPoint"), 0) & """, ""description"":""" & RS("strDescription") & """, ""regdate"":""" & REPLACE(LEFT(RS("strRegDate"),10), "-", ".") & """}" & CHR(10)

		RS.MOVENEXT
		WEND

		RESPONSE.WRITE "]"

	CASE "page"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_POINT_LIST] 'Y', '" & intPageSize & "', '" & intPage & "', '" & strSortID & "', '" & strSordDsc & "', '" & searchMode & "', '" & searchText & "', '" & intYear & "', '" & intMonth & "', '" & intDay & "', '" & pointType & "' ")
	
		intTotalCount = RS(0)
		intPageCount = INT((intTotalCount - 1) / intPageSize) + 1

		RESPONSE.WRITE GetPageHTML(intPage, intPageCount, objXmlLang("text_prevpage"), objXmlLang("text_nextpage"), "goPage")

	END SELECT

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET objRoot = NOTHING : SET rootNode = NOTHING
%>
