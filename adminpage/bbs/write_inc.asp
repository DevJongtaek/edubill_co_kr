<table width="744" border=0 cellspacing="0" cellpadding="0">
	<tr>
		<td align="right">&nbsp;</td>
	</tr>
	<tr>
		<td>

		<table width="744" border="0" cellspacing="0" cellpadding="0">

<script language="javascript">
<!--
function sendit() 
{
	if (eumsearch.name.value=="") {
		alert("이름을 입력하여 주시기바랍니다.") ;
		eumsearch.name.focus() ;
		return false ;
	}if (eumsearch.title.value=="") {
		alert("제목을 입력하여 주시기바랍니다.") ;
		eumsearch.title.focus() ;
		return false ;
	}if (eumsearch.content.value=="") {
		alert("내용을 입력하여 주시기바랍니다.") ;
		eumsearch.content.focus() ;
		return false ;
//	}if (eumsearch.pwd.value=="") {
//		alert("비밀번호를 입력하여 주시기바랍니다.") ;
//		eumsearch.pwd.focus() ;
//		return false ;
	}
	document.all("btn1").disabled = true;
	eumsearch.submit() ;
}
//-->
</script>

<form name="eumsearch" method="post" action="writeok.asp" ENCTYPE="MULTIPART/FORM-DATA">
<input type=hidden name=gotopage value="<%=gotopage%>">
<input type=hidden name=uid value="<%=uid%>">
<input type=hidden name=searcha value="<%=searcha%>">
<input type=hidden name=searchb value="<%=searchb%>">

<input type="hidden" name="idx" value="<%=Request("idx")%>">
<input type="hidden" name="ref" value="<%=request("ref")%>">
<input type="hidden" name="re_step" value="<%=request("re_step")%>">
<input type="hidden" name="re_level" value="<%=request("re_level")%>">

			<tr>
                        	<td width="664" height="27">

				<table width="744" border="0" cellpadding="5" cellspacing="1" bgcolor="4da4f0">
					<tr>
                                		<td width="120" align="center" bgcolor="99c6f9"><font color="ffffff"><strong>이름</strong></font></td>
                                		<td bgcolor="#FFFFFF"><input type="text" name="name" value="<%if uid<>"agencyboard" then%>관리자<%end if%>" maxlength="10" size="40" style="border:1 solid #C7C7C7;back-color :black;"></td>
                        		</tr>
                        		<tr>
                                		<td width="120" align="center" bgcolor="99c6f9"><font color="ffffff"><strong>이메일</strong></font></td>
                                		<td bgcolor="#FFFFFF"><input type="text" name="email" value="" size="40" style="border:1 solid #C7C7C7;back-color :black;"></td>
                        		</tr>
                        		<tr>
                                		<td align="center" bgcolor="99c6f9"><font color="ffffff"><strong>제목</strong></font></td>
                                		<td bgcolor="#FFFFFF"><input type="text" name="title" value="<%=title%>" size="75" style="border:1 solid #C7C7C7;back-color :black;"></td>
                        		</tr>
                        		<tr>
                                		<td align="center" bgcolor="99c6f9"><font color="ffffff"><strong>내용</strong><BR>HTML</font><input type=checkbox name=hflag value="1"></td>
                                		<td bgcolor="#FFFFFF"><textarea name="content" cols="75" rows="15" style="border:1 solid #C7C7C7;back-color :black;"><%=content%></textarea></td>
	                       		</tr>
                        		<tr>
                                		<td align="center" bgcolor="99c6f9"><font color="ffffff"><strong>파일1</strong></font></td>
                                		<td bgcolor="#FFFFFF"><input type="file" name="bfile1" size="55" style="border:1 solid #C7C7C7;back-color :black;"></td>
                        		</tr>
                        		<tr>
                                		<td align="center" bgcolor="99c6f9"><font color="ffffff"><strong>파일2</strong></font></td>
                                		<td bgcolor="#FFFFFF"><input type="file" name="bfile2" size="55" style="border:1 solid #C7C7C7;back-color :black;"></td>
                        		</tr>
<%if uid="agencyboard" then%>
                        		<tr>
                                		<td align="center" bgcolor="99c6f9"><font color="ffffff"><strong>비밀번호</strong></font></td>
                                		<td bgcolor="#FFFFFF"><input type="password" name="pwd" value="<%=pwd%>" maxlength="4" size="10" style="border:1 solid #C7C7C7;back-color :black;"></td>
					</tr>
<%end if%>
				</table>

				</td>
			</tr>
        		<tr>
        			<td height="50" align="center"><input type=image src="/images/cus/bt_write_ok.gif" width="73" height="22" name="btn1" border=0 onclick="return sendit(this.form);">&nbsp; <a href="javascript:history.back();"><img src="/images/cus/bt_write_can.gif" width="73" height="22" border=0></a></td>
			</tr>
		</table>

		</td>
	</tr>

</form>

</table>

