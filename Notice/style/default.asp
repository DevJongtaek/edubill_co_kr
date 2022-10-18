<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../libs/function.asp" -->
<%
	Response.ContentType = "text/css"

	DIM strSkinPath, strStyleFile, strStyleText, strChangePath, strChangeText

	strSkinPath   = REQUEST.QueryString("strSkinPath")
	strStyleFile  = REQUEST.QueryString("strStyleFile")
	strChangePath = REPLACE(LCASE(Request.ServerVariables("PATH_INFO")), "style/default.asp", "") & "skin/" & strSkinPath

	strStyleText = GetReadFromTextFile(GetNowFolderPath("../") & "\skin\" & REPLACE(strSkinPath, "/", "\") & REPLACE(strStyleFile, "/", "\"),"utf-8")

	SET regEx = New RegExp

	regEx.IgnoreCase = True
	regEx.Global = True 
	regEx.Pattern = "[^= ' ""(]*\.(gif|jpg|bmp|png)"

	SET Matches = regEx.Execute(strStyleText)

	DIM regStr

	FOR EACH Match IN Matches

		IF regStr <> "" THEN regStr = regStr & ","
		regStr = regStr & Match.Value

	NEXT

	strChangeText = GetStrDuplication(LCASE(regStr))

	DIM tmpFor

	IF strChangeText <> "" THEN
		strChangeText = SPLIT(strChangeText, ",")
		FOR tmpFor = 0 TO UBOUND(strChangeText)
			strStyleText = REPLACE(strStyleText, strChangeText(tmpFor), strChangePath & strChangeText(tmpFor))
		NEXT
	END IF

	RESPONSE.WRITE strStyleText
%>