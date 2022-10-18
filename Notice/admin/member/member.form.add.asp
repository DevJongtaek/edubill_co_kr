<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM langXmlPath, langXmlFile

	langXmlPath = Server.MapPath("../") & "\"
	langXmlFile = "lang.member.form.xml"

	DIM act, strGroupCode
	act          = GetInputReplce(REQUEST.QueryString("act"), "")
	IF Act = "" THEN Act = "formadd"

	strFieldName = GetInputReplce(REQUEST.FORM("fieldName"), "")

	DIM strTitle, strSubTitle, strAlertMsg, strDefault, bitUse, bitRquired, strFormType, strFormData, intWidth, strDescription

	SELECT CASE LCASE(Act)
	CASE "formadd"

		bitDefault = "0"

	CASE "formedit"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_FORM_READ] '" & strFieldName & "' ")

		strTitle       = GetReplaceTag2Text(RS("strTitle"))
		strSubTitle    = GetReplaceTag2Text(RS("strSubTitle"))
		strAlertMsg    = GetReplaceTag2Text(RS("strAlertMsg"))
		strDefault     = RS("strDefault")
		bitUse         = GetBitTypeNumberChg(RS("bitUse"))
		bitRquired     = GetBitTypeNumberChg(RS("bitRquired"))
		strFormType    = RS("strFormType")
		strFormData    = RS("strFormData")
		intWidth       = RS("intWidth")
		strDescription = RS("strDescription")

	END SELECT

	DIM xmlDOM, objRoot, firstLoop, secondLoop, thirdLoop
	Set xmlDOM = Server.CreateObject("Microsoft.XMLDOM")
	xmlDOM.async = false
%>
<!-- #include file = "../lang/lang.admin.page.control.asp" -->
<%
	DIM strFormTypeTitle, strFormTypeVal, strFormTypeSplit

	SELECT CASE strFieldName
	CASE "strLoginID"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_userid"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
	CASE "strEmail"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_email"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
	CASE "strUserName", "strCorpName", "strCorpJob1", "strCorpJob2"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_text"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
	CASE "strNickName"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_nick"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
	CASE "strSex", "bitMailing", "bitOpenInfo", "bitMemo"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_radio"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
		strFormTypeSplit = SPLIT(objXmlLang("option_field_select"),"$$$")
		strFormTypeTitle = strFormTypeTitle & "," & strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeVal   & "," & strFormTypeSplit(0)
	CASE "strPassword"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_password"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
	CASE "strBirthday"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_birthday"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
	CASE "strHomeTel"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_tel"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
	CASE "strMobile"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_mobile"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
	CASE "strHomePage"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_url"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
	CASE "strCountry"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_select"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
	CASE "strHomeAddr", "strCorpAddr"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_addr"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
	CASE "strSSN"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_ssn"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
	CASE "strJob"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_select"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
		strFormTypeSplit = SPLIT(objXmlLang("option_field_radio"),"$$$")
		strFormTypeTitle = strFormTypeTitle & "," & strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeVal   & "," & strFormTypeSplit(0)
		strFormTypeSplit = SPLIT(objXmlLang("option_field_text"),"$$$")
		strFormTypeTitle = strFormTypeTitle & "," & strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeVal   & "," & strFormTypeSplit(0)
	CASE "strMarry"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_marry"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
	CASE "strMyMemo"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_text"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
		strFormTypeSplit = SPLIT(objXmlLang("option_field_textarea"),"$$$")
		strFormTypeTitle = strFormTypeTitle & "," & strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeVal   & "," & strFormTypeSplit(0)
	CASE "strUserSign"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_sign"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
	CASE "strCorpNum"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_corpnum"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
	CASE "strAddData1", "strAddData2", "strAddData3", "strAddData4", "strAddData5", "strAddData6", "strAddData7", "strAddData8", "strAddData9", "strAddData10"
		strFormTypeSplit = SPLIT(objXmlLang("option_field_text"),"$$$")
		strFormTypeTitle = strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeSplit(0)
		strFormTypeSplit = SPLIT(objXmlLang("option_field_url"),"$$$")
		strFormTypeTitle = strFormTypeTitle & "," & strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeVal   & "," & strFormTypeSplit(0)
'		strFormTypeSplit = SPLIT(objXmlLang("option_field_email"),"$$$")
'		strFormTypeTitle = strFormTypeTitle & "," & strFormTypeSplit(1)
'		strFormTypeVal   = strFormTypeVal   & "," & strFormTypeSplit(0)
		strFormTypeSplit = SPLIT(objXmlLang("option_field_tel"),"$$$")
		strFormTypeTitle = strFormTypeTitle & "," & strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeVal   & "," & strFormTypeSplit(0)
		strFormTypeSplit = SPLIT(objXmlLang("option_field_mobile"),"$$$")
		strFormTypeTitle = strFormTypeTitle & "," & strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeVal   & "," & strFormTypeSplit(0)
		strFormTypeSplit = SPLIT(objXmlLang("option_field_textarea"),"$$$")
		strFormTypeTitle = strFormTypeTitle & "," & strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeVal   & "," & strFormTypeSplit(0)
		strFormTypeSplit = SPLIT(objXmlLang("option_field_checkbox"),"$$$")
		strFormTypeTitle = strFormTypeTitle & "," & strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeVal   & "," & strFormTypeSplit(0)
		strFormTypeSplit = SPLIT(objXmlLang("option_field_select"),"$$$")
		strFormTypeTitle = strFormTypeTitle & "," & strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeVal   & "," & strFormTypeSplit(0)
		strFormTypeSplit = SPLIT(objXmlLang("option_field_radio"),"$$$")
		strFormTypeTitle = strFormTypeTitle & "," & strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeVal   & "," & strFormTypeSplit(0)
		strFormTypeSplit = SPLIT(objXmlLang("option_field_addr"),"$$$")
		strFormTypeTitle = strFormTypeTitle & "," & strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeVal   & "," & strFormTypeSplit(0)
		strFormTypeSplit = SPLIT(objXmlLang("option_field_date"),"$$$")
		strFormTypeTitle = strFormTypeTitle & "," & strFormTypeSplit(1)
		strFormTypeVal   = strFormTypeVal   & "," & strFormTypeSplit(0)
	END SELECT

	SELECT CASE strFieldName
	CASE "strSex"      : strFormData = REPLACE(REPLACE(objXmlLang("option_sex"), "$$$", ""), ",", CHR(10))
	CASE "bitMailing"  : strFormData = REPLACE(REPLACE(objXmlLang("option_mailing"), "$$$", ""), ",", CHR(10))
	CASE "bitOpenInfo" : strFormData = REPLACE(REPLACE(objXmlLang("option_open"), "$$$", ""), ",", CHR(10))
	END SELECT
%>
<script type="text/javascript" src="member/js/member.form.add.js"></script>
						<form id="theForm" action="action/?subAct=memberform&Act=formmodify">
						<table id="detail_table" class="baseTable">
							<colgroup>
								<col width="90" /><col/>
							</colgroup>
							<tbody>
							<tr>
								<th><%=objXmlLang("title_field")%></th>
								<td>
								<input name="strFieldName" type="text" id="strFieldName" value="<%=strFieldName%>" size="60" maxlength="100" readonly="readonly">
								<p class="tip"><%=objXmlLang("about_field")%></p>
								</td>
							</tr>
							<tr>
								<th><%=objXmlLang("title_subject")%></th>
								<td>
								<input name="strTitle" type="text" id="strTitle" value="<%=strTitle%>" size="60" maxlength="60">
								<p class="tip"><%=objXmlLang("about_subject")%></p>
								</td>
							</tr>
							<tr>
								<th><%=objXmlLang("title_subject_sub")%></th>
								<td>
								<input name="strSubTitle" type="text" id="strSubTitle" value="<%=strSubTitle%>" size="60" maxlength="60">
								<p class="tip"><%=objXmlLang("about_subject_sub")%></p>
								</td>
							</tr>
							<tr>
								<th><%=objXmlLang("title_type")%></th>
								<td>
								<select name="strFormType" id="strFormType" style="width:150px;" onchange="MemberForm.FormType();">
								<%=GetMakeSelectForm(strFormTypeVal & "$$$" & strFormTypeTitle, ",", strFormType, "")%>
								</select>
								<p class="tip"><%=objXmlLang("about_type")%></p>
								</td>
							</tr>
							<tr id="dispFormOption">
								<th><%=objXmlLang("title_option")%></th>
								<td>
								<textarea name="strFormData" id="strFormData" cols="45" rows="5"><%=strFormData%></textarea>
								<p class="tip"><%=objXmlLang("about_option")%></p>
								</td>
							</tr>
							<tr>
								<th><%=objXmlLang("title_use")%></th>
								<td>
								<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitUse, "bitUse", "<dd>", "</dd>")%>
								</dl>
								</td>
							</tr>
							<tr>
								<th><%=objXmlLang("title_rquired")%></th>
								<td>
								<dl class="radio_form">
								<%=GetMakeRadioForm(objXmlLang("option_rquired"), ",", bitRquired, "bitRquired", "<dd>", "</dd>")%>
								</dl>
								</td>
							</tr>
							<tr>
								<th><%=objXmlLang("title_alert")%></th>
								<td>
								<input name="strAlertMsg" type="text" id="strAlertMsg" value="<%=strAlertMsg%>" size="70" maxlength="200">
								<p class="tip"><%=objXmlLang("about_alert")%></p>
								</td>
							</tr>
							<tr id="dispWidth">
								<th><%=objXmlLang("title_width")%></th>
								<td>
								<input name="intWidth" type="text" id="intWidth" value="<%=intWidth%>" size="8" maxlength="4" class="integer ime_mode">
								px
							</td>
							</tr>
							<tr>
								<th><%=objXmlLang("title_memo")%></th>
								<td class="text"><textarea name="strDescription" id="strDescription" cols="45" rows="5"><%=strDescription%></textarea></td>
							</tr>
							</tbody>
						</table>
						<div class="formButtonBox mt10">
						<span class="button large strong"><input type="submit" id="btn_save" class="btn_save" value="<%=objXmlLang("btn_save")%>"></span>
						</div>
						</form>
<%
	SET RS = NOTHING : DBCON.CLOSE
%>