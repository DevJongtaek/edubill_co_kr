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
                                		<td width="120" align="center" bgcolor="bfbfbf"><font color="7b7b7b"><strong>累己磊</strong></font></td>
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
                                		<td width="120" align="center" bgcolor="bfbfbf"><font color="7b7b7b"><strong>梅何颇老1</strong></font></td>
                                		<td bgcolor="#FFFFFF"><a href="down.asp?f_name=<%=imsib_file1%>"><strong><%=imsib_file1%></strong></a></td>
					</tr>
                              		<tr>
                                		<td width="120" align="center" bgcolor="bfbfbf"><font color="7b7b7b"><strong>梅何颇老2</strong></font></td>
                                		<td bgcolor="#FFFFFF"><a href="down.asp?f_name=<%=imsib_file1%>"><strong><%=imsib_file2%></strong></a></td>
					</tr>
                              		<tr>
                                		<td width="120" align="center" bgcolor="bfbfbf"><font color="7b7b7b"><strong>力格</strong></font></td>
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
	alert("肺弊牢饶 荤侩窍技夸!!") ;
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

<a href="list_root.asp?uid=<%=uid%>&gotopage=<%=gotopage%>&searcha=<%=searcha%>&searchb=<%=searchb%>"><img src="/images/cus/bt_list.gif" width="98" height="22" border="0"></a>

<%if uid="agencyboard" then%>
	<%if session("AAtcode")="0000" then%>
		<!--<input type=image img src="/images/cus/bt_reply.gif" onclick="javascript:replychecked()" alt="翠函">-->
		<a href="edit.asp?idx=<%=idx%>&uid=<%=uid%>&gotopage=<%=gotopage%>&searcha=<%=searcha%>&searchb=<%=searchb%>"><img src="/images/cus/bt_modi.gif" width="73" height="22" border="0"></a>
		<a href="#" onclick="javascript:return deleteok(this.form);"><img src="/images/cus/bt_del.gif" width="73" height="22" border=0></a>
	<%end if%>
<%else%>
	<!--<input type=image img src="/images/cus/bt_reply.gif" onclick="javascript:replychecked()" alt="翠函">-->
	<a href="edit.asp?idx=<%=idx%>&uid=<%=uid%>&gotopage=<%=gotopage%>&searcha=<%=searcha%>&searchb=<%=searchb%>"><img src="/images/cus/bt_modi.gif" width="73" height="22" border="0"></a>
	<a href="#" onclick="javascript:return deleteok(this.form);"><img src="/images/cus/bt_del.gif" width="73" height="22" border=0></a>
<%end if%>

				</td>
          		</tr>
		</table>

		</td>
	</tr>

</form>

</table>