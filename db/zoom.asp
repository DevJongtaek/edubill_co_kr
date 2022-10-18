<%
	filename=request("filename")
	foldergbn=request("foldergbn")
%>

<html>
<head>
<title>::: 상품 이미지 보기 :::</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">

<style type="text/css">
    a:link    {font-size:11pt;  font-family:굴림,돋움,arial; color:"#0000FF"; text-decoration:none}
    a:visited {font-size:11pt;  font-family:굴림,돋움,arial; color:"#0000FF"; text-decoration:none}
    .text1    {font-size:10pt;  font-family:"굴림"; color:"#000000"; line-height: 13pt;}
</style>

<script language="JavaScript">

function ResizeWindow()
{
    window.resizeTo(document.GPhoto2.width + 60, document.GPhoto2.height + 80);
}

</script>

</head>

<body onload="javascript:ResizeWindow()">

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="100%" height="100%" align="center" valign="middle">
      <a href="javascript:close()">
      <img name="GPhoto2" src="/fileupdown/productimg/<%if foldergbn="1" then%>smallimg/<%elseif foldergbn="3" then%>middleimg/<%else%>bigimg/<%end if%><%=filename%>" border="0" alt="닫기">
      </a>
    </td>
  </tr>
</table>
</body>
</html>