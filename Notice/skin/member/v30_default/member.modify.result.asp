<!-- #include file = "../../../Include/Member.Modify.Result.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.modify.result.js"></script>
<div id="bodyWrap" class="modify_complete">
	<div class="page_navi">
		<h4><%=objXmlLang("manage_profile")%></h4>
	</div>
	<div class="finish_action">
		<h4><%=objXmlLang("about_profile_update_success")%></h4>
		<p class="finish_description">
			<%=objXmlLang("about_profile_update")%>
		</p>
	</div>
	<div class="btn_area">
		<span class="button large"><input type="button" class="btn_modify" value="<%=objXmlLang("cmd_prev_page")%>"></span>
		<span class="button large"><a href="/"><%=objXmlLang("cmd_main_page")%></a></span>
	</div>
</div>
<!-- #include file = "common.footer.asp" -->