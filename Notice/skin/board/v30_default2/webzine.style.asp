<div class="webZine">
	<ul>
<%
	DIM CONF_strDispListFieldTemp

	FOR EACH dispField IN CONF_strDispListField
		IF CONF_strDispListFieldTemp <> "" THEN CONF_strDispListFieldTemp = CONF_strDispListFieldTemp & ","
		CONF_strDispListFieldTemp = CONF_strDispListFieldTemp & dispField
	NEXT

	LIST_iCount = 0
	FOR tmpFor = 0 TO AdRs_List_Count
		AdRs_List_Temp = AdRs_List
%>
<!-- #include file = "../../../Include/Board.List.Disp.asp" -->
		<li>
			<a href="<%=GetBoardUrl("view", "seq=" & LIST_intSeq)%>"><% IF LIST_strImage = "" THEN %><span class="noimg">No Image</span><% ELSE %><span class="thumb"><img src="<%=LIST_strImage%>" alt="" class="thrum_img" /></span><% END IF %></a>
			<% IF INSTR(CONF_strDispListFieldTemp, "no") > 0 THEN %><p><%=objXmlLang("num")%> : <%=LIST_intNumber%></p><% END IF %>
			<% IF INSTR(CONF_strDispListFieldTemp, "title") > 0 THEN %>
			<p>
				<% IF CONF_bitBoardAdmin = True THEN %><input name="bbs_seq" type="checkbox" id="bbs_seq" value="<%=LIST_intSeq%>" /><% END IF %>
				<a href="<%=GetBoardUrl("view", "seq=" & LIST_intSeq)%>"><%=LIST_strTitle%></a>
				<% IF LIST_intComment > 0 THEN %><span class="comment">[<%=LIST_intComment%>]</span><% END IF %>
				<% IF DATEDIFF("h", LIST_strRegDate, NOW) < objSkinConfig("duration_new") THEN %><img src="images/etc/blank.gif" class="icon_new icon" alt="icon_new" /><% END IF %>
				<% IF LIST_strFile <> "" THEN %><img src="images/etc/blank.gif" class="icon_file icon" alt="icon_file" /><% END IF %>
				<% IF LIST_strImage <> "" THEN %><img src="images/etc/blank.gif" class="icon_image icon" alt="icon_image" /><% END IF %>
				<% IF LIST_bitSecret = True THEN %><img src="images/etc/blank.gif" class="icon_secret icon" alt="icon_secret" /><% END IF %>
			</p>
			<% END IF %>
			<p class="content"><%=REPLACE(GetCutDispData(GetStripTags(LIST_strContent), 200, ".."), "<br>", "")%></p>
			<% IF INSTR(CONF_strDispListFieldTemp, "nick_name") > 0 OR INSTR(CONF_strDispListFieldTemp, "user_id") > 0 OR INSTR(CONF_strDispListFieldTemp, "user_name") > 0 OR INSTR(CONF_strDispListFieldTemp, "regdate") > 0 OR INSTR(CONF_strDispListFieldTemp, "readed_count") > 0 OR INSTR(CONF_strDispListFieldTemp, "voted_count") > 0 OR INSTR(CONF_strDispListFieldTemp, "blamed_count") > 0 THEN %>
			<p class="meta">
				<% IF INSTR(CONF_strDispListFieldTemp, "nick_name") > 0 THEN %>
				<dl>
					<%=LIST_strNickName%>
					<span class="bar">|</span>
				</dl>
				<% END IF %>
				<% IF INSTR(CONF_strDispListFieldTemp, "user_id") > 0 THEN %>
				<dl><%=LIST_strUserID%><span class="bar">|</span></dl>
				<% END IF %>
				<% IF INSTR(CONF_strDispListFieldTemp, "user_name") > 0 THEN %>
				<dl><%=LIST_strUserName%><span class="bar">|</span></dl>
				<% END IF %>
				<% IF INSTR(CONF_strDispListFieldTemp, "regdate") > 0 THEN %>
				<dl><%=REPLACE(LEFT(LIST_strRegDate,10),"-",".")%><span class="bar">|</span></dl>
				<% END IF %>
				<% IF INSTR(CONF_strDispListFieldTemp, "readed_count") > 0 THEN %>
				<dl><%=objXmlLang("readed_count")%> : <%=LIST_intRead%><span class="bar">|</span></dl>
				<% END IF %>
				<% IF INSTR(CONF_strDispListFieldTemp, "voted_count") > 0 THEN %>
				<dl><%=objXmlLang("voted_count")%> : <%=LIST_intVote%><span class="bar">|</span></dl>
				<% END IF %>
				<% IF INSTR(CONF_strDispListFieldTemp, "blamed_count") > 0 THEN %>
				<dl><%=objXmlLang("blamed_count")%> : <%=LIST_intBlamed%><span class="bar">|</span></dl>
				<% END IF %>
			</p>
			<% END IF %>
		</li>
<% NEXT %>
	</ul>
</div>