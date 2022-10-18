<!-- #include file = "../../../Include/Account.id.Form.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/account.id.form.js"></script>
<form id="theForm" method="post">
<div id="bodyWrap" class="accountid_form">
	<div class="page_navi">
		<h4><%=objXmlLang("find_id")%></h4>
	</div>
	<div class="box01">
		<fieldset>
			<dl class="fields">
				<ul>
					<li>
						<dt class="account"><%=objXmlLang("user_name")%></dt>
						<dd><input type="text" id="username" name="username" class="input_text userid" /></dd>
					</li>
					<li>
						<dt class="account"><%=objXmlLang("email")%></dt>
						<dd><input type="text" id="email" name="email" class="input_text auth_email" /></dd>
					</li>
<% IF isCheckSSN = True THEN %>
					<li>
						<dt class="account"><%=objXmlLang("social_security_number")%></dt>
						<dd>
						<input type="text" id="ssn1" name="ssn1" maxlength="6" size="10" class="input_text ssn" /> - 
						<input type="password" id="ssn2" name="ssn2" maxlength="7" size="10" class="input_text ssn" />
						</dd>
					</li>
				</ul>
<% END IF %>
			</dl>
			<ul class="field_desc">
				<li class="list"><%=objXmlLang("about_find_id")%></li>
			</ul>
		</fieldset>
	</div>
	<div class="btn_area">
		<span class="button large strong"><input type="submit" value="<%=objXmlLang("cmd_find_id")%>" /></span>
		<span class="button large strong"><a href="?act=member&subAct=findpwd"><%=objXmlLang("cmd_find_password")%></a></span>
	</div>
</div>
</form>
<!-- #include file = "common.footer.asp" -->