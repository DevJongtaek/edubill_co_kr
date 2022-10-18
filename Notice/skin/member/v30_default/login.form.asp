<!-- #include file = "../../../Include/Login.Form.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/login.form.js"></script>
<form id="theForm" method="post">
<div id="bodyWrap" class="login_form">
	<div class="page_navi">
		<h4><%=objXmlLang("login")%></h4>
	</div>
	<div class="description"><%=objXmlLang("about_login")%></div>
	<div class="loginFormDiv">
    <div class="box01">
    	<fieldset>
    		<dl class="fields">
					<ul>
						<li>
							<dt class="password"><%=objXmlLang("user_id")%></dt>
							<dd>
								<span class="fl"><input type="text" id="loginid" name="loginid" class="input_text auth_email" tabindex="1" /></span>
								<span class="fl ml5"><input name="idsave" type="checkbox" id="idsave" tabindex="3" /> <label for="idsave"><%=objXmlLang("cmd_user_id_save")%></label></span>
							</dd>
						</li>
						<li>
							<dt class="password"><%=objXmlLang("password")%></dt>
							<dd class="authnum_div">
							<input type="password" id="loginpwd" name="loginpwd" class="input_text auth_email" tabindex="2" />
							<span class="button medium"><input type="submit" id="btn_login" value="<%=objXmlLang("cmd_login")%>"></span>
							</dd>
						</li>
					</ul>
   			</dl>
 			<div class="field_login">
				<span><a href="?act=member"><%=objXmlLang("cmd_sign_up")%></a></span>
				<span class="line">&nbsp;</span>
				<span><a href="?act=member&subAct=findid"><%=objXmlLang("cmd_find_id")%></a></span>
				<span class="line">&nbsp;</span>
				<span><a href="?act=member&subAct=findpwd"><%=objXmlLang("cmd_find_password")%></a></span>
			</div>
  		</fieldset>
		</div>
	</div>
</div>
</form>
<!-- #include file = "common.footer.asp" -->