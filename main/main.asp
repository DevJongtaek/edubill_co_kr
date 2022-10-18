
 <title>::: 에듀빌 :::</title>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<link href="../css/common.css" type="text/css" rel="stylesheet"  media="screen" />
<script language="javascript">
    function noticecloseWin() {
        alert('');
	document.all['notice'].style.display = "none";
  }
</script>

<!--#include virtual="/db/db.asp" -->
<%
	set rslist = server.CreateObject("ADODB.Recordset")
	SQL = " select content,flag,hflag,wsize,hsize"
	SQL = sql & " from tb_gongi where loginflag = '1' "
	rslist.Open sql, db, 1
	if not rslist.eof then
		imsicontent = rslist(0)
		imsiflag = rslist(1)
		imsihflag = rslist(2)
		imsiwsize = rslist(3)
		imsihsize = rslist(4)

		'if imsiflag="y" then
%>
		

<%
	end if
	rslist.close
	db.close
%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
 <tr>
     <td><!--#include virtual = '/inc/main_center.asp'--></td>
 </tr>
</table>


</body>
</html>
