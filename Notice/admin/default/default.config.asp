<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 1
	menuID      = "A01"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.default.config.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<script type="text/javascript" src="default/js/default.config.js"></script>
		<div id="content">
			<form id="theForm">
			<div id="subHead">
				<h3><%=objXmlLang("page_title")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description")%>
			</p>
			<div id="subBody">
				<h4><%=objXmlLang("sub_title_1")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_default_url")%></th>
						<td>
						<input name="CONF_strSiteUrl" type="text" id="CONF_strSiteUrl" value="<%=CONF_strSiteUrl%>" size="80"/>
						<p class="tip"><%=objXmlLang("about_default_url")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_bbs_url")%></th>
						<td>
						<input name="CONF_strBbsUrl" type="text" id="CONF_strBbsUrl" value="<%=CONF_strBbsUrl%>" size="80"/>
						<p class="tip"><%=objXmlLang("about_bbs_url")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_admin_path")%></th>
						<td>
							<%=objXmlLang("text_domain")%>
							<input type="text" id="CONF_strAdminPath" name="CONF_strAdminPath" value="<%=CONF_strAdminPath%>"/>
							/
							<p class="tip"><%=objXmlLang("about_admin_path")%></p>
							</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_filepath")%></th>
						<td>
							<%=objXmlLang("text_domain")%>
							<input type="text" id="CONF_strFilePath" name="CONF_strFilePath" value="<%=CONF_strFilePath%>"/>
							/
							<p class="tip"><%=objXmlLang("about_filepath")%></p>
							</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_componet")%></th>
						<td>
						<select name="CONF_strUploadComponet" id="CONF_strUploadComponet">
						<%=GetMakeSelectForm(objXmlLang("option_componet"), ",", CONF_strUploadComponet, "")%>
						</select>
						<p class="tip"><%=objXmlLang("about_upload_componet")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_language")%></th>
						<td>
						<select name="CONF_strLangType" id="CONF_strLangType">
						<%=GetMakeSelectForm(objXmlLang("option_language"), ",", CONF_strLangType, "")%>
						</select>
						<p class="tip"><%=objXmlLang("about_language")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_ssl")%></th>
						<td>
						<select name="CONF_strUseSSL" id="CONF_strUseSSL">
						<%=GetMakeSelectForm(objXmlLang("option_use"), ",", CONF_strUseSSL, "")%>
						</select>
						<p class="tip"><%=objXmlLang("about_ssl")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_port")%></th>
						<td>
						HTTP : <input type="text" id="CONF_intHttpPort" name="CONF_intHttpPort" value="<%=CONF_intHttpPort%>" class="integer ime_mode" />
						HTTPS : <input type="text" id="CONF_intHttpsPort" name="CONF_intHttpsPort" value="<%=CONF_intHttpsPort%>" class="integer ime_mode"/>
						<p class="tip"><%=objXmlLang("about_port")%></p>
						</td>
					</tr>
				</table>
				<div class="formButtonBox">
					<span class="button large strong"><input type="submit" value="<%=objXmlLang("btn_save")%>"></span>
				</div>
			</div>
			</form>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->