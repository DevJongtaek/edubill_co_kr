<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C01"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_CONFIG_READ] ")

	DIM strPhotoSize, strNameImgSize, strMarkImgSize

	strPhotoSize   = SPLIT(RS("strPhotoSize"), ",")
	strNameImgSize = SPLIT(RS("strNameImgSize"), ",")
	strMarkImgSize = SPLIT(RS("strMarkImgSize"), ",")

	DIM memberSeq, memberFilePath
	
	memberSeq      = GetInputReplce(REQUEST.FORM("intSeq"), "")
	memberFilePath = GetNowFolderPath("../") & "\" & CONF_strFilePath & "\member\"

	IF memberSeq  = "" THEN
		RESPONSE.REDIRECT "?act=memberlist"
		RESPONSE.End()
	END IF

	DIM strEditorLangFile
	strEditorLangFile = Server.MapPath("../") & "\daum\lang\lang." & GetEditorUtfCode(CONF_strLangType) & ".xml"
%>
<script type="text/javascript" src="../js/Calendar.js"></script>
<script type="text/javascript" src="../js/jquery.textarearesizer.js"></script>
<link rel="stylesheet" href="../daum/css/editor_<%=GetEditorUtfCode(CONF_strLangType)%>.css" type="text/css"  charset="utf-8"/>
<script src="../daum/js/editor_<%=GetEditorUtfCode(CONF_strLangType)%>.js" type="text/javascript" charset="utf-8"></script>
<script src="../daum/js/editor_config.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

	var set_editor = {
		config: {
			path : '/<%=REPLACE(LCASE(CONF_strBbsUrl), LCASE(CONF_strSiteUrl), "")%>',
			pdspath : '<%=CONF_strFilePath%>',
			imagepath : 'member/sign/',
			filepath : 'member/sign/',
			boardsrl : '',
			editorMode : 'site',
			usefile : false,
			useimage : true
		}
	};

	window.onload = function() {

		new Editor({
			txHost: '',
			txPath: set_editor.config.path + 'daum/',
			txVersion: '5.4.0',
			txService: 'sample',
			txProject: 'sample',
			initializedId: "",
			wrapper: "tx_trex_container"+"",
			form: 'theForm'+"",
			txIconPath: set_editor.config.path + "daum/images/icon/<%=GetEditorUtfCode(CONF_strSkinLang)%>/",
			txDecoPath: set_editor.config.path + "daum/images/deco/",
			events: {
				preventUnload: false
			},
			canvas: {
				styles: {color: "#666666", fontFamily: "gulim", fontSize: "12px", backgroundColor: "<%=CONF_strWriteEditorBgColor%>", lineHeight: "1.5", padding: "8px"}
			},
			sidebar: {
				attachbox: {show:false},
				attacher: {
					image: {
						objattr: {width: set_editor.config.imagewidth}
					},
					file: {boxonly: true}
				}
			}
		})

		if (set_editor.config.usefile == false){
			$("#editor_file_upload").hide();
		}

		if (set_editor.config.useimage == false){
			$("#editor_image_upload").hide();
		}

		var useSignEditor = false;

		for ( var i = 0; i < arApplForm.length; i++ ){
			if (arApplForm[i].type != ""){
				if (arApplForm[i].field == "strUserSign")
					useSignEditor = true;
			}
		}

		if (useSignEditor == true){
			if ($("#joinType").val() == "join")
				Editor.focusOnForm("strLoginID");
			else
				Editor.focusOnForm("strNickName");
		}
		
		Editor.modify({
			"content": $tx("strUserSign")
		});
		
	};
	
</script>
<link type="text/css" href="../js/swfupload/default.css" rel="stylesheet" />
<script type="text/javascript" src="../js/swfupload/swfupload.js"></script>
<script type="text/javascript" src="../js/swfupload/swfupload.queue.js"></script>
<script type="text/javascript" src="../js/swfupload/fileprogress.js"></script>
<script type="text/javascript" src="../js/swfupload/handlers_1.js"></script>
<script type="text/javascript" src="member/js/member.modify.js"></script>
		<div id="content">
			<form id="extForm">
			<input type="hidden" name="intPage" value="<%=REQUEST.FORM("intPage")%>">
			<input type="hidden" name="intPageSize" value="<%=REQUEST.FORM("intPageSize")%>">
			<input type="hidden" name="sortid" value="<%=REQUEST.FORM("sortid")%>">
			<input type="hidden" name="sortdsc" value="<%=REQUEST.FORM("sortdsc")%>">
			<input type="hidden" name="search_option" value="<%=REQUEST.FORM("search_option")%>">
			<input type="hidden" name="detail_search" value="<%=REQUEST.FORM("detail_search")%>">
			<input type="hidden" name="searchMode" value="<%=REQUEST.FORM("searchMode")%>">
			<input type="hidden" name="searchText" value="<%=REQUEST.FORM("searchText")%>">
			<input type="hidden" name="startTermDate" value="<%=REQUEST.FORM("startTermDate")%>">
			<input type="hidden" name="endTermDate" value="<%=REQUEST.FORM("endTermDate")%>">
			<input type="hidden" name="termType" value="<%=REQUEST.FORM("termType")%>">
			<input type="hidden" name="etcAuth" value="<%=REQUEST.FORM("etcAuth")%>">
			<input type="hidden" name="etcSex" value="<%=REQUEST.FORM("etcSex")%>">
			<input type="hidden" name="startPoint" value="<%=REQUEST.FORM("startPoint")%>">
			<input type="hidden" name="endPoint" value="<%=REQUEST.FORM("endPoint")%>">
			<input type="hidden" name="birthType" value="<%=REQUEST.FORM("birthType")%>">
			<input type="hidden" name="gradeList" value="<%=REQUEST.FORM("gradeList")%>">
			<input type="hidden" name="levelList" value="<%=REQUEST.FORM("levelList")%>">
			</form>
<!-- #include file = "../../include/Member.Read.asp" -->
<!-- #include file = "../../include/Member.Form.asp" -->
<%
	iCount = 0
%>
			<form id="theForm" action="?act=memberlist">
			<input type="hidden" name="intSeq" id="intSeq" value="<%=memberSeq%>">
			<input type="hidden" id="change_email" name="change_email" value="0" />
			<input type="hidden" id="change_nick" name="change_nick" value="0" />
			<input type="hidden" id="strAddData1_" name="strAddData1_" />
			<input type="hidden" id="strAddData2_" name="strAddData2_" />
			<input type="hidden" id="strAddData3_" name="strAddData3_" />
			<input type="hidden" id="strAddData4_" name="strAddData4_" />
			<input type="hidden" id="strAddData5_" name="strAddData5_" />
			<input type="hidden" id="strAddData6_" name="strAddData6_" />
			<input type="hidden" id="strAddData7_" name="strAddData7_" />
			<input type="hidden" id="strAddData8_" name="strAddData8_" />
			<input type="hidden" id="strAddData9_" name="strAddData9_" />
			<input type="hidden" id="strAddData10_" name="strAddData10_" />
			<div id="subHead">
				<h3><%=objXmlLang("page_title_modify")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description_2")%>
			</p>
			<div id="subBody">
			<h4><%=objXmlLang("page_sub_title_1")%></h4>
				<table class="tabletype02">
<%
	DIM tmpArrData
	FOR tmpFor = 0 TO UBOUND(info.fieldName)
		IF info.fieldName(tmpFor) <> "" THEN
			SELECT CASE info.formType(tmpFor)
			CASE "userid"
%>
					<tr>
						<th scope="row"><div class="require"><%=info.title(tmpFor)%></div></th>
						<td class="detail">
						<%=objMemberInfo(info.fieldName(tmpFor))%><input type="hidden" name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>" value="<%=objMemberInfo(info.fieldName(tmpFor))%>">
						</td>
					</tr>
<%
			CASE "password"
%>
					<tr>
						<th scope="row"><div class="no_require"><%=info.title(tmpFor)%></div></th>
						<td class="detail"><input name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>" type="password" style="width:<%=info.width(tmpFor)%>px;"></td>
					</tr>
<%
			CASE "email"
%>
					<tr>
						<th scope="row"><div class="require"><%=info.title(tmpFor)%></div></th>
						<td class="detail">
            	<span class="fl mr5">
              <input name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>1" type="text" value="<%=objMemberInfo(info.fieldName(tmpFor) & "1")%>" style="width:110px;"> @
              <input name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>2" type="text" value="<%=objMemberInfo(info.fieldName(tmpFor) & "2")%>" style="width:110px;">
							</span>
              <span class="fl">
              <select name="email_list" id="email_list" onChange="Member.EmailListSet();">
              <%=GetMakeSelectForm(objXmlLang("option_mail_list"), ",", "", "")%>
              <%=GetMakeSelectForm(info.formData(tmpFor) & "$$$" & info.formData(tmpFor), CHR(13)&CHR(10), "", "")%>
              </select>
							</span>
              <p class="tip" id="emailCheckMsg"></p>
              </td>
					</tr>
<%
			CASE "nick"
%>
					<tr>
						<th scope="row"><div class="require"><%=info.title(tmpFor)%></div></th>
						<td class="detail">
            <input name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>" type="text" value="<%=objMemberInfo(info.fieldName(tmpFor))%>" style="width:<%=info.width(tmpFor)%>px;">
            <p class="tip" id="nickCheckMsg"></p>
            </td>
					</tr>
<%
			CASE "text", "url"
%>
					<tr>
						<th scope="row"><div class="<% IF info.rquired(tmpFor) = False THEN %>no_<% END IF %>require"><%=info.title(tmpFor)%></div></th>
						<td class="detail"><input name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>" type="text" value="<%=objMemberInfo(info.fieldName(tmpFor))%>" style="width:<%=info.width(tmpFor)%>px;"></td>
					</tr>
<%
			CASE "tel"
					tmpArrData = objMemberInfo(info.fieldName(tmpFor))
					IF tmpArrData <> "" AND ISNULL(tmpArrData) = False THEN tmpArrData = SPLIT(tmpArrData, "-") ELSE tmpArrData = SPLIT("--", "-")
%>
					<tr>
						<th scope="row"><div class="<% IF info.rquired(tmpFor) = False THEN %>no_<% END IF %>require"><%=info.title(tmpFor)%></div></th>
						<td class="detail">
						<input name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>1" type="text" style="width:50px;" maxlength="4" class="ime_mode integer" value="<%=tmpArrData(0)%>">
						&nbsp;-
						<input name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>2" type="text" style="width:50px;" maxlength="4" class="ime_mode integer" value="<%=tmpArrData(1)%>">
						-
						<input name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>3" type="text" style="width:50px;" maxlength="4" class="ime_mode integer" value="<%=tmpArrData(2)%>">
						</td>
					</tr>
<%
			CASE "mobile"
					tmpArrData = objMemberInfo(info.fieldName(tmpFor))
					IF tmpArrData <> "" AND ISNULL(tmpArrData) = False THEN tmpArrData = SPLIT(tmpArrData, "-") ELSE tmpArrData = SPLIT("--", "-")
%>
					<tr>
						<th scope="row"><div class="<% IF info.rquired(tmpFor) = False THEN %>no_<% END IF %>require"><%=info.title(tmpFor)%></div></th>
						<td class="detail">
						<select name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>1">
						<%=GetMakeSelectForm(objXmlLang("option_select"), ",", tmpArrData(0), "")%>
						<%=GetPhoneFirstNumber(info.formType(tmpFor), tmpArrData(0))%>
						</select>
						&nbsp;-
						<input name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>2" type="text" style="width:50px;" maxlength="4" class="ime_mode integer" value="<%=tmpArrData(1)%>">
						-
						<input name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>3" type="text" style="width:50px;" maxlength="4" class="ime_mode integer" value="<%=tmpArrData(2)%>">
						</td>
					</tr>
<%
			CASE "textarea"
%>
					<tr>
						<th scope="row"><div class="<% IF info.rquired(tmpFor) = False THEN %>no_<% END IF %>require"><%=info.title(tmpFor)%></div></th>
						<td class="detail"><textarea name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>" class="resizable"><%=objMemberInfo(info.fieldName(tmpFor))%></textarea></td>
					</tr>
<%
			CASE "sign"
%>
					<tr>
						<th scope="row"><div class="<% IF info.rquired(tmpFor) = False THEN %>no_<% END IF %>require"><%=info.title(tmpFor)%></div></th>
						<td class="editor">
						<textarea id="<%=info.fieldName(tmpFor)%>" name="<%=info.fieldName(tmpFor)%>" class="none"><%=objMemberInfo(info.fieldName(tmpFor))%></textarea>
							<!-- #include file = "../../daum/editor_inc.asp" -->
						</td>
					</tr>
<%
			CASE "checkbox"
%>
					<tr>
						<th scope="row"><div class="<% IF info.rquired(tmpFor) = False THEN %>no_<% END IF %>require"><%=info.title(tmpFor)%></div></th>
						<td class="detail">
						<dl class="radio_form">
						<%=GetMakeCheckForm(REPLACE(info.formData(tmpFor), CHR(13)&CHR(10), ",") & "$$$" & REPLACE(info.formData(tmpFor), CHR(13)&CHR(10), ","), ",", objMemberInfo(info.fieldName(tmpFor)), info.fieldName(tmpFor), "<dd>", "</dd>")%>
						</dl>
						</td>
					</tr>
<%
			CASE "radio"
%>
					<tr>
						<th scope="row"><div class="<% IF info.rquired(tmpFor) = False THEN %>no_<% END IF %>require"><%=info.title(tmpFor)%></div></th>
						<td class="detail">
						<dl class="radio_form">
<%
						SELECT CASE info.fieldName(tmpFor)
						CASE "strSex", "bitMailing", "bitOpenInfo", "bitMemo"
							RESPONSE.WRITE GetMakeRadioForm("1,0$$$" & REPLACE(info.formData(tmpFor), CHR(13)&CHR(10), ","), ",", objMemberInfo(info.fieldName(tmpFor)), info.fieldName(tmpFor), "<dd>", "</dd>")
						CASE ELSE
							RESPONSE.WRITE GetMakeRadioForm(info.formData(tmpFor) & "$$$" & info.formData(tmpFor), CHR(13)&CHR(10), objMemberInfo(info.fieldName(tmpFor)), info.fieldName(tmpFor), "<dd>", "</dd>")
						END SELECT
%>
						</dl>
						</td>
					</tr>
<%
			CASE "select"
%>
					<tr>
						<th scope="row"><div class="<% IF info.rquired(tmpFor) = False THEN %>no_<% END IF %>require"><%=info.title(tmpFor)%></div></th>
						<td class="detail">
						<select name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>">
						<%=GetMakeSelectForm(objXmlLang("option_select"), ",", objMemberInfo(info.fieldName(tmpFor)), "")%>
<%
						SELECT CASE info.fieldName(tmpFor)
						CASE "strSex", "bitMailing", "bitOpenInfo", "bitMemo"
							RESPONSE.WRITE GetMakeSelectForm("1,0$$$" & REPLACE(info.formData(tmpFor), CHR(13)&CHR(10), ","), ",", objMemberInfo(info.fieldName(tmpFor)), "")
						CASE ELSE
							RESPONSE.WRITE GetMakeSelectForm(info.formData(tmpFor) & "$$$" & info.formData(tmpFor), CHR(13)&CHR(10), objMemberInfo(info.fieldName(tmpFor)), "")
						END SELECT
%>
						</select>
						</td>
					</tr>
<%
			CASE "birthday"
%>
					<tr>
						<th scope="row"><div class="<% IF info.rquired(tmpFor) = False THEN %>no_<% END IF %>require"><%=info.title(tmpFor)%></div></th>
						<td class="detail">
						<dl>
						<dd class="fl mr5">
						<input name="<%=info.fieldName(tmpFor)%>" type="text" id="<%=info.fieldName(tmpFor)%>1" style="color:#666; background:#fff;" value="<% IF objMemberInfo(info.fieldName(tmpFor)) <> "" AND ISNULL(objMemberInfo(info.fieldName(tmpFor))) = False THEN %><%=LEFT(objMemberInfo(info.fieldName(tmpFor)), 4)%>.<%=MID(objMemberInfo(info.fieldName(tmpFor)), 5, 2)%>.<%=MID(objMemberInfo(info.fieldName(tmpFor)), 7, 2)%><% END IF %>" size="10" readonly="readonly" /><input type="button" id="btnStartCal" class="btn_calendar" onClick="calendar(event, '<%=info.fieldName(tmpFor)%>1');" />
						</dd>
						<dd class="fl">
						<select name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>2">
						<%=GetMakeSelectForm(objXmlLang("option_birthday"), ",", RIGHT(objMemberInfo(info.fieldName(tmpFor)), 1), "")%>
						</select>
						</dd>
						</dl>
					</tr>
<%
			CASE "date"
%>
					<tr>
						<th scope="row"><div class="<% IF info.rquired(tmpFor) = False THEN %>no_<% END IF %>require"><%=info.title(tmpFor)%></div></th>
						<td class="detail">
						<dl>
						<dd class="fl mr5">
						<input name="<%=info.fieldName(tmpFor)%>" type="text" id="<%=info.fieldName(tmpFor)%>" style="color:#666; background:#fff;" value="<% IF objMemberInfo(info.fieldName(tmpFor)) <> "" AND ISNULL(objMemberInfo(info.fieldName(tmpFor))) = False THEN %><%=LEFT(objMemberInfo(info.fieldName(tmpFor)), 4)%>.<%=MID(objMemberInfo(info.fieldName(tmpFor)), 5, 2)%>.<%=MID(objMemberInfo(info.fieldName(tmpFor)), 7, 2)%><% END IF %>" size="10" readonly="readonly" /><input type="button" id="btnStartCal" class="btn_calendar" onClick="calendar(event, '<%=info.fieldName(tmpFor)%>');" />
						</dd>
						</dl>
						</td>
					</tr>
<%
			CASE "marry"
%>
					<tr>
						<th scope="row"><div class="<% IF info.rquired(tmpFor) = False THEN %>no_<% END IF %>require"><%=info.title(tmpFor)%></div></th>
						<td class="detail">
						<dl>
						<dd class="fl mr5">
						<select name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>1" onChange="Member.MarryDateReset('<%=info.fieldName(tmpFor)%>2', this.value);">
						<%=GetMakeSelectForm(objXmlLang("option_marry"), ",", LEFT(objMemberInfo(info.fieldName(tmpFor)), 1), "")%>
						</select>
						</dd>
						<dd class="fl">
						<input name="<%=info.fieldName(tmpFor)%>" type="text" id="<%=info.fieldName(tmpFor)%>2" style="color:#666; background:#fff;" value="<% IF objMemberInfo(info.fieldName(tmpFor)) <> "" AND ISNULL(objMemberInfo(info.fieldName(tmpFor))) = False AND LEFT(objMemberInfo(info.fieldName(tmpFor)), 1) = "1" THEN %><%=MID(objMemberInfo(info.fieldName(tmpFor)), 2, 4)%>.<%=MID(objMemberInfo(info.fieldName(tmpFor)), 6, 2)%>.<%=MID(objMemberInfo(info.fieldName(tmpFor)), 8, 2)%><% END IF %>" size="10" readonly="readonly" /><input type="button" id="btnStartCal" class="btn_calendar" onClick="calendar(event, '<%=info.fieldName(tmpFor)%>2');" />
						</dd>
						</dl>
						</td>
					</tr>
<%
			CASE "addr"
			tmpArrData = objMemberInfo(info.fieldName(tmpFor))
			IF tmpArrData <> "" AND ISNULL(tmpArrData) = False THEN
				tmpArrData = SPLIT(tmpArrData, "$$$")
				IF UBOUND(tmpArrData) <> 2 THEN tmpArrData = SPLIT("$$$$$$", "$$$")
			ELSE
				tmpArrData = SPLIT("$$$$$$", "$$$")
			END IF
			IF tmpArrData(0) <> "" THEN tmpArrData(0) = LEFT(tmpArrData(0), 3) & "-" & RIGHT(tmpArrData(0), 3)
%>
					<tr>
						<th scope="row"><div class="<% IF info.rquired(tmpFor) = False THEN %>no_<% END IF %>require"><%=info.title(tmpFor)%></div></th>
						<td class="detail">
							<div id="addrForm_<%=info.fieldName(tmpFor)%>1" class="both" style="display:none;">
								<span class="fl mr5"><input type="text" name="<%=info.fieldName(tmpFor)%>1" id="<%=info.fieldName(tmpFor)%>1"></span>
								<span class="fl mr5"><span class="button medium"><input type="button"  onClick="Member.PostStep2('<%=info.fieldName(tmpFor)%>');" value="<%=objXmlLang("btn_search")%>"></span></span>
								<span class="button medium"><input type="button" onClick="Member.PostStep2Cancel('<%=info.fieldName(tmpFor)%>');" value="<%=objXmlLang("btn_cancel")%>"></span>
							</div>
							<div id="addrForm_<%=info.fieldName(tmpFor)%>2" class="both" style="display:none;">
								<span class="mr5">
								<select name="<%=info.fieldName(tmpFor)%>2" id="<%=info.fieldName(tmpFor)%>2" class="input_select">
								<option value="">SELECT</option>
								</select>
								</span>
								<span class="button medium mr5"><input type="button" onClick="Member.PostStep3('<%=info.fieldName(tmpFor)%>');" value="<%=objXmlLang("btn_select")%>"></span>
								<span class="button medium"><input type="button" onClick="Member.PostStep3Cancel('<%=info.fieldName(tmpFor)%>');" value="<%=objXmlLang("btn_cancel")%>"></span>
							</div>
							<div id="addrForm_<%=info.fieldName(tmpFor)%>3">
								<ul>
									<li style="height:26px;">
									<input name="<%=info.fieldName(tmpFor)%>3" type="text" id="<%=info.fieldName(tmpFor)%>3" size="10" readonly class="input_text mr5" value="<%=tmpArrData(0)%>"><span class="button medium"><input type="button" onClick="Member.PostStep1('<%=info.fieldName(tmpFor)%>');" value="<%=objXmlLang("btn_post_find")%>"></span>
									</li>
									<li style="height:26px;"><input name="<%=info.fieldName(tmpFor)%>4" type="text" id="<%=info.fieldName(tmpFor)%>4" size="60" readonly value="<%=tmpArrData(1)%>"></li>
									<li style="height:26px;"><input name="<%=info.fieldName(tmpFor)%>5" type="text" id="<%=info.fieldName(tmpFor)%>5" size="60" value="<%=tmpArrData(2)%>"></li>
								</ul>
							</div>
						</td>
					</tr>
<%
			CASE "corpnum"
%>
					<tr>
						<th scope="row"><div class="<% IF info.rquired(tmpFor) = False THEN %>no_<% END IF %>require"><%=info.title(tmpFor)%></div></th>
						<td class="detail">
							<input name="<%=info.fieldName(tmpFor)%>" type="text" class="integer ime_mode" id="<%=info.fieldName(tmpFor)%>1" maxlength="3" value="<%=LEFT(objMemberInfo(info.fieldName(tmpFor)),3)%>" style="width:30px;" />&nbsp;-&nbsp;
							<input name="<%=info.fieldName(tmpFor)%>" type="text" class="integer ime_mode" id="<%=info.fieldName(tmpFor)%>2" maxlength="3" value="<%=MID(objMemberInfo(info.fieldName(tmpFor)),4,2)%>" style="width:20px;" />&nbsp;-&nbsp;
							<input name="<%=info.fieldName(tmpFor)%>" type="text" class="integer ime_mode" id="<%=info.fieldName(tmpFor)%>3" maxlength="5" value="<%=MID(objMemberInfo(info.fieldName(tmpFor)),6,5)%>" style="width:50px;" />
						</td>
					</tr>
<%
			END SELECT
		END IF
	NEXT
%>
					<tr>
						<th scope="row"><div class="no_require"><%=objXmlLang("title_profile")%></div></th>
						<td class="detail">
							<ul>
								<li id="photofile_view" class="fl mr5" style="display:<% IF objMemberInfo("strProfile") = "" THEN %> none<% ELSE %> block<% END IF %>"><img id="photofile_img" src="../<%=CONF_strFilePath%>/Member/Profile/<%=memberSeq%>/<%=objMemberInfo("strProfile")%>" width="<%=strPhotoSize(0)%>" height="<%=strPhotoSize(1)%>" /></li>
								<li class="fl mr5"><span id="spanButtonPlaceHolder1"></span></li>
								<li id="photofile_remove" class="fl mr5" style="display:<% IF objMemberInfo("strProfile") = "" THEN %> none<% ELSE %> block<% END IF %>"><span class="button medium"><input type="button" id="btn_remove_photofile" value="<%=objXmlLang("btn_remove")%>"></span></li>
								<li class="fl">(<%=strPhotoSize(0)%>px x <%=strPhotoSize(1)%>px)</li>
							</ul>
							<div class="both" id="fsUploadProgress1"></div>
						</td>
					</tr>
					<tr>
						<th scope="row"><div class="no_require"><%=objXmlLang("title_name_image")%></div></th>
						<td class="detail">
							<ul>
								<li id="namefile_view" class="fl mr5" style="display:<% IF objMemberInfo("strNameFile") = "" THEN %> none<% ELSE %> block<% END IF %>"><img id="namefile_img" src="../<%=CONF_strFilePath%>/Member/name/<%=memberSeq%>/<%=objMemberInfo("strNameFile")%>" width="<%=strNameImgSize(0)%>" height="<%=strNameImgSize(1)%>" /></li>
								<li class="fl mr5"><span id="spanButtonPlaceHolder2"></span></li>
								<li id="namefile_remove" class="fl mr5" style="display:<% IF objMemberInfo("strNameFile") = "" THEN %> none<% ELSE %> block<% END IF %>"><span class="button medium"><input type="button" id="btn_remove_namefile" value="<%=objXmlLang("btn_remove")%>"></span></li>
								<li class="fl">(<%=strNameImgSize(0)%>px x <%=strNameImgSize(1)%>px)</li>
							</ul>
							<div class="both" id="fsUploadProgress2"></div>
						</td>
					</tr>
					<tr>
						<th scope="row"><div class="no_require"><%=objXmlLang("title_mark_image")%></div></th>
						<td class="detail">
							<ul>
								<li id="markfile_view" class="fl mr5" style="display:<% IF objMemberInfo("strMarkFile") = "" THEN %> none<% ELSE %> block<% END IF %>"><img id="markfile_img" src="../<%=CONF_strFilePath%>/Member/mark/<%=memberSeq%>/<%=objMemberInfo("strMarkFile")%>" width="<%=strMarkImgSize(0)%>" height="<%=strMarkImgSize(1)%>" /></li>
								<li class="fl mr5"><span id="spanButtonPlaceHolder3"></span></li>
								<li id="markfile_remove" class="fl mr5" style="display:<% IF objMemberInfo("strMarkFile") = "" THEN %> none<% ELSE %> block<% END IF %>"><span class="button medium"><input type="button" id="btn_remove_markfile" value="<%=objXmlLang("btn_remove")%>"></span></li>
								<li class="fl">(<%=strMarkImgSize(0)%>px x <%=strMarkImgSize(1)%>px)</li>
							</ul>
							<div class="both" id="fsUploadProgress3"></div>
						</td>
					</tr>
				</table>
				<h4><%=objXmlLang("page_sub_title_2")%></h4>
				<table class="tabletype02">
					<tr>
						<th scope="row"><div class="no_require"><%=objXmlLang("title_member_type")%></div></th>
						<td class="detail">
						<select name="strMemberType" id="strMemberType">
						<%=GetMakeSelectForm(objXmlLang("option_member_type"), ",", objMemberInfo("strMemberType"), "")%>
						</select>
						<p class="tip"><%=objXmlLang("about_group")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><div class="no_require"><%=objXmlLang("title_group")%></div></th>
						<td class="detail">
						<select name="strGroupCode" id="strGroupCode">
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_LIST] ")

	WHILE NOT(RS.EOF)
%>
						<option value="<%=RS("strGroupCode")%>"<% IF objMemberInfo("strGroupCode") = RS("strGroupCode") THEN %> selected<% END IF %>><%=RS("strTitle")%></option>
<%
	RS.MOVENEXT
	WEND
%>
						</select>
						<p class="tip"><%=objXmlLang("about_group")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><div class="no_require"><%=objXmlLang("title_level")%></div></th>
						<td class="detail">
						<select name="intLevel" id="intLevel">
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_LEVEL_LIST] ")

	WHILE NOT(RS.EOF)
%>
						<option value="<%=RS("intLevel")%>"<% IF RS("intLevel") = objMemberInfo("intLevel") THEN %> selected<% END IF %>><%=RS("strLevelTitle")%></option>
<%
	RS.MOVENEXT
	WEND
%>
						</select>
						<p class="tip"><%=objXmlLang("about_level")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><div class="no_require"><%=objXmlLang("title_auth")%></div></th>
						<td class="detail">
						<dl class="radio_form">
						<%=GetMakeRadioForm(objXmlLang("option_auth"), ",", GetBitTypeNumberChg(objMemberInfo("bitAuth")), "bitAuth", "<dd>", "</dd>")%>
						</dl>
						<p class="tip"><%=objXmlLang("about_auth")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><div class="no_require"><%=objXmlLang("title_stop")%></div></th>
						<td class="detail">
						<dl class="radio_form">
						<%=GetMakeRadioForm(objXmlLang("option_stop"), ",", GetBitTypeNumberChg(objMemberInfo("bitStop")), "bitStop", "<dd>", "</dd>")%>
						</dl>
						<p class="tip"><%=objXmlLang("about_stop")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><div class="no_require"><%=objXmlLang("title_no_login")%></div></th>
						<td class="detail">
						<span class="fl mr5">
						<input name="strLoginNoDate" type="text" id="strLoginNoDate" style="color:#666; background:#fff;" value="<%=objMemberInfo("strLoginNoDate")%>" size="10" readonly="readonly" /><input type="button" id="btnStartCal" class="btn_calendar" onClick="calendar(event, 'strLoginNoDate');" />
						</span>
						<span class="fl"><span class="button medium"><input type="button" id="btnLoginNoDateReset" value="<%=objXmlLang("btn_cancel")%>"></span></span>
						<p class="tip"><%=objXmlLang("about_no_login")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><div class="no_require"><%=objXmlLang("title_memo")%></div></th>
						<td class="detail">
						<textarea name="strAdminMemo" id="strAdminMemo" class="resizable"><%=objMemberInfo("strAdminMemo")%></textarea>
						<p class="tip"><%=objXmlLang("about_memo")%></p>
						</td>
					</tr>
				</table>
				<div class="formButtonBox">
				<span class="button large strong"><input type="submit" id="btnModify" value="<%=objXmlLang("btn_modify")%>"></span>
				<span class="button large"><input type="button" id="btnList" value="<%=objXmlLang("btn_list")%>"></span>
				</div>
			</div>
			</form>
		</div>
<%
	SET objMemberInfo = NOTHING
%>
<!-- #include file = "../comm/sub.foot.asp" -->