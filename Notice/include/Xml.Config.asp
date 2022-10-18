<%
	DIM xmlDOM, rootNode, firstLoop, secondLoop, thirdLoop, tmpFor
	Set xmlDOM = Server.CreateObject("Microsoft.XMLDOM")
	xmlDOM.async = false

	xmlDOM.Load Server.MapPath(".") & "\lang\" & "lang." & CONF_strSkinLang & ".xml"
	SET rootNode = xmlDOM.selectNodes(LCASE("/root"))

	DIM objXmlLang
	SET objXmlLang = Server.CreateObject("Scripting.Dictionary")

	WITH objXmlLang

		FOR firstLoop = 0 To rootNode(0).childNodes.Length - 1

			IF LEFT(LCASE(rootNode(0).childNodes(firstLoop).getAttribute("name")), 7) = "option_" THEN
				.Add rootNode(0).childNodes(firstLoop).getAttribute("name"), rootNode(0).childNodes(firstLoop).getAttribute("val") & "$$$" & rootNode(0).childNodes(firstLoop).text
			ELSE
				.Add rootNode(0).childNodes(firstLoop).getAttribute("name"), rootNode(0).childNodes(firstLoop).text
			END IF

		NEXT

	END WITH

	xmlDOM.Load xmlPath
	SET rootNode = xmlDOM.selectNodes(LCASE("/root"))

	WITH objXmlLang

		FOR firstLoop = 0 To rootNode(0).childNodes.Length - 1
			.Add rootNode(0).childNodes(firstLoop).getAttribute("name"), rootNode(0).childNodes(firstLoop).text
		NEXT

	END WITH
%>