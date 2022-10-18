<script type="text/javascript" src="<%=CONF_skinPath%>js/board.js"></script>
<link rel="stylesheet" type="text/css" href="<%=CONF_skinPath%>css/common.css" />
<link rel="stylesheet" type="text/css" href="style/?strSkinPath=board/<%=CONF_strSkinName%>/&strStyleFile=css/<%=CONF_strSkinColor%>.css" />
<div class="boardModule">
<!--board_header-->
	<div class="board_title">
		<p><span>|</span><%=CONF_strTitle%></p>
		<div class="list_style">
			<a href="<%=GetBoardUrl("", "list_style=list")%>"><img src="images/etc/blank.gif" class="list" alt="<%=objXmlLang("cmd_list_style")%>" /></a>
			<a href="<%=GetBoardUrl("", "list_style=webzine")%>"><img src="images/etc/blank.gif" class="webzine" alt="<%=objXmlLang("cmd_webzine_style")%>" /></a>
			<a href="<%=GetBoardUrl("", "list_style=gallery")%>"><img src="images/etc/blank.gif" class="gallery" alt="<%=objXmlLang("cmd_gallery_style")%>" /></a>
		</div>
	</div>
	<div class="board_top">
		<h4>
			<%=objXmlLang("total_article")%> : <%=CONF_intTotalCount%> (<%=REQ_intPage%>page/<%=CONF_intPageCount%>page)
			<ul>
				<% IF CONF_bitBoardAdmin = True AND objSkinConfig("display_setup_button") = "Y" THEN %><li><a href="<%=CONF_strAdminLink%>" id="btn_setup" target="_blank"><%=objXmlLang("cmd_setup")%></a></li><% END IF %>
				<% IF objSkinConfig("display_login_info") = "Y" THEN %>
				<% IF SESSION("memberSeq") = "" THEN %>
				<li><a href="?Act=member" id="btn_member_join"><%=objXmlLang("cmd_sign_up")%></a></li>
				<li><a href="<%=GetBoardUrl("login", "seq=" & REQ_intSeq)%>"><%=objXmlLang("cmd_login")%></a></li>
				<% ELSE %>
				<li><a href="?Act=member&subAct=modify" id="btn_member_modify"><%=objXmlLang("cmd_member_modify")%></a></li>
				<li><a href="<%=GetBoardUrl("logout", "seq=" & REQ_intSeq)%>"><%=objXmlLang("cmd_logout")%></a></li>
				<% END IF %>
				<% END IF %>
			</ul>
		</h4>
	</div>