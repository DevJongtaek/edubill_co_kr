<!--#include virtual="/adminpage/bbs/top.asp" -->

<table width="744" border="0" cellpadding="5" cellspacing="1" bgcolor="D2D6AE">
					<tr>
                                		<td width="120" align="center" bgcolor="E9EDC1"><font color="8A8F5B"><strong>이름</strong></font></td>
                                		<td bgcolor="#FFFFFF"><input type="text" name="name" value="<%if uid<>"agencyboard" then%>관리자<%end if%>" maxlength="10" size="40" style="border:1 solid #C7C7C7;back-color :black;"></td>
                        		</tr>
                        		<tr>
                                		<td width="120" align="center" bgcolor="E9EDC1"><font color="8A8F5B"><strong>이메일</strong></font></td>
                                		<td bgcolor="#FFFFFF"><input type="text" name="email" value="" size="40" style="border:1 solid #C7C7C7;back-color :black;"></td>
                        		</tr>
                        		<tr>
                                		<td align="center" bgcolor="E9EDC1"><font color="8A8F5B"><strong>제목</strong></font></td>
                                		<td bgcolor="#FFFFFF"><input type="text" name="title" value="<%=title%>" size="75" style="border:1 solid #C7C7C7;back-color :black;"></td>
                        		</tr>
                        		<tr>
                                		<td align="center" bgcolor="E9EDC1"><font color="8A8F5B"><strong>내용</strong></font><BR>HTML<input type=checkbox name=hflag value="1"></td>
                                		<td bgcolor="#FFFFFF"><textarea name="content" cols="75" rows="15" style="border:1 solid #C7C7C7;back-color :black;"><%=content%></textarea></td>
	                       		</tr>
                        		<tr>
                                		<td align="center" bgcolor="E9EDC1"><font color="8A8F5B"><strong>파일1</strong></font></td>
                                		<td bgcolor="#FFFFFF"><input type="file" name="bfile1" size="55" style="border:1 solid #C7C7C7;back-color :black;"></td>
                        		</tr>
                        		<tr>
                                		<td align="center" bgcolor="E9EDC1"><font color="8A8F5B"><strong>파일2</strong></font></td>
                                		<td bgcolor="#FFFFFF"><input type="file" name="bfile2" size="55" style="border:1 solid #C7C7C7;back-color :black;"></td>
                        		</tr>
<%if uid="agencyboard" then%>
                        		<tr>
                                		<td align="center" bgcolor="E9EDC1"><font color="8A8F5B"><strong>비밀번호</strong></font></td>
                                		<td bgcolor="#FFFFFF"><input type="password" name="pwd" value="" maxlength="4" size="10" style="border:1 solid #C7C7C7;back-color :black;"></td>
					</tr>
<%end if%>
				</table>

				</td>
			</tr>
        		<tr>
        			<td height="50" align="center"><input type=image src="/images/cus/bt_write_ok.gif" width="73" height="22" name="btn1" border=0 onclick="return sendit(this.form);">&nbsp; <a href="javascript:history.back();"><img src="/images/cus/bt_write_can.gif" width="73" height="22" border=0></a></td>
			</tr>
		</table>
</body>
</html>