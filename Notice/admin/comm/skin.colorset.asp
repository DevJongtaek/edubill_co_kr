<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM skin, folder, strSkinColor, skinXmlFile, intSrl
	skin   = GetInputReplce(REQUEST.FORM("skin"), "")
	folder = GetInputReplce(REQUEST.FORM("folder"), "")
	intSrl = GetInputReplce(REQUEST.FORM("intSrl"), "")

	DIM xmlDOM, objRoot, firstLoop, rootNode, iCount, skinName, skinSrc, skinTitle

	Set xmlDOM = Server.CreateObject("Microsoft.XMLDOM")
	xmlDOM.async = false

	SELECT CASE skin
	CASE "member"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_CONFIG_READ] ")
		strSkinColor = RS("strSkinColor")

	CASE "board"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_READ] '" & intSrl & "' ")

		IF NOT(RS.EOF) THEN
			strSkinColor = RS("strSkinColor")
		ELSE
			strSkinColor = "white"
		END IF

	CASE "search"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_SEARCH_CONFIG] ")

		strSkinColor = RS("strSkinColor")

	END SELECT

	skinXmlFile = Server.MapPath("../../skin/") & "\" & skin & "\" & folder & "\skin.xml"

	xmlDOM.Load skinXmlFile
	Set objRoot = xmlDOM.documentElement

	SET rootNode = xmlDOM.selectNodes(LCASE("/skin/colors"))

	RESPONSE.WRITE "<div class=""skinColorSetList"">" & CHR(10)

	iCount = 0

	FOR firstLoop = 0 TO rootNode(0).childNodes.length - 1
		iCount = iCount + 1
		skinName  = rootNode(0).childNodes(firstLoop).getAttribute("name")
		skinSrc   = rootNode(0).childNodes(firstLoop).getAttribute("src")

		FOR secondLoop = 0 TO rootNode(0).childNodes(firstLoop).childNodes.length - 1

			IF CONF_strLangType = rootNode(0).childNodes(firstLoop).childNodes(secondLoop).getAttribute("lang") THEN skinTitle = rootNode(0).childNodes(firstLoop).childNodes(secondLoop).text

		NEXT

		IF skinTitle = "" THEN skinTitle = rootNode(0).childNodes(firstLoop).childNodes(0).text

		IF iCount = 1 THEN RESPONSE.WRITE "	<ul>" & CHR(10)

		RESPONSE.WRITE "		<li>" & CHR(10)
		RESPONSE.WRITE "			<dl>" & CHR(10)
		RESPONSE.WRITE "				<dd>" & CHR(10)
		RESPONSE.WRITE "		<input type=""radio"" name=""strSkinColor"" id=""strSkinColor" & firstLoop & """ value=""" & skinName & """"
		IF strSkinColor = skinName THEN RESPONSE.WRITE " checked"
		RESPONSE.WRITE "><LABEL FOR=""strSkinColor" & firstLoop & """>" & skinTitle & "</LABEL>" & CHR(10)
		RESPONSE.WRITE "				</dd>" & CHR(10)
		RESPONSE.WRITE "				<dd>" & CHR(10)
		RESPONSE.WRITE "		<img src=""../skin/" & skin & "/" & folder & "/" & skinSrc & """>" & CHR(10)
		RESPONSE.WRITE "				<dd>" & CHR(10)
		RESPONSE.WRITE "			</dl>" & CHR(10)
		RESPONSE.WRITE "		</li>" & CHR(10)

		IF iCount = 2 THEN
			iCount = 0
			RESPONSE.WRITE "	</ul>" & CHR(10)
		END IF

	NEXT

	RESPONSE.WRITE "</div>" & CHR(10)

	SET RS = NOTHING : DBCON.CLOSE
%>
<script type="text/javascript">

	$("input:checkbox").checkbox();
	$("input:radio").checkbox({cls:"jquery-radio"});

</script>