<%
	DIM isStaffCheck
%>
<!-- #include file = "staff.check.log.asp" -->
<%
' jQuery File Tree ASP (VBS) Connector
' Copyright 2008 Chazzuka
' programmer@chazzuka.com
' http://www.chazzuka.com/

IF isStaffCheck = True THEN

	DIM BaseFileDir
	BaseFileDir = REQUEST.FORM("dir")

	IF LEN(BaseFileDir) = 0 THEN BaseFileDir = "/"

	DIM ObjFSO,BaseFile,Html

	BaseFile = Server.MapPath(BaseFileDir) & "\"

	Set ObjFSO = Server.CreateObject("Scripting.FileSystemObject")

	IF ObjFSO.FolderExists(BaseFile) THEN

		DIM ObjFolder, ObjSubFolder, ObjFile, i__Name, i__Ext
		Html = Html +  "<ul class=""jqueryFileTree"" style=""display: none;"">" & vbCrlf

		SET ObjFolder = ObjFSO.GetFolder(BaseFile)

		FOR EACH ObjSubFolder IN ObjFolder.SubFolders
			i__Name=ObjSubFolder.name
			Html = Html + "<li class=""directory collapsed"">"&_
										"<a href=""#"" rel="""+(BaseFileDir+i__Name+"/")+""">"&_
										(i__Name)+"</a></li>" & vbCrlf
		NEXT

		FOR EACH ObjFile IN ObjFolder.Files
			i__Name=ObjFile.name
			i__Ext = LCase(Mid(i__Name, InStrRev(i__Name, ".", -1, 1) + 1))

			IF LCASE(i__Ext) = "asp" THEN
				Html = Html + "<li class=""file ext_"&i__Ext&""">"&_
											"<a href=""#"" rel="""+(BaseFileDir+i__Name)+""">"&_
											(i__name)+"</a></li>" & vbCrlf
			END IF
		NEXT

		Html = Html +  "</ul>"&VBCRLF
	END IF

	Response.Write Html

END IF
%>