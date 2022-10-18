<!-- #include file = "../files/config/db.config.asp" -->
<!-- #include file = "../libs/function.asp" -->
<%
	DIM langXmlPath, langXmlFile

	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.login.xml"

	DIM xmlDOM, objRoot, firstLoop, secondLoop, thirdLoop

	Set xmlDOM = Server.CreateObject("Microsoft.XMLDOM")

	xmlDOM.async = false
%>
<!-- #include file = "lang/lang.admin.page.control.asp" -->
<script type="text/javascript" src="../js/jquery.cookie.js"></script>
<script type="text/javascript">

	var arApplMsg = new Array();

	$(document).ready(function() {

		$.ajax({
			url: "lang/<%=CONF_strLangType%>/lang.login.xml", data: "xml",
			success: function(xml){
				$(xml).find("alert").find("item").each(function(idx) {
					arApplMsg[$(this).attr("name")] = $(this).text();
				});
			}, error: function(xhr){alert(xhr.status);}
		});

		if ($.cookie("arty30_userid") != null){
			$("#id").val($.cookie("arty30_userid"));
			$('#theForm input[type=checkbox]').prop("checked", "checked");
		}

		$("#theForm").submit(function() {

			if ($("#id").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["null_user_id"]);$("#id").focus();return false;
			}
			
			if ($("#enpw").val().replace(/\s/g, "").length == 0) {
				alert(arApplMsg["null_password"]);$("#enpw").focus();return false;
			}

			$(this).ajaxSubmit({
				success:function(responseText){
					switch (responseText){
						case "SUCCESS" :
							if ($("#sid").is(":checked")) {
								var options = { path: '/', expires: 31 };
								$.cookie("arty30_userid", $("#id").val(), options);
							}else{
								var options = { path: '/', expires: 31 };
								$.cookie("arty30_userid", "", options);
							}

							if ($("#prevUrl").val().length == 0){
								document.location.href = "?act=main";
							}else{
								document.location.href = $("#prevUrl").val();
							}
							break;
						case "ERROR01" : alert(arApplMsg["userid_not_exists"]);$("#id").focus();return false; break;
						case "ERROR02" : alert(arApplMsg["invalid_user_id"]);$("#id").focus();return false; break;
						case "ERROR03" : alert(arApplMsg["stop_user_id"]);$("#id").focus();return false; break;
						case "ERROR04" : alert(arApplMsg["secession_user_id"]);$("#id").focus();return false; break;
						case "ERROR05" : alert(arApplMsg["only_admin_access"]);$("#id").focus();return false; break;
					}					
				}, 
				error:function(response){alert('error\n\n' + response.responseText);},  type:'post',  url: 'action/?subAct=login'});
			return false;

    });

	});
</script>
<body id="bodyLogin">
<form id="extForm" method="post" class="none">
<input type="hidden" name="prevUrl" id="prevUrl" value="<%=REPLACE(REPLACE(REQUEST.Querystring("strPrevUrl"), "'", ""), "--**--", "&")%>">
</form>
<form id="theForm" method="post">
<div id="wrap">
	<h1></h1>
	<div class="login_title">
	<%=objXmlLang("page_title")%>
	</div>
	<div id="login_header" class="login_header">
		<p><%=objXmlLang("text_info1")%> <strong class="txt_point nospacing"><%=objXmlLang("text_info2")%></strong><%=objXmlLang("text_info3")%></p>
	</div>
	<div id="login_box" class="login_box">
		<div class="list">
			<div style="text-align:left; letter-spacing:-1px; padding-left:40px;">
				<div id="empty_header">
					<ul>
						<li class="fl wd60"><%=objXmlLang("text_userid")%></li>
						<li class="fl"><input type="text" name="id" id="id" maxlength="15" tabindex="1" /></li>
						<li class="fl pl5"><input type="checkbox" id="sid" tabindex="3"  /><label for="sid" style="cursor:pointer"><%=objXmlLang("text_save_id")%></label></li>
					</ul>
				</div>
				<div id="empty_desc">
					<ul>
						<li class="fl wd60"><%=objXmlLang("text_userpwd")%></li>
						<li class="fl"><input type="password" name="enpw" id="enpw" maxlength="32" tabindex="2" /></li>
						<li class="fl pl5"><span class="button medium"><input type="submit" name="button" id="btn_login" class="btn_login" value="<%=objXmlLang("btn_login")%>"></span></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<dl id="login_alert" class="login_alert">
		<dd><a href="../?act=member&subAct=findid"><%=objXmlLang("text_find_id")%></a> <span class="separator">|</span> <a href="../?act=member&subAct=findpwd"><%=objXmlLang("text_find_pwd")%></a> <span class="separator">|</span> <a href="../?act=member"><%=objXmlLang("text_join")%></a></dd>
	</dl>
	<div class="login_bottom"></div>
</div>
</form>
</body>