<%
	DIM topMenu, menuID, langXmlPath, langXmlFile, isPopup

	topMenu     = 2
	menuID      = "H01"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.filebox.xml"
	isPopup     = True
%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	DIM xmlDOM, objRoot, firstLoop, secondLoop, thirdLoop

	Set xmlDOM = Server.CreateObject("Microsoft.XMLDOM")
	xmlDOM.async = false
%>
<!-- #include file = "../lang/lang.admin.page.control.asp" -->
<!-- #include file = "../comm/staff.check.asp" -->
<body id="bodyPopup">
<div id="wrap_filebox">
<script type="text/javascript">

	var langUrl = "lang/<%=CONF_strLangType%>/<%=REPLACE(langXmlFile, "\", "/")%>";

</script>
<script type="text/javascript" src="comm/js/filebox.list.js"></script>
		<div id="content">
			<div id="fileboxBody">
				<h4><%=objXmlLang("page_title")%></h4>
					<div id="fileUploader">
					<form name="theForm" id="theForm" method="post" enctype="multipart/form-data">
					<input type="hidden" id="filelink" name="filelink" />
						<table class="tabletype02">
							<tr>
								<th scope="row"><%=objXmlLang("title_select")%></th>
								<td class="detail">
								<input name="filename" type="file" class="inputFile" id="filename" size="30">
								<p class="tip"><%=objXmlLang("about_upload_file")%></p>
								</td>
							</tr>
							<tr>
								<th scope="row"><%=objXmlLang("title_memo")%></th>
								<td class="detail">
								<input name="strFileMemo" type="text" class="inputText" id="strFileMemo" style="width:400px;" size="60" maxlength="128" />
								</td>
							</tr>
							<tr>
								<th scope="row"><%=objXmlLang("title_category")%></th>
								<td class="detail">
									<span class="fl">
									<select name="strCateCode" id="strCateCode" style="width:250px;">
									<%=GetMakeSelectForm(objXmlLang("option_nouse"), ",", strCateCode, "")%>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_SYSCODE_READ] 'C000000002' ")
	WHILE NOT(RS.EOF)
%>
									<option value="<%=RS("strSecondCode")%>"<% IF strCateCode = RS("strSecondCode") THEN %> selected<% END IF %>><%=RS("strName")%></option>
<%
	RS.MOVENEXT
	WEND
%>
									</select>
									</span>
									<span class="fl pl5">
									<span class="button medium"><input type="button" id="btn_cate_config" value="<%=objXmlLang("btn_category")%>"></span>
									</span>
									<div id="cateDiv">
										<div class="cateLeft">
											<input type="text" class="fl" id="cateInput" maxlength="64">&nbsp;<span class="button small"><input type="button" id="btn_cate_add" value="<%=objXmlLang("btn_add")%>"></span>
										</div>
										<div class="cateRight">
											<ul id="cateList">
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_SYSCODE_READ] 'C000000002' ")

	WHILE NOT(RS.EOF)
%>
												<li id="<%=RS("strSecondCode")%>">
													<label class="fl"><%=RS("strName")%></label>
													<input type="text" id="catetxt_<%=RS("strSecondCode")%>" class="fl" value="<%=RS("strName")%>">
													<a name="btn_cate_remove" class="hand"><IMG src="images/btn_x2.gif" class="fr"></a>
												</li>
<%
	RS.MOVENEXT
	WEND
%>
											</ul>
										</div>
									</div>
								</td>
							</tr>
						</table>
						<div class="formButtonBox2">
						<span class="button large strong"><input type="submit" id="btn_save" value="<%=objXmlLang("btn_save")%>"></span>
						<span class="button large"><input type="button" id="btn_cancel" value="<%=objXmlLang("btn_cancel")%>"></span>
						</div>
					</form>
					</div>
					<div class="list_control_top">
					<span class="fl ml10">
					<span class="button medium icon"><span class="check"></span><a id="btn_select_all" cid="n"><%=objXmlLang("btn_select_all")%></a></span>
					</span>
					<span class="bar fl">|</span>
					<span class="fl">
					<span class="button medium"><input type="button" id="btn_remove" value="<%=objXmlLang("btn_select_remove")%>" /></span>
					</span>
					<div class="fr mr10">
					<span class="fl mr10">
						<select id="strSearchCateCode" onChange="javascript:FileBox.FileList('', this.value);">
						<%=GetMakeSelectForm(objXmlLang("option_category"), ",", strCateCode, "")%>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_SYSCODE_READ] 'C000000002' ")
	WHILE NOT(RS.EOF)
%>
						<option value="<%=RS("strSecondCode")%>"<% IF strCateCode = RS("strSecondCode") THEN %> selected<% END IF %>><%=RS("strName")%></option>
<%
	RS.MOVENEXT
	WEND
%>
						</select>
					</span>
					<span class="button medium"><span class="add"></span><a id="btn_img_upload"><%=objXmlLang("btn_pic_add")%></a></span>
					</div>
					</div>
					<form id="listForm">
					<div id="listBody"></div>
					</form>
			</div>
		</div>
	</div>
	</body>
<%
	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET objRoot = NOTHING : SET rootNode = NOTHING
%>