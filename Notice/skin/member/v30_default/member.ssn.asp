<!-- #include file = "../../../Include/Member.Ssn.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.ssn.js"></script>
<form id="theForm" method="post">
<div id="bodyWrap" class="namecheck">
	<div class="page_navi">
		<h4><%=objXmlLang("Identification")%></h4>
		<ul class="navi">
		<li class="n1"><span><%=objXmlLang("agreement")%></span></li>
		<li class="n2"><strong><%=objXmlLang("Identification")%></strong></li>
		<li class="n3"><span><%=objXmlLang("authentication")%></span></li>
		<li class="n4"><span><%=objXmlLang("basic_information")%></span></li>
		<li class="n5"><span><%=objXmlLang("signup_complete")%></span></li>
		</ul>
	</div>
	<div class="description"><%=objXmlLang("about_Identification")%></div>
	<div class="nameCheckDiv">
		<div class="box01">
    	<fieldset>
    	<dl class="fields">
				<ul>
					<li>
						<dt class="ssn"><%=objXmlLang("real_name")%></dt>
						<dd><input type="text" id="name" name="name" size="10" class="input_text name" /></dd>
					</li>
					<li>
						<dt class="ssn"><%=objXmlLang("social_security_number")%></dt>
						<dd>
						<input type="text" id="ssn1" name="ssn1" maxlength="6" size="10" class="input_text ssn" /> - 
						<input type="password" id="ssn2" name="ssn2" maxlength="7" size="10" class="input_text ssn" />
						</dd>
					</li>
				</ul>
			</dl>
			<ul class="field_desc">
				<li class="list"><%=objXmlLang("about_encryption")%></li>
				<li class="list"><%=objXmlLang("about_fraud")%></li>
				<li><%=objXmlLang("about_legal")%></li>
			</ul>
			</fieldset>
 		</div>
 		<div class="btn_area">
			<span class="button xLarge strong icon"><span class="check"></span><input type="submit" value="<%=objXmlLang("cmd_next_step")%>" /></span>
			<span class="button large strong"><a href="/"><%=objXmlLang("cmd_join_cancel")%></a></span>
 		</div>
	</div>
</div>
</form>
<!-- #include file = "common.footer.asp" -->