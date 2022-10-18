<!-- #include file="db.asp"-->
<%
	pcode = request("pcode")

	set rs = server.CreateObject("ADODB.Recordset")
	sql= "select limage,limage2,limage3,limage4 from tb_product where pcode = '"& pcode &"' "
	rs.Open sql, Db, 1

	limage = rs(0)
	limage2 = rs(1)
	limage3 = rs(2)
	limage4 = rs(3)

	imsifilename = limage
	rs.close
%>

<html>
<head>
<title>제품사진 확대보기</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" href="/css/dog.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
<table width="574" border="0" cellspacing="0" cellpadding="0" height="511">
  <tr> 
    <td height="25" background="images2/bese1.gif">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="25">
        <tr> 
          <td width="1%">&nbsp;</td>
          <td width="3%"><img src="images2/products_icon1.gif" width="14" height="14"></td>
          <td width="96%" valign="middle">제품사진 확대보기 (* 오른쪽의 작은 그림을 클릭해 주세요.)</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td valign="top">
      <table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="999999" bordercolor="999999">
        <tr>
          <td height="443" bgcolor="#FFFFFF" width="474" align="center" valign="middle">

		<iframe name=sajinname width=400 height=400 marginwidth=0 marginheight=0 hspace=0 vspace=0 frameborder=0 scrolling=no src="photo.asp?filename=<%=imsifilename%>"></iframe>

	  </td>
          <td height="443" bgcolor="#FFFFFF" width="100" valign="top" align="right"> 


            <table width="100" border="0" cellspacing="0" cellpadding="0">
<%if limage <> "" then%>
              <tr> 
                <td><a href="photo.asp?filename=<%=limage%>" target=sajinname><img src="/fileupdown/productimg/bigimg/<%=limage%>" width="100" height="100" border=0></a></td>
              </tr>
              <tr> 
                <td><img src="images2/bin1.gif" width="100%" height="1"></td>
              </tr>
<%end if%>

<%if limage2 <> "" then%>
              <tr> 
                <td><a href="photo.asp?filename=<%=limage2%>" target=sajinname><img src="/fileupdown/productimg/bigimg/<%=limage2%>" width="100" height="100" border=0></a></td>
              </tr>
              <tr> 
                <td><img src="images2/bin1.gif" width="100%" height="1"></td>
              </tr>
<%end if%>

<%if limage3 <> "" then%>
              <tr> 
                <td><a href="photo.asp?filename=<%=limage3%>" target=sajinname><img src="/fileupdown/productimg/bigimg/<%=limage3%>" width="100" height="100" border=0></a></td>
              </tr>
              <tr> 
                <td><img src="images2/bin1.gif" width="100%" height="1"></td>
              </tr>
<%end if%>

<%if limage4 <> "" then%>
              <tr> 
                <td><a href="photo.asp?filename=<%=limage4%>" target=sajinname><img src="/fileupdown/productimg/bigimg/<%=limage4%>" width="100" height="100" border=0></a></td>
              </tr>
              <tr> 
                <td><img src="images2/bin1.gif" width="100%" height="1"></td>
              </tr>
<%end if%>

	      <tr>
		<td></td>
              </tr>
            </table>


          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td height="40" bgcolor="666666" align="center" valign="middle"><a href="#" onclick="javascript:window.close();"><img src="images2/products_botton1.gif" width="58" height="19" border=0></a></td>
  </tr>
</table>
</body>
</html>
