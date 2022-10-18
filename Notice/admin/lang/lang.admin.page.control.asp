<%
	xmlDOM.Load langXmlPath & "lang\" & CONF_strLangType & "\" & langXmlFile

	SET rootNode = xmlDOM.selectNodes(LCASE("/root"))

	DIM objXmlLang
	SET objXmlLang = Server.CreateObject("Scripting.Dictionary")

	WITH objXmlLang

		FOR firstLoop = 0 To rootNode(0).childNodes.Length-1

			SELECT CASE LCASE(rootNode(0).childNodes(firstLoop).nodename)
			CASE "title", "contents", "options"
				FOR secondLoop = 0 TO rootNode(0).childNodes(firstLoop).childNodes.length - 1
					IF LCASE(rootNode(0).childNodes(firstLoop).nodename) = "options" THEN
						.Add rootNode(0).childNodes(firstLoop).childNodes(secondLoop).getAttribute("name"), rootNode(0).childNodes(firstLoop).childNodes(secondLoop).getAttribute("val") & "$$$" & rootNode(0).childNodes(firstLoop).childNodes(secondLoop).text
					ELSE
						.Add rootNode(0).childNodes(firstLoop).childNodes(secondLoop).getAttribute("name"), rootNode(0).childNodes(firstLoop).childNodes(secondLoop).text
					END IF
				NEXT
			END SELECT
	
		NEXT

		xmlDOM.Load langXmlPath & "lang\" & CONF_strLangType & "\lang.comm.btn.xml"
		SET rootNode = xmlDOM.selectNodes(LCASE("/root"))

		FOR firstLoop = 0 TO rootNode(0).childNodes.length - 1
			.Add rootNode(0).childNodes(firstLoop).getAttribute("name"), rootNode(0).childNodes(firstLoop).text
		NEXT

	END WITH
%>