<!-- #include file = "../../../Include/Member.Modify.Check.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.modify.check.js"></script>
<form id="theForm" method="post">
<div id="bodyWrap" class="modifycheck">
	<div class="page_navi">
		<h4><%=objXmlLang("manage_profile")%></h4>
	</div>
	<div class="box01">
		<fieldset>
    	<dl class="fields">
				<ul>
					<li>
						<dt class="modify_check"><%=objXmlLang("user_id")%></dt>
						<dd><%=SESSION("userID")%></dd>
					</li>
					<li>
						<dt class="modify_check"><%=objXmlLang("password")%></dt>
						<dd><input type="password" id="password" name="password" maxlength="32" class="input_text userid" /></dd>
					</li>
				</ul>
			</dl>
			<ul class="field_desc">
				<li class="list"><%=objXmlLang("about_password_once_more")%></li>
				<li class="list"><%=objXmlLang("about_password_match")%></li>
			</ul>
		</fieldset>
	</div>
	<div class="btn_area">
		<span class="button large strong"><input type="submit" value="<%=objXmlLang("cmd_confirm")%>" /></span>&nbsp;
		<span class="button large strong"><input type="button" class="btn_cancel" value="<%=objXmlLang("cmd_cancel")%>" /></span>
	</div>
</div>
</form>
<!-- #include file = "common.footer.asp" -->