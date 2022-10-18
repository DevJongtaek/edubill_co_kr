<%
	LIST_iCount = 0
	FOR tmpFor = 0 TO AdRs_List_Count
		AdRs_List_Temp = AdRs_List
%>
<!-- #include file = "../../../Include/Board.List.Disp.asp" -->
		<tr>
		<td class="check"><% IF CONF_bitBoardAdmin = True THEN %><input name="bbs_seq" type="checkbox" id="bbs_seq" value="<%=LIST_intSeq%>" /><% END IF %></td>
<%
		FOR EACH dispField IN CONF_strDispListField
%>
<% IF dispField = "no" THEN %>
		<td class="num"><% IF REQ_intSeq = CINT(LIST_intSeq) THEN %><img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_pri" /><% ELSE %><%=LIST_intNumber%><% END IF %></td>
<% ELSEIF dispField = "title" THEN %>
		<td class="title">
		<a href="<%=GetBoardUrl("view", "seq=" & LIST_intSeq)%>"><%=LIST_strTitle%></a>
<% IF LIST_intComment > 0 THEN %>
		<span class="comment">[<%=LIST_intComment%>]</span>
<% END IF %>
<% IF DATEDIFF("h", LIST_strRegDate, NOW) < INT(objSkinConfig("duration_new")) THEN %>
		<img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_new" alt="new" />
<% END IF %>
<% IF LIST_strFile <> "" THEN %>
		<img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_file" alt="file" />
<% END IF %>
<% IF LIST_strImage <> "" THEN %>
		<img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_image" alt="photo" />
<% END IF %>
<% IF LIST_bitSecret = True THEN %>
		<img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_secret" alt="secret" />
<% END IF %>
		</td>
<% ELSEIF dispField = "nick_name" THEN %>
		<td class="nick"><%=LIST_strNickName%></td>
<% ELSEIF dispField = "user_id" THEN %>
		<td class="userid"><%=LIST_strUserID%></td>
<% ELSEIF dispField = "user_name" THEN %>
		<td class="username"><%=LIST_strUserName%></td>
<% ELSEIF dispField = "regdate" THEN %>
		<td class="date"><%=REPLACE(LEFT(LIST_strRegDate,10),"-",".")%></td>
<% ELSEIF dispField = "last_update" THEN %>
		<td class="date"><% IF LIST_strModifyDate = "" OR ISNULL(LIST_strModifyDate) = True THEN %>-<% ELSE %><%=REPLACE(LEFT(LIST_strModifyDate,10),"-",".")%><% END IF %></td>
<% ELSEIF dispField = "readed_count" THEN %>
		<td class="count"><%=LIST_intRead%></td>
<% ELSEIF dispField = "voted_count" THEN %>
		<td class="count"><%=LIST_intVote%></td>
<% ELSEIF dispField = "blamed_count" THEN %>
		<td class="count"><%=LIST_intBlamed%></td>
<% ELSE %>
		<td>
		<%=objExtraVar(dispField)%>
		</td>
<% END IF %>
<% NEXT %>
	</tr>
<% NEXT %>