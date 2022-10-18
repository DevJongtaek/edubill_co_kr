<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "function.asp" -->
<%
	DIM filetype, filename, userpath, intSrl

	WITH REQUEST

		filetype = GetInputReplce(.FORM("filetype"), "")
		filename = GetInputReplce(.FORM("filename"), "")
		userpath = REPLACE(GetInputReplce(.FORM("userpath"), ""), "/", "\")
		intSrl   = GetInputReplce(.FORM("intSrl"), "")

	END WITH

	DIM strPath
	strPath = SERVER.MAPPATH("../" & CONF_strFilePath) & "\"
	strPath = strPath & userpath

	SELECT CASE filetype
	CASE "image"
		IF intSrl <> "" THEN CALL ActFileDelete(strPath & "thrum\" & filename)
		CALL ActFileDelete(strPath & filename)
	CASE "file"
		CALL ActFileDelete(strPath & filename)
	CASE "files"
	END SELECT
%>