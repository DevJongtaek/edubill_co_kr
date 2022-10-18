<!-- #include file = "../../../Include/Member.Modify.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.modify.js"></script>
<script type="text/javascript" src="js/editor.js"></script>
<div id="bodyWrap" class="modify_info">
	<div class="page_navi">
		<h4><%=objXmlLang("manage_profile")%></h4>
	</div>
	<div class="description">
		<%=objXmlLang("about_revision_changes")%>
	</div>
		<form id="theForm" method="post">
		<input type="hidden" id="joinType" name="joinType" value="modify" />
		<input type="hidden" id="change_email" name="change_email" value="0" />
		<input type="hidden" id="change_nick" name="change_nick" value="0" />
    <input type="hidden" id="intSeq" name="intSeq" value="<%=objMemberInfo("intSeq")%>" />
		<input type="hidden" id="strMemberType" name="strMemberType" value="<%=objMemberInfo("strMemberType")%>" />
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
		<input type="hidden" id="strHomeAddr" name="strHomeAddr" />
 		<div class="table01">
			<div class="table_coment_bg">
				<p class="table_coment"><%=objXmlLang("about_required")%></p>
			</div>
		<table width="100%">
<%
	DIM tmpArrData
	iCount = 0
	FOR tmpFor = 0 TO UBOUND(info.fieldName)
		IF info.fieldName(tmpFor) <> "" THEN
			iCount = iCount + 1
			SELECT CASE info.formType(tmpFor)
			CASE "userid"
%>
		<tr<% IF iCount = 1 THEN %> class="first<% END IF %>">
			<th class="require"><%=info.title(tmpFor)%></th>
			<td class="default">
      	<%=objMemberInfo(info.fieldName(tmpFor))%>
			</td>
		</tr>
<%
			CASE "nick"
%>
		<tr>
			<th class="require"><%=info.title(tmpFor)%></th>
			<td class="default">
        <input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text userid" id="<%=info.fieldName(tmpFor)%>" value="<%=objMemberInfo(info.fieldName(tmpFor))%>" maxlength="50"  />
				</select>
			</td>
		</tr>
<%
			CASE "email"
%>
		<tr>
			<th class="require"><%=info.title(tmpFor)%></th>
			<td class="default">
        <ul>
        	<li class="fl">
            <input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text email" id="<%=info.fieldName(tmpFor)%>1" value="<%=objMemberInfo(info.fieldName(tmpFor) & "1")%>" maxlength="100" /> @
            <input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text email" id="<%=info.fieldName(tmpFor)%>2" value="<%=objMemberInfo(info.fieldName(tmpFor) & "2")%>" maxlength="100" />
            <select name="email_list" id="email_list" class="input_select">
            <%=GetMakeSelectForm(objXmlLang("option_user_input"), ",", "", "")%>
            <%=GetMakeSelectForm(info.formData(tmpFor) & "$$$" & info.formData(tmpFor), CHR(10), "", "")%>
            </select>
					</li>
          <li class="certified1">
						<span class="button medium"><input type="button" class="btn_get_auth" value="<%=objXmlLang("cmd_certification_number")%>" /></span>
					</li>
          <li class="certified2">
						<span class="button medium"><input type="button" class="btn_get_re_auth" value="<%=objXmlLang("cmd_certification_cancel")%>" /></span>
					</li>
          <li class="certified3">
            <input type="text" id="authCode" name="authCode" class="input_text auth_email" />
            <span class="button medium"><input type="button" class="btn_put_auth" value="<%=objXmlLang("cmd_certification")%>" /></span>
					</li>
				</ul>
			</td>
		</tr>
<%
			CASE "text", "url"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
        <input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text" id="<%=info.fieldName(tmpFor)%>" value="<%=objMemberInfo(info.fieldName(tmpFor))%>" style="width:<%=info.width(tmpFor)%>px;"  />
			</td>
		</tr>
<%
			CASE "tel"
				tmpArrData = objMemberInfo(info.fieldName(tmpFor))
				IF tmpArrData <> "" AND ISNULL(tmpArrData) = False THEN tmpArrData = SPLIT(tmpArrData, "-") ELSE tmpArrData = SPLIT("--", "-")
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text tel integer ime_mode" id="<%=info.fieldName(tmpFor)%>1" value="<%=tmpArrData(0)%>" maxlength="4" />&nbsp;-&nbsp;
				<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text tel integer ime_mode" id="<%=info.fieldName(tmpFor)%>2" value="<%=tmpArrData(1)%>" maxlength="4" />&nbsp;-&nbsp;
				<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text tel integer ime_mode" id="<%=info.fieldName(tmpFor)%>3" value="<%=tmpArrData(2)%>" maxlength="4" />
			</td>
		</tr>
<%
			CASE "mobile"
				tmpArrData = objMemberInfo(info.fieldName(tmpFor))
				IF tmpArrData <> "" AND ISNULL(tmpArrData) = False THEN tmpArrData = SPLIT(tmpArrData, "-") ELSE tmpArrData = SPLIT("--", "-")
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<select name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>1" class="input_select">
				<%=GetMakeSelectForm(objXmlLang("option_select"), ",", tmpArrData(0), "")%>
				<%=GetPhoneFirstNumber(info.formType(tmpFor), tmpArrData(0))%>
				</select>
        &nbsp;-&nbsp;
				<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text tel integer ime_mode" id="<%=info.fieldName(tmpFor)%>2" value="<%=tmpArrData(1)%>" maxlength="4" />&nbsp;-&nbsp;
				<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text tel integer ime_mode" id="<%=info.fieldName(tmpFor)%>3" value="<%=tmpArrData(2)%>" maxlength="4" />
			</td>
		</tr>
<%
			CASE "textarea"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default"><textarea name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>" class="input_textarea"><%=objMemberInfo(info.fieldName(tmpFor))%></textarea></td>
		</tr>
<%
			CASE "sign"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="editorArea">
			<textarea id="<%=info.fieldName(tmpFor)%>" name="<%=info.fieldName(tmpFor)%>" class="none"><%=objMemberInfo(info.fieldName(tmpFor))%></textarea>
			<!-- #include file = "../../../daum/editor_inc.asp" -->
      </td>
		</tr>
<%
			CASE "checkbox"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
        <dl class="radio_form">
        <%=GetMakeCheckForm(REPLACE(info.formData(tmpFor), CHR(10), ",") & "$$$" & REPLACE(info.formData(tmpFor), CHR(10), ","), ",", objMemberInfo(info.fieldName(tmpFor)), info.fieldName(tmpFor), "<dd>", "</dd>")%>
        </dl>
      </td>
		</tr>
<%
			CASE "radio"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<dl class="radio_form">
<%
				SELECT CASE info.fieldName(tmpFor)
				CASE "strSex", "bitMailing", "bitOpenInfo", "bitMemo"
					RESPONSE.WRITE GetMakeRadioForm("1,0$$$" & REPLACE(info.formData(tmpFor), CHR(10), ","), ",", objMemberInfo(info.fieldName(tmpFor)), info.fieldName(tmpFor), "<dd>", "</dd>")
				CASE ELSE
					RESPONSE.WRITE GetMakeRadioForm(info.formData(tmpFor) & "$$$" & info.formData(tmpFor), CHR(10), objMemberInfo(info.fieldName(tmpFor)), info.fieldName(tmpFor), "<dd>", "</dd>")
				END SELECT
%>
				</dl>
      </td>
		</tr>
<%
			CASE "select"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
        <select name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>" class="input_select">
        <%=GetMakeSelectForm(objXmlLang("option_select"), ",", objMemberInfo(info.fieldName(tmpFor)), "")%>
<%
	SELECT CASE info.fieldName(tmpFor)
	CASE "strSex", "bitMailing", "bitOpenInfo", "bitMemo"
		RESPONSE.WRITE GetMakeSelectForm("1,0$$$" & REPLACE(info.formData(tmpFor), CHR(10), ","), ",", objMemberInfo(info.fieldName(tmpFor)), "")
	CASE ELSE
		RESPONSE.WRITE GetMakeSelectForm(info.formData(tmpFor) & "$$$" & info.formData(tmpFor), CHR(10), objMemberInfo(info.fieldName(tmpFor)), "")
	END SELECT
%>
				</select>
      </td>
		</tr>
<%
			CASE "birthday"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<input name="<%=info.fieldName(tmpFor)%>" type="text" id="<%=info.fieldName(tmpFor)%>1" class="input_text_calendar" value="<% IF objMemberInfo(info.fieldName(tmpFor)) <> "" AND ISNULL(objMemberInfo(info.fieldName(tmpFor))) = False THEN %><%=LEFT(objMemberInfo(info.fieldName(tmpFor)), 4)%>.<%=MID(objMemberInfo(info.fieldName(tmpFor)), 5, 2)%>.<%=MID(objMemberInfo(info.fieldName(tmpFor)), 7, 2)%><% END IF %>" size="10" readonly="readonly" /><input type="button" id="btnStartCal" class="btn_calendar" onClick="calendar(event, '<%=info.fieldName(tmpFor)%>1');" />
				<select name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>2" class="input_select">
				<%=GetMakeSelectForm(objXmlLang("option_select"), ",", objMemberInfo(info.fieldName(tmpFor)), "")%>
				<%=GetMakeSelectForm(objXmlLang("option_lunar_gregorian"), ",", RIGHT(objMemberInfo(info.fieldName(tmpFor)), 1), "")%>
				</select>
      </td>
		</tr>
<%
			CASE "date"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<input name="<%=info.fieldName(tmpFor)%>" type="text" id="<%=info.fieldName(tmpFor)%>" class="input_text_calendar" value="<% IF objMemberInfo(info.fieldName(tmpFor)) <> "" AND ISNULL(objMemberInfo(info.fieldName(tmpFor))) = False THEN %><%=LEFT(objMemberInfo(info.fieldName(tmpFor)), 4)%>.<%=MID(objMemberInfo(info.fieldName(tmpFor)), 5, 2)%>.<%=MID(objMemberInfo(info.fieldName(tmpFor)), 7, 2)%><% END IF %>" size="10" readonly="readonly" /><input type="button" id="btnStartCal" class="btn_calendar" onClick="calendar(event, '<%=info.fieldName(tmpFor)%>');" />
      </td>
		</tr>
<%
			CASE "marry"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<select name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>1" class="input_select">
				<%=GetMakeSelectForm(objXmlLang("option_married"), ",", LEFT(objMemberInfo(info.fieldName(tmpFor)), 1), "")%>
				</select>
				<input name="<%=info.fieldName(tmpFor)%>" type="text" id="<%=info.fieldName(tmpFor)%>2" class="input_text_calendar" value="<% IF objMemberInfo(info.fieldName(tmpFor)) <> "" AND ISNULL(objMemberInfo(info.fieldName(tmpFor))) = False AND RIGHT(objMemberInfo(info.fieldName(tmpFor)), 8) <> "00000000" THEN %><%=MID(objMemberInfo(info.fieldName(tmpFor)), 2, 4)%>.<%=MID(objMemberInfo(info.fieldName(tmpFor)), 6, 2)%>.<%=MID(objMemberInfo(info.fieldName(tmpFor)), 8, 2)%><% END IF %>" size="10" readonly="readonly" /><input type="button" id="btnStartCal" class="btn_calendar" onClick="calendar(event, '<%=info.fieldName(tmpFor)%>2');" />
      </td>
		</tr>
<%
			CASE "addr"
				IF objMemberInfo(info.fieldName(tmpFor)) <> "" AND ISNULL(objMemberInfo(info.fieldName(tmpFor))) = False THEN tmpArrData = objMemberInfo(info.fieldName(tmpFor)) ELSE tmpArrData = "$$$$$$"
				tmpArrData = SPLIT(tmpArrData, "$$$")
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<div class="krZip">
					<div class="item" id="zone_address_search_<%=info.fieldName(tmpFor)%>" style="display:<% IF tmpArrData(0) = "" THEN %>block<% ELSE %>none<% END IF %>;">
						<label for="krzip_address1_<%=info.fieldName(tmpFor)%>" class="zipLabel"><%=objXmlLang("kr_zip_messgae1")%></label>
						<input type="text" id="krzip_address1_<%=info.fieldName(tmpFor)%>" class="zipText input_text post" />
						<span class="button medium"><input type="button" value="<%=objXmlLang("cmd_search")%>" /></span>
					</div>
					<div class="item" id="zone_address_list_<%=info.fieldName(tmpFor)%>" style="display:<% IF tmpArrData(0) = "" THEN %>none<% ELSE %>block<% END IF %>;">
						<select name="zip" id="address_list_<%=info.fieldName(tmpFor)%>" class="input_select">
						<option value="<%=LEFT(tmpArrData(0),3)%>-<%=RIGHT(tmpArrData(0),3)%>$$$<%=tmpArrData(1)%>$$$<%=tmpArrData(2)%>">(<%=LEFT(tmpArrData(0),3)%>-<%=RIGHT(tmpArrData(0),3)%>) <%=tmpArrData(1)%></option>
						</select>
						<span class="button medium"><input type="button" value="<%=objXmlLang("cmd_research")%>" /></span>
					</div>
					<div class="item address2">
						<label for="krzip_address2_<%=info.fieldName(tmpFor)%>" class="zipLabel"><%=objXmlLang("kr_zip_messgae2")%></label>
						<input type="text" name="zip" id="krzip_address2_<%=info.fieldName(tmpFor)%>" value="<%=tmpArrData(2)%>" class="zipText input_text addr" />
					</div>
				</div>
				<script type="text/javascript">jQuery(function($){ $.krzip('<%=info.fieldName(tmpFor)%>') });</script>
      </td>
		</tr>
<%
				CASE "corpnum"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
			<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text corpnum1 integer ime_mode" id="<%=info.fieldName(tmpFor)%>1" maxlength="3" value="<%=LEFT(objMemberInfo(info.fieldName(tmpFor)),3)%>" />&nbsp;-&nbsp;
				<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text corpnum2 integer ime_mode" id="<%=info.fieldName(tmpFor)%>2" maxlength="3" value="<%=MID(objMemberInfo(info.fieldName(tmpFor)),4,2)%>" />&nbsp;-&nbsp;
				<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text corpnum3 integer ime_mode" id="<%=info.fieldName(tmpFor)%>3" maxlength="5" value="<%=MID(objMemberInfo(info.fieldName(tmpFor)),6,5)%>" />
      </td>
		</tr>
<%
			END SELECT
		END IF
	NEXT
%>
<% IF CONF_bitUsePhoto = True THEN %>
		<tr>
			<th><%=objXmlLang("photo_image")%></th>
			<td class="default">
				<ul class="memberUploadImage1">
					<li<% IF objMemberInfo("strProfile") = "" THEN %> style="display:none;"<% END IF %>>
						<img class="photofile_img" src="<%=CONF_strFilePath%>/Member/Profile/<%=SESSION("memberSeq")%>/<%=objMemberInfo("strProfile")%>" width="<%=CONF_strPhotoSize(0)%>" height="<%=CONF_strPhotoSize(1)%>" />
						<span class="button medium"><input type="button" class="btn_remove_photofile" id="img_profile" value="<%=objXmlLang("cmd_delete")%>"></span>
					</li>
					<li><span id="spanButtonPlaceHolder1"></span></li>
					<li>(<%=CONF_strPhotoSize(0)%>px X <%=CONF_strPhotoSize(1)%>px)</li>
				</ul>
				<div class="both" id="fsUploadProgress1"></div>
      </td>
		</tr>
<% END IF %>
<% IF CONF_bitUseNameImg = True THEN %>
		<tr>
			<th><%=objXmlLang("name_image")%></th>
			<td class="default">
				<ul class="memberUploadImage2">
					<li<% IF objMemberInfo("strNameFile") = "" THEN %> style="display:none;"<% END IF %>>
						<img class="namefile_img" src="<%=CONF_strFilePath%>/Member/name/<%=SESSION("memberSeq")%>/<%=objMemberInfo("strNameFile")%>" width="<%=CONF_strNameImgSize(0)%>" height="<%=CONF_strNameImgSize(1)%>" />
						<span class="button medium"><input type="button" class="btn_remove_namefile" id="img_name" value="<%=objXmlLang("cmd_delete")%>"></span>
					</li>
					<li><span id="spanButtonPlaceHolder2"></span></li>
					<li>(<%=CONF_strNameImgSize(0)%>px X <%=CONF_strNameImgSize(1)%>px)</li>
				</ul>
				<div class="both" id="fsUploadProgress2"></div>
      </td>
		</tr>
<% END IF %>
<% IF CONF_bitUseMarkImg = True THEN %>
		<tr>
			<th><%=objXmlLang("mark_image")%></th>
			<td class="default">
				<ul class="memberUploadImage3">
					<li<% IF objMemberInfo("strMarkFile") = "" THEN %> style="display:none;"<% END IF %>>
						<img class="markfile_img" src="<%=CONF_strFilePath%>/Member/mark/<%=SESSION("memberSeq")%>/<%=objMemberInfo("strMarkFile")%>" width="<%=CONF_strMarkImgSize(0)%>" height="<%=CONF_strMarkImgSize(1)%>" />
						<span class="button medium"><input type="button" class="btn_remove_markfile" id="img_mark" value="<%=objXmlLang("cmd_delete")%>"></span>
					</li>
					<li><span id="spanButtonPlaceHolder3"></span></li>
					<li>(<%=CONF_strMarkImgSize(0)%>px X <%=CONF_strMarkImgSize(1)%>px)</li>
				</ul>
				<div class="both" id="fsUploadProgress3"></div>
      </td>
		</tr>
<% END IF %>
		</table>
		</div>
		<div class="btn_area">
			<span class="button large strong"><input type="submit" name="btn_ok" value="<%=objXmlLang("cmd_confirm")%>" /></span>
			<span class="button large strong"><a href="/"><%=objXmlLang("cmd_cancel")%></a></span>
		</div>
		</form>
	</div>
<!-- #include file = "common.footer.asp" -->