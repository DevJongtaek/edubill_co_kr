<!-- #include file = "../../../Include/Member.Join.Result.asp" -->
<!-- #include file = "common.header.asp" -->
	<div id="bodyWrap" class="reg_complete">
		<div class="page_navi">
			<h4><%=objXmlLang("signup_complete")%></h4>
			<ul class="navi">
		<li class="n1"><span><%=objXmlLang("agreement")%></span></li>
		<li class="n2"><span><%=objXmlLang("Identification")%></span></li>
		<li class="n3"><span><%=objXmlLang("authentication")%></span></li>
		<li class="n4"><span><%=objXmlLang("basic_information")%></span></li>
		<li class="n5"><strong><%=objXmlLang("signup_complete")%></strong></li>
			</ul>
		</div>
 		<div class="reg_complete_noti">
			<p><span class="user_id"><%=strUserID%></span><span class="welcome"><%=objXmlLang("about_signup_welcome")%></span></p>
			<p class="comment"><strong class="fontstyle01"><%=strUserID%></strong><%=objXmlLang("about_signup_success")%></p>
		</div>
		<hr />
		<div class="btn_area">
			<span class="button large"><a href="/"><%=objXmlLang("cmd_main_page")%></a></span>
		</div>
 	</div>
<!-- #include file = "common.footer.asp" -->