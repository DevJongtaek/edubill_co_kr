<%
	DIM UPLOAD
	SELECT CASE LCASE(CONF_strUploadComponet)
	CASE "abc"
		SET UPLOAD = SERVER.CREATEOBJECT("ABCUpload4.XForm")
		UPLOAD.AbsolutePath = True
		UPLOAD.MaxUploadSize = 524288000
		UPLOAD.Overwrite = False
	CASE "dext"
		SET UPLOAD = SERVER.CREATEOBJECT("DEXT.FileUpload")
		UPLOAD.DefaultPath = strPath
	CASE "tabs"
		SET UPLOAD = Server.CreateObject("TABSUpload4.Upload")
		UPLOAD.START strPath
	END SELECT
%>