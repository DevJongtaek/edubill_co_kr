<% page_num_depth_01 = "1" %>
<% page_num_depth_02 = "3" %>
<!--#include virtual="/db/Noticedb.asp" -->

<!--#include virtual = '/inc/header.asp'-->

<body>
<!--top-->
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="left">
<!--#include virtual = '/inc/sub_top.asp'-->
    </td>
  </tr>
</table>
<!--/top-->

<!--������-->
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr valign="top"> 
    <td width="242">
<!--#include virtual = '/customer/left_menu.asp'-->
    </td>
    <td><!--Ÿ��Ʋ--><table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom:30">
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="300" height="40" align="left"><img src="../images/customer/title_01.gif" width="106" height="26" /></td>
                <td align="right" valign="middle"><img src="../images/common/b_1.gif" width="10" height="9" />&nbsp;HOME&nbsp;<img src="../images/common/b_2.gif" width="3" height="10" />&nbsp;��������
&nbsp;<img src="../images/common/b_2.gif" width="3" height="10" /><span class="style1"> 
                  <strong>���ñ��

</strong></span></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="144" height="1" bgcolor="327bc7"></td>
                <td height="1" bgcolor="c7c7c7"></td>
              </tr>
            </table></td>
        </tr>
      </table>
      <!--/Ÿ��Ʋ-->
	  <!--�������-->

	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td height="300" align="center" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td height="300" align="center" valign="top">
	
<%
	searcha = Replace(request("searcha"), "'", "")
	searchb = Replace(request("searchb"), "'", "")
	GotoPage = Replace(Request("GotoPage"), "'", "")
	uid = Replace(request("uid"), "'", "")
	idx = Replace(Replace(Replace(request("idx"), "'", ""), "^4*7@5!", ""), "!2@3^4", "")

  	tablename = " tb_rhdwltkgkf "

	updatesql="update "& tablename &" set readnum=readnum+1 , areaddate = '"& now() &"' where idx="&idx
	noticedb.Execute(updatesql)

	set rs = server.CreateObject("ADODB.Recordset")
	SQL = "SELECT * FROM "& tablename &" where idx = "& idx
	rs.Open sql, noticedb, 1

	ref=rs("ref")
	re_step=rs("re_step")
	re_level=rs("re_level")

	imsinows = rs("nows")
	imsireadnum = rs("readnum")
	tottitlef = "("&imsinows&", Hit "&imsireadnum&")"
	tottitlef2 = imsinows&", Hit "&imsireadnum
	imsititle = rs("title")
	imsiname = rs("name")
	imsihflag = rs("hflag")
	imsicontent = rs("content")
	if imsihflag="0" then
		imsicontent = Replace(imsicontent,chr(13),"<br>")
	end if
	imsib_file1 = rs("b_file1")
	imsib_file1_width = rs("b_file1_width")
	imsib_file2 = rs("b_file2")
	imsib_file2_width = rs("b_file2_width")
	userid = rs("userid")

	rs.close
%>
<table width="744" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="right">&nbsp;</td>
	</tr>
	<tr>
		<td>

		<table width="744" border="0" cellspacing="0" cellpadding="0">
			<tr>
                          	<td height="27" colspan="3">

				<table width="744" border="0" cellpadding="5" cellspacing="1" bgcolor="7b7b7b">
					<tr>
                                		<td width="120" align="center" bgcolor="bfbfbf"><font color="7b7b7b"><strong>�ۼ���</strong></font></td>
                                		<td bgcolor="#FFFFFF">

						<table width="98%" border="0" cellpadding="0" cellspacing="0">
  							<tr> 
    								<td width="60%" height="20" class="basic">&nbsp;<B><%=imsiname%></td>
    								<td width="40%" class="basic" align=right><%=tottitlef%></td>
							</tr>
						</table>

						</td>
                              		</tr>
                              		<tr>
                                		<td width="120" align="center" bgcolor="bfbfbf"><font color="7b7b7b"><strong>÷������1</strong></font></td>
                                		<td bgcolor="#FFFFFF"><a href="down.asp?f_name=<%=imsib_file1%>"><strong><%=imsib_file1%></strong></a></td>
					</tr>
                              		<tr>
                                		<td width="120" align="center" bgcolor="bfbfbf"><font color="7b7b7b"><strong>÷������2</strong></font></td>
                                		<td bgcolor="#FFFFFF"><a href="down.asp?f_name=<%=imsib_file1%>"><strong><%=imsib_file2%></strong></a></td>
					</tr>
                              		<tr>
                                		<td width="120" align="center" bgcolor="bfbfbf"><font color="7b7b7b"><strong>����</strong></font></td>
                                		<td bgcolor="#FFFFFF"><strong><%=imsititle%></strong></td>
					</tr>
                            	</table>

				</td>
			</tr>
                        <tr>
                          	<td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                          	<td width="15"><p>&nbsp; </p></td>
				<td width="634">

<%if imsib_file1<>"" then%>
<%
	select case ucase(right(imsib_file1,3))
		case "gif","jpg","jpeg","JPG","JPEG","GIF"

			if int(imsib_file1_width) <= 630 then
				response.write "<img src=/fileupdown/pds/"&imsib_file1&" border=0>"
			else
				response.write "<img src=/fileupdown/pds/"&imsib_file1&" border=0 width=630>"
			end if

	end select
%>
	<BR>
<%end if%>

<%if imsib_file2<>"" then%>
<BR>
<%
	select case ucase(right(imsib_file2,3))
		case "gif","jpg","jpeg","JPG","JPEG","GIF"

			if int(imsib_file2_width) <= 630 then
				response.write "<img src=/fileupdown/pds/"&imsib_file2&" border=0>"
			else
				response.write "<img src=/fileupdown/pds/"&imsib_file2&" border=0 width=630>"
			end if

	end select
%>
	<BR>
<%end if%>

<p><%=imsicontent%></p>

				</td>
                          	<td width="15">&nbsp;</td>
                        </tr>
                        <tr>
                          	<td colspan="3">&nbsp;</td>
                        </tr>
                        <tr>
                          	<td height="2" colspan="3" background="/images/cus/board_btbg.gif"></td>
                        </tr>

<SCRIPT LANGUAGE="JavaScript">
<!--
function replychecked() {
	document.writeform.submit();
}

function deleteok() {
	writeform.action = "bdelete.asp";
	writeform.submit() ;
	return false ;
}

function checkid()
{
	alert("�α����� ����ϼ���!!") ;
}
//-->		
</script>

<form name="writeform" method="post" action="write.asp">
<input type="hidden" name="uid" value="<%=uid%>">
<input type="hidden" name="gotopage" value="<%=gotopage%>">
<input type="hidden" name="idx" value="<%=idx%>">
<input type="hidden" name="re_step" value="<%=re_step%>">
<input type="hidden" name="re_level" value="<%=re_level%>">
<input type="hidden" name="ref" value="<%=ref%>">

			<tr>
            			<td height="50" align="center" colspan="3">

<a href="customer03.asp?uid=<%=uid%>&gotopage=<%=gotopage%>"><img src="/images/cus/bt_list.gif" width="98" height="22" border="0"></a>


				</td>
          		</tr>
		</table>

		</td>
	</tr>

</form>

</table>

			</td>
	        </tr>
	      </table></td>
	  </tr>
	  </table><!--/�������--></td>
  </tr>
</table>
<!--/������-->


<!--bottom-->
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><!--#include virtual = '/inc/foot.asp'--></td>
  </tr>
</table>
<!--/bottom-->
</body>
</html>