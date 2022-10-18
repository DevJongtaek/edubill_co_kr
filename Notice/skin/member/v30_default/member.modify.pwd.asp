<!-- #include file = "../../../Include/Member.Modify.Pwd.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.modify.pwd.js"></script>
<form id="theForm" method="post">
<div id="bodyWrap" class="modifypwd_form">
	<div class="page_navi">
		<h4><%=objXmlLang("modify_password")%></h4>
	</div>
	<div class="description"><%=SESSION("userID")%> <%=objXmlLang("about_modify_password")%></div>
	<div class="nameCheckDiv">
		<div class="box01">
    	<fieldset>
    	<dl class="fields">
				<ul>
					<li>
						<dt class="password"><%=objXmlLang("current_password")%></dt>
						<dd><input type="password" id="password" name="password" size="10" class="input_text password" /></dd>
					</li>
					<li>
						<dt class="password"><%=objXmlLang("new_password")%></dt>
						<dd><input type="password" id="password1" name="password1" size="10" class="input_text password" /></dd>
					</li>
					<li>
						<dt class="password info"></dt>
						<dd><%=objXmlLang("about_password_input")%></dd>
					</li>
					<li>
						<dt class="password"><%=objXmlLang("confirm_password")%></dt>
						<dd>
						<input type="password" id="password2" name="password2" size="10" class="input_text password" />
						</dd>
					</li>
					<li>
						<dt class="password info"></dt>
						<dd><%=objXmlLang("about_password_re_input")%></dd>
					</li>
				</ul>
			</dl>
				<ul class="field_desc">
					<li class="list info_password"><%=objXmlLang("about_modify_password_info1")%></li>
					<li class="list info_password"><%=objXmlLang("about_modify_password_info2")%></li>
				</ul>
			</fieldset>
 		</div>
 		<div class="btn_area">
			<span class="button large strong"><input type="submit" value="<%=objXmlLang("cmd_confirm")%>" /></span>&nbsp;
			<span class="button large strong"><a href="/"><%=objXmlLang("cmd_cancel")%></a></span>
 		</div>
	</div>
</div>
</form>
<!-- #include file = "common.footer.asp" -->