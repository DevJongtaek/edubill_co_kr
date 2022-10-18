<!-- #include file = "../../../Include/Member.Agree.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.agree.js"></script>
<form id="theForm">
<div id="bodyWrap" class="agreement_pg">
	<div class="page_navi">
		<h4><%=objXmlLang("agreement")%></h4>
		<ul class="navi">
		<li class="n1"><strong><%=objXmlLang("agreement")%></strong></li>
		<li class="n2"><span><%=objXmlLang("Identification")%></span></li>
		<li class="n3"><span><%=objXmlLang("authentication")%></span></li>
		<li class="n4"><span><%=objXmlLang("basic_information")%></span></li>
		<li class="n5"><span><%=objXmlLang("signup_complete")%></span></li>
		</ul>
	</div>
	<div class="description">
		<%=objXmlLang("about_agreement")%>
	</div>
	<h5 class="agreement"><%=objXmlLang("service_agreement")%></h5>
	<div class="agreement">
	<%=CONF_strMemberDocument1%>
	</div>
	<h5 class="agreement_noti"><%=objXmlLang("personal_information")%></h5>
	<div class="agreement">
	<%=CONF_strMemberDocument2%>
	</div>
	<div class="agreement_check">
		<input id="agree_check" name="agree_check" type="checkbox" value="1" /><label for="agree_check"><%=objXmlLang("agreement_accept")%></label>
	</div>
	<div class="btn_area">
<% IF CONF_bitUseJoinKids = True THEN %>
			<span class="button large"><input type="button" id="K" value="<%=objXmlLang("cmd_minor_member")%>" class="btn_join" /></span>
<% END IF %>
			<span class="button large"><input type="button" id="D" value="<%=objXmlLang("cmd_default_member")%>" class="btn_join" /></span>
<% IF CONF_bitUseJoinCorp = True THEN %>
			<span class="button large"><input type="button" id="C" value="<%=objXmlLang("cmd_corporate_member")%>" class="btn_join" /></span>
<% END IF %>
			<span class="button large"><a href="/"><%=objXmlLang("cmd_join_cancel")%></a></span>
	</div>
</div>
</form>
<!-- #include file = "common.footer.asp" -->