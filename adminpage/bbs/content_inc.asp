<table width="744" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="right">&nbsp;</td>
	</tr>
	<tr>
		<td>

		<table width="744" border="0" cellspacing="0" cellpadding="0">
			<tr>
                          	<td height="27" colspan="3">

				<table width="744" border="0" cellpadding="5" cellspacing="1" bgcolor="bfbfbf">
					<tr>
                                		<td width="120" align="center" bgcolor="bfbfbf"><font color="ffffff"><strong>작성자</strong></font></td>
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
                                		<td width="120" align="center" bgcolor="99c6f9"><font color="ffffff"><strong>첨부파일1</strong></font></td>
                                		<td bgcolor="#FFFFFF"><a href="down.asp?f_name=<%=imsib_file1%>"><strong><%=imsib_file1%></strong></a></td>
					</tr>
                              		<tr>
                                		<td width="120" align="center" bgcolor="99c6f9"><font color="ffffff"><strong>첨부파일2</strong></font></td>
                                		<td bgcolor="#FFFFFF"><a href="down.asp?f_name=<%=imsib_file1%>"><strong><%=imsib_file2%></strong></a></td>
					</tr>
                              		<tr>
                                		<td width="120" align="center" bgcolor="99c6f9"><font color="ffffff"><strong>제목</strong></font></td>
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
	alert("로그인후 사용하세요!!") ;
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

<a href="list.asp?uid=<%=uid%>&gotopage=<%=gotopage%>&searcha=<%=searcha%>&searchb=<%=searchb%>"><img src="/images/cus/bt_list.gif" width="98" height="22" border="0"></a>


				</td>
          		</tr>
		</table>

		</td>
	</tr>

</form>

</table>