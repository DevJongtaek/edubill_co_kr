<!-- #include file = "../../../Include/Member.Certified.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.certified.js"></script>
<form id="theForm" method="post">
<div id="bodyWrap" class="regauth">
	<div class="page_navi">
		<h4><%=objXmlLang("authentication")%></h4>
		<ul class="navi">
		<li class="n1"><span><%=objXmlLang("agreement")%></span></li>
		<li class="n2"><span><%=objXmlLang("Identification")%></span></li>
		<li class="n3"><strong><%=objXmlLang("authentication")%></strong></li>
		<li class="n4"><span><%=objXmlLang("basic_information")%></span></li>
		<li class="n5"><span><%=objXmlLang("signup_complete")%></span></li>
		</ul>
	</div>
	<div class="description"><%=objXmlLang("about_authentication")%></div>
	<div id="authCheckDiv">
		<ul class="auth_tab">
			<li><input type="radio" id="auth_type1" name="auth_type" checked="checked" /> <label for="auth_type1"><%=objXmlLang("mail_authentication")%></label></li>
		</ul>
    <div class="box01">
    	<fieldset>
    		<dl class="fields">
					<ul>
						<li>
							<dt class="email"><%=objXmlLang("mail_address")%></dt>
							<dd>
								<input type="text" id="email" name="email" class="input_text auth_email" />
								<span class="button medium"><input type="button" class="btn_get_auth" value="<%=objXmlLang("cmd_certification_number")%>"></span>
							</dd>
						</li>
						<li>
							<dt class="email"><%=objXmlLang("verification_number")%></dt>
							<dd class="authnum_div">
							<input type="text" id="authCode" name="authCode" class="input_text auth_email" />
							<span class="button medium"><input type="button" class="btn_put_auth" value="<%=objXmlLang("cmd_certification")%>"></span>
							<span class="button medium"><input type="button" class="btn_get_re_auth" value="<%=objXmlLang("cmd_certification_cancel")%>" /></span>
							</dd>
						</li>
					</ul>
   			</dl>
				<ul class="field_desc">
					<li class="list"><%=objXmlLang("about_authentication_number1")%></li>
					<li class="list"><%=objXmlLang("about_authentication_number2")%></li>
					<li class="list"><%=objXmlLang("about_authentication_number3")%></li>
				</ul>
  		</fieldset>
		</div>
	</div>
	<div class="btn_area">
		<span class="button xLarge strong icon"><span class="check"></span><input type="submit" value="<%=objXmlLang("cmd_next_step")%>" /></span>
		<span class="button large strong"><a href="/"><%=objXmlLang("cmd_join_cancel")%></a></span>
	</div>
</div>
</form>
<!-- #include file = "common.footer.asp" -->