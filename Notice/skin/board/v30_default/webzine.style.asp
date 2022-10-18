		<table class="bbsWebzine">
<%
	LIST_iCount = 0
	FOR tmpFor = 0 TO AdRs_List_Count
		AdRs_List_Temp = AdRs_List
%>
<!-- #include file = "../../../Include/Board.List.Disp.asp" -->
				<tr>
					<td>
						<% IF LIST_strImage <> "" THEN %><a href="<%=GetBoardUrl("view", "seq=" & LIST_intSeq)%>" class="thumb"><img src="<%=LIST_strImage%>" /></a><% END IF %>
<% meta_display = False %>
<% FOR EACH dispField IN CONF_strDispListField %>
	<% IF dispField = "no" THEN %>
		<% IF meta_display = True THEN %></ul><% meta_display = False %><% END IF %>
						<p><%=objXmlLang("num")%> : <% IF REQ_intSeq = CINT(LIST_intSeq) THEN %><img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_pri" alt="pri" /><% END IF %><span class="num"><%=LIST_intNumber%></span></p>
		<% ELSEIF dispField = "title" THEN %>
		<% IF meta_display = True THEN %></ul><% meta_display = False %><% END IF %>
						<p>
							<% IF CONF_bitBoardAdmin = True THEN %><input name="bbs_seq" type="checkbox" id="bbs_seq" value="<%=LIST_intSeq%>" />&nbsp;<% END IF %><a href="<%=GetBoardUrl("view", "seq=" & LIST_intSeq)%>" class="b"><%=LIST_strTitle%></a>
							<% IF LIST_intComment > 0 THEN %><span class="comment">[<%=LIST_intComment%>]</span><% END IF %>
							<% IF DATEDIFF("h", LIST_strRegDate, NOW) < objSkinConfig("duration_new") THEN %><img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_new" alt="new" /><% END IF %>
							<% IF LIST_strFile <> "" THEN %><img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_file" alt="file" /><% END IF %>
							<% IF LIST_strImage <> "" THEN %><img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_image" alt="photo" /><% END IF %>
							<% IF LIST_bitSecret = True THEN %><img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_secret" alt="secret" /><% END IF %>
						</p>
	<% ELSEIF dispField = "nick_name" OR dispField = "user_id" OR dispField = "user_name" OR dispField = "regdate" OR dispField = "last_update" OR dispField = "readed_count" OR dispField = "voted_count" OR dispField = "blamed_count" THEN %>
						<% IF meta_display = False THEN %><ul class="meta"><% meta_display = True %><% END IF %>
							<% IF dispField = "nick_name" THEN %><li><%=LIST_strNickName%></li><% END IF %>
							<% IF dispField = "user_id" AND LIST_strUserID <> "" THEN %><li><%=LIST_strUserID%></li><% END IF %>
							<% IF dispField = "user_name" THEN %><li><%=LIST_strUserName%></li><% END IF %>
							<% IF dispField = "regdate" THEN %><li class="date"><%=REPLACE(LEFT(LIST_strRegDate,10),"-",".")%></li><% END IF %>
							<% IF dispField = "last_update" AND LIST_strModifyDate <> "" THEN %><li class="date"><%=REPLACE(LEFT(LIST_strModifyDate,10),"-",".")%></li><% END IF %>
							<% IF dispField = "readed_count" THEN %><li><%=objXmlLang("readed_count")%>&nbsp;<span class="num"><%=LIST_intRead%></span></li><% END IF %>
							<% IF dispField = "voted_count" THEN %><li><%=objXmlLang("voted_count")%>&nbsp;<span class="num"><%=LIST_intVote%></span></li><% END IF %>
							<% IF dispField = "blamed_count" THEN %><li><%=objXmlLang("blamed_count")%>&nbsp;<span class="num"><%=LIST_intBlamed%></span></li><% END IF %>
	<% ELSEIF dispField = "content" THEN %>
						<% IF meta_display = True THEN %></ul><% meta_display = False %><% END IF %>
						<p class="summary"><a href="<%=GetBoardUrl("view", "seq=" & LIST_intSeq)%>" name="link_view" id="<%=LIST_intSeq%>"><%=REPLACE(GetCutDispData(GetStripTags(LIST_strContent), 200, ".."), "<br>", "")%></a></p>
	<% ELSE %>
						<% IF meta_display = True THEN %></ul><% meta_display = False %><% END IF %>
						<p><span class="extraVar"><%=objXmlLang(dispField)%></span>&nbsp;<%=objExtraVar(dispField)%></p>
	<% END IF %>
<% NEXT %>
<% IF meta_display = True THEN %></ul><% meta_display = False %><% END IF %>
					</td>
				</tr>
<% NEXT %>
		</table>