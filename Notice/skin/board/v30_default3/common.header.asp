<script type="text/javascript" src="js/jquery.checkbox.js"></script>
<script type="text/javascript" src="js/jquery.format.js"></script>
<script type="text/javascript" src="<%=CONF_skinPath%>js/board.js"></script>
<link type="text/css" href="style/jquery.checkbox.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="<%=CONF_skinPath%>css/common.css" />
<link rel="stylesheet" type="text/css" href="style/?strSkinPath=board/<%=CONF_strSkinName%>/&strStyleFile=css/<%=CONF_strSkinColor%>.css" />
<div class="boardModule">
	<h3 class="board_header">
<%
	SELECT CASE subAct
	CASE "list" : RESPONSE.WRITE objXmlLang("title_list")
	CASE "view" : RESPONSE.WRITE objXmlLang("title_read")
	CASE "write" : RESPONSE.WRITE objXmlLang("title_write")
	CASE "comment_modify", "comment_reply" : RESPONSE.WRITE objXmlLang("title_comment_write")
	CASE "tag" : RESPONSE.WRITE objXmlLang("title_tag")
	END SELECT
%>
		<div>
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
		</div>
	</h3>
	<div class="board_category">
		<div class="board_category_list">
			<ul id="board_category_data"></ul>
		</div>
	</div>