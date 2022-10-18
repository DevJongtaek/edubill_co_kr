<script type="text/javascript" src="<%=CONF_skinPath%>js/board.js"></script>
<link rel="stylesheet" type="text/css" href="<%=CONF_skinPath%>css/common.css" />
<link rel="stylesheet" type="text/css" href="style/?strSkinPath=board/<%=CONF_strSkinName%>/&strStyleFile=css/<%=CONF_strSkinColor%>.css" />
<div id="boardModule">
<% IF objSkinConfig("disp_title") = "Y" THEN %>
	<h3 class="board_title"><a href="<%=GetBoardUrl("",  "search_keyword=,search_target=")%>"><%=CONF_strTitle%></a><span class="bar">|</span><span><%=objSkinConfig("sub_title")%></span></h3>
<% END IF %>
<% IF objSkinConfig("title_comment") <> "" THEN %>
	<p class="board_description"><%=objSkinConfig("title_comment")%></p>
<% END IF %>
<% IF subAct = "list" AND CONF_bitUseCategory = True THEN %>
	<div class="board_category"></div>
<% END IF %>
	<div class="board_top">
		<% IF subAct = "" OR subAct = "list" THEN %>
			<p class="total_article"><%=objXmlLang("total_article")%> <strong><%=CONF_intTotalCount%></strong></p>
		<% END IF %>
		<div class="right">
			<span class="top_button">
				<ul>
					<% IF CONF_bitBoardAdmin = True AND objSkinConfig("display_setup_button") = "Y" THEN %><li><a href="<%=CONF_strAdminLink%>" target="_blank"><%=objXmlLang("cmd_setup")%></a></li><% END IF %>
					<% IF objSkinConfig("display_login_info") = "Y" THEN %>
						<% IF SESSION("memberSeq") = "" THEN %>
						<li><a href="?Act=member"><%=objXmlLang("cmd_sign_up")%></a></li>
						<li><a href="<%=GetBoardUrl("login", "seq=" & REQ_intSeq)%>"><%=objXmlLang("cmd_login")%></a></li>
						<% ELSE %>
						<li><a href="?Act=member&subAct=modify" id="btn_member_modify"><%=objXmlLang("cmd_member_modify")%></a></li>
						<li><a href="<%=GetBoardUrl("logout", "seq=" & REQ_intSeq)%>"><%=objXmlLang("cmd_logout")%></a></li>
						<% END IF %>
					<% END IF %>
				</ul>
			</span>
			<% IF objSkinConfig("disp_style") = "Y" THEN %>
			<span class="list_style">
				<ul>
					<li class="default"><a href="<%=GetBoardUrl("", "list_style=list")%>"><span><%=objXmlLang("cmd_list_style")%></span></a></li>
					<li class="webzine"><a href="<%=GetBoardUrl("", "list_style=webzine")%>"><span><%=objXmlLang("cmd_webzine_style")%></span></a></li>
					<li class="gallery"><a href="<%=GetBoardUrl("", "list_style=gallery")%>"><span><%=objXmlLang("cmd_gallery_style")%></span></a></li>
				</ul>
			</span>
			<% END IF %>
		</div>
	</div>