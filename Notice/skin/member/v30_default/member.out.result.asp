<!-- #include file = "../../../Include/Member.Modify.Result.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.out.result.js"></script>
<div id="bodyWrap" class="member_out_result">
	<div class="page_navi">
		<h4><%=objXmlLang("member_leave")%></h4>
	</div>
	<div class="finish_action">
		<h4><%=objXmlLang("about_leave_result")%></h4>
		<p class="finish_description">
			<%=objXmlLang("about_leave_service_result")%>
		</p>
	</div>
	<div class="btn_area">
		<span class="button large"><input type="button" id="btn_main" value="<%=objXmlLang("cmd_main_page")%>"></span>
	</div>
</div>
<!-- #include file = "common.footer.asp" -->