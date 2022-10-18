	<div class="bbsGallery"> 
		<ul>
<%
	LIST_iCount = 0

	FOR tmpFor = 0 TO AdRs_List_Count
		AdRs_List_Temp = AdRs_List
%>
<!-- #include file = "../../../Include/Board.List.Disp.asp" -->
			<li>
				<dl style="height:<%=((UBOUND(CONF_strDispListField)+1)*17)+130%>px; *height:<%=((UBOUND(CONF_strDispListField)+1)*22)+130%>px;">
					<dt><a href="<%=GetBoardUrl("view", "seq=" & LIST_intSeq)%>"><% IF LIST_strImage = "" THEN %>No Images<% ELSE %><img src="<%=LIST_strImage%>" width="120" height="120"><% END IF %></a></dt>
				<% FOR EACH dispField IN CONF_strDispListField %>
					<% IF dispField = "no" THEN %>
						<dd class="num"><% IF CONF_bitBoardAdmin = True THEN %><input name="bbs_seq" type="checkbox" id="bbs_seq" value="<%=LIST_intSeq%>" /><% END IF %><%=objXmlLang("num")%> <% IF REQ_intSeq = CINT(LIST_intSeq) THEN %><img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_pri" /><% END IF %><span class="num"><%=LIST_intNumber%></span></dd>
					<% ELSEIF dispField = "title" THEN %>
						<dd class="subject">
							<a href="<%=GetBoardUrl("view", "seq=" & LIST_intSeq)%>"><%=LIST_strTitle%></a>
							<% IF LIST_intComment > 0 THEN %><span class="comment">[<%=LIST_intComment%>]</span><% END IF %><% IF DATEDIFF("h", LIST_strRegDate, NOW) < objSkinConfig("duration_new") THEN %><img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_new" alt="new" /><% END IF %><% IF LIST_strFile <> "" THEN %><img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_file" alt="file" /><% END IF %><% IF LIST_strImage <> "" THEN %><img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" alt="photo" class="icon_image" /><% END IF %><% IF LIST_bitSecret = True THEN %><img src="<%=CONF_skinPath%>images/<%=CONF_strSkinColor%>/blank.gif" class="icon_secret" alt="secret" /><% END IF %>
						</dd>
					<% ELSEIF dispField = "nick_name" THEN %>
						<dd><%=LIST_strNickName%></dd>
					<% ELSEIF dispField = "user_id" THEN %>
						<dd><%=LIST_strUserID%></dd>
					<% ELSEIF dispField = "user_name" THEN %>
						<dd><%=LIST_strUserName%></dd>
					<% ELSEIF dispField = "regdate" THEN %>
						<dd class="date"><%=REPLACE(LEFT(LIST_strRegDate,10),"-",".")%></dd>
					<% ELSEIF dispField = "last_update" AND LIST_strModifyDate <> "" THEN %>
						<dd class="date"><%=REPLACE(LEFT(LIST_strModifyDate,10),"-",".")%></dd>
					<% ELSEIF dispField = "readed_count" THEN %>
						<dd class="count"><%=objXmlLang("readed_count")%>&nbsp;<span class="num"><%=LIST_intRead%></span></dd>
					<% ELSEIF dispField = "voted_count" THEN %>
						<dd class="count"><%=objXmlLang("voted_count")%>&nbsp;<span class="num"><%=LIST_intVote%></span></dd>
					<% ELSEIF dispField = "blamed_count" THEN %>
						<dd class="count"><%=objXmlLang("blamed_count")%>&nbsp;<span class="num"><%=LIST_intBlamed%></span></dd>
					<% ELSE %>
						<dd><%=objXmlLang(dispField)%>&nbsp;<%=objExtraVar(dispField)%></dd>
					<% END IF %>
<% NEXT %>
				</dl>
			</li>
<% NEXT %>
		</ul>
	</div>