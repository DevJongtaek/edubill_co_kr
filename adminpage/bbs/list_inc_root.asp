
<table width="744" border="0" cellspacing="0" cellpadding="0">

<script language="JavaScript">
<!--
function checkid()
{
	alert("로그인후 사용하세요!!") ;
}

function searchok()
{
	searchform.submit() ;
}
//-->
</script>

<form name="searchform" method="post" action="list.asp" onsubmit="return searchok();">
<input type=hidden name=uid value="<%=uid%>">

	<tr>
		<td height="26" align="right">
			<!--<input name="searcha" type="checkbox" id="name" value="1" <%if imsisearcha_1 <> "0" then%>checked<%end if%>>
                        <img src="/images/cus/ch_name.gif" width="28" height="15">
                        <input name="searcha" type="checkbox" id="name" value="1" <%if imsisearcha_1 <> "0" then%>checked<%end if%>>
                        <img src="/images/cus/ch_sub.gif" width="28" height="15">
                        <input name="searcha" type="checkbox" id="name" value="1" <%if imsisearcha_1 <> "0" then%>checked<%end if%>>
                        <img src="/images/cus/ch_con.gif" width="28" height="15">
                        <input name="searchb" type="text" class="searchbox" style='width:95; height:19px;' value="<%=searchb%>">
                        <input type=image src="/images/cus/bt_search.gif" width="51" height="16">-->
		</td>
	</tr>

</form>

	<tr>
		<td>

		<table width="744" border="0" cellspacing="0" cellpadding="0">
			<tr>
                        	<td width="8" height="27" background="/images/cus/board_bg.gif"><img src="/images/cus/board_left.gif" width="8" height="27"></td>
                            	<td width="50" align="center" background="/images/cus/board_bg.gif"><img src="/images/cus/board_m1.gif" width="29" height="27"></td>
                            	<td align="center" background="/images/cus/board_bg.gif"><img src="/images/cus/board_m2.gif" width="59" height="27"></td>
                            	<td align="center" background="/images/cus/board_bg.gif"><img src="/images/cus/board_m3.gif" width="29" height="27"></td>
                            	<td width="120" align="center" background="/images/cus/board_bg.gif"><img src="/images/cus/board_m4.gif" width="29" height="27"></td>
                            	<td width="5" align="center" background="/images/cus/board_bg.gif"><img src="/images/cus/board_m5.gif" width="29" height="27"></td>
                            	<td width="8" background="/images/cus/board_bg.gif"><img src="/images/cus/board_rgt.gif" width="8" height="27"></td>
			</tr>

<%
i=1	
rspage = rs.pagesize
tot_p_n = tot_n-((gotopage-1)*rspage)

do until rs.eof or i = rs.pagesize
	if rs("areaddate") = "" or isnull(rs("areaddate")) then
		txtbold = "<B>"
	else
		txtbold = ""
	end if
%>

                        <tr>
                            	<td height="25">&nbsp;</td>
                            	<td height="25" align="center"><%=txtbold%><%=tot_p_n%></td>
                            	<td height="25">
<%if rs("re_level")>0 then 
	re_wid=3*rs("re_level")
%>
	<img src="/images/level.gif" width="<%=re_wid%>" height="10">
	<img src="/images/re.gif" align=absMiddle>
<%end if%>
<a href="content_root.asp?idx=<%=rs("idx")%>&uid=<%=uid%>&gotopage=<%=gotopage%>&searcha=<%=searcha%>&searchb=<%=searchb%>"><%=txtbold%><%=rs("title")%></a>
<% if rs("readnum") >= 500 then%>
	<img align=absMiddle src="/images/ico_hot.gif">
<%else
	if now() - cdate(rs("nows")) < 1 then 
%>
		<img align=absMiddle src="/images/ico_new.gif">
<% 	end if 
end if
%>
				</td>
                            	<td height="25" align="center"><%=txtbold%><%=rs("name")%></td>
                            	<td height="25" align="center"><%=txtbold%><%=replace(left(rs("nows"),10),"-",".")%></td>
                            	<td height="25" align="center"><%=txtbold%><%=rs("readnum")%></td>
                            	<td height="25">&nbsp;</td>
			</tr>
			<tr>
				<td height="1" colspan="7" bgcolor="f2f2f2"></td>
			</tr>

<%
rs.MoveNext 
i=i+1
tot_p_n=tot_p_n-1
loop 
%>

			<tr>
				<td height="2" colspan="7" background="/images/cus/board_btbg.gif"></td>
			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td height="50" align="center">

			<% blockPage=Int((GotoPage-1)/10)*10+1
			if blockPage = 1 Then
				'Response.Write "<font color=#8B9494>이전10개</font> [ "
			Else %>
				<a href="list_root.asp?GotoPage=1&uid=<%=uid%>&searcha=<%=searcha%>&searchb=<%=searchb%>">첫페이지</a>&nbsp;
				<a href="list_root.asp?GotoPage=<%=blockPage-10%>&uid=<%=uid%>&searcha=<%=searcha%>&searchb=<%=searchb%>">이전 10개</a>&nbsp;[&nbsp;		
			<% End If
			i=1
			Do Until i > 10 or blockPage > rs.pagecount
				If blockPage=int(GotoPage) Then %>
					<font color=red><%=blockPage%></font>			
				<%Else%> 
					<a href="list_root.asp?GotoPage=<%=blockPage%>&uid=<%=uid%>&searcha=<%=searcha%>&searchb=<%=searchb%>">[<font color=blue><%=blockPage%></font>]</a>			
				<%End If
		    	blockPage=blockPage+1
		    	i = i + 1
		    	Loop

			if blockPage > rs.pagecount Then
				'Response.Write " ] <font color=#8B9494>다음10개</font>"
			Else %> 
				&nbsp;]&nbsp;<a href="list_root.asp?GotoPage=<%=blockPage%>&uid=<%=uid%>&searcha=<%=searcha%>&searchb=<%=searchb%>">다음 10개</a>
				&nbsp;<a href="list_root.asp?GotoPage=<%=rs.pagecount%>&uid=<%=uid%>&searcha=<%=searcha%>&searchb=<%=searchb%>">마지막</a>		
			<% End If %>


		</td>
	</tr>
        <tr>
        	<td height="30" align="center">
				<a href="write.asp?uid=<%=uid%>"><img src="/images/cus/bt_write.gif" width="86" height="22" border="0"></a>
			</td>
        </tr>

   
</table>



