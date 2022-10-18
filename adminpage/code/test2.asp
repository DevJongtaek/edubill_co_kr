<%
'	Set fs = Server.CreateObject("Scripting.FileSystemObject")
'	fs.CreateTextFile "D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\regmake\" & imsifilename & ".txt",true 
'	Set objFile = fs.OpenTextFile("D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\regmake\" & site.log,8) 
'
'	Read(i)
'
'	imsiwriteline = f1&f2&f3&f4&f5&f6&f7&f8&f9&f10&f11
'	objFile.writeLine(imsiwriteline)
'	imsitxtcount = imsitxtcount+1
'
'	objFile.close





	Set fs = Server.CreateObject("Scripting.FileSystemObject")
	Set objFile = fs.OpenTextFile("D:\Webhosting\2004VIVA\edubill_co_kr_new\fileupdown\regmake\site.log",1) 

	i=0
	Do While objFile.AtEndOfStream <> True
		'Response.write objFile.readLine & "<br>"
		i=i+1
	loop



%>

