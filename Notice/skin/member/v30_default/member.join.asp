<!-- #include file = "../../../Include/Member.Join.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/member.join.js"></script>
<script type="text/javascript" src="js/editor.js"></script>
<div id="bodyWrap" class="input_info">
	<div class="page_navi">
		<h4><%=objXmlLang("basic_information")%></h4>
		<ul class="navi">
		<li class="n1"><span><%=objXmlLang("agreement")%></span></li>
		<li class="n2"><span><%=objXmlLang("Identification")%></span></li>
		<li class="n3"><span><%=objXmlLang("authentication")%></span></li>
		<li class="n4"><strong><%=objXmlLang("basic_information")%></strong></li>
		<li class="n5"><span><%=objXmlLang("signup_complete")%></span></li>
		</ul>
	</div>
	<div class="description"><%=objXmlLang("about_profile_safety")%></div>
		<form id="theForm" method="post">
		<input type="hidden" id="joinType" name="joinType" value="join" />
		<input type="hidden" id="strMemberType" name="strMemberType" />
		<input type="hidden" id="strSSN" name="strSSN" />
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
				<div class="help_wrap">
					<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text userid" id="<%=info.fieldName(tmpFor)%>" maxlength="32" />
					<span class="button medium"><input type="button" value="<%=objXmlLang("cmd_exists")%>" class="btn_id_check" /></span>
					<span id="IdCheckMsg"></span>
					<div id="useridLayerDesc" class="help layer_comment layer_userid">
						<%=objXmlLang("about_user_id")%>
						<div class="tail"></div>
					</div>
				</div>
				<p class="tip"><%=info.memo(tmpFor)%></p>
			</td>
		</tr>
<%
			CASE "password"
%>
		<tr>
			<th class="require"><%=info.title(tmpFor)%></th>
			<td class="default">
				<div class="help_wrap">
					<input name="<%=info.fieldName(tmpFor)%>" type="password" class="input_text userid" id="<%=info.fieldName(tmpFor)%>" maxlength="32"  />
					<span id="pwLevel" ></span>
					<div id="passwordLayerDesc" class="help layer_comment layer_password">
						<%=objXmlLang("about_user_password")%>
						<div class="tail"></div>
					</div>
				</div>
				<p class="tip"><%=info.memo(tmpFor)%></p>
			</td>
		</tr>
		<tr>
			<th class="require"><%=info.subtitle(tmpFor)%></th>
			<td class="default">
				<input name="<%=info.fieldName(tmpFor)%>2" type="password" class="input_text userid" id="<%=info.fieldName(tmpFor)%>2" maxlength="32"  />
			</td>
		</tr>
<%
			CASE "nick"
%>
		<tr>
			<th class="require"><%=info.title(tmpFor)%></th>
			<td class="default">
        <input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text userid" id="<%=info.fieldName(tmpFor)%>" maxlength="50"  />
				<p class="tip"><%=info.memo(tmpFor)%></p>
			</td>
		</tr>
<%
			CASE "email"
%>
		<tr>
			<th class="require"><%=info.title(tmpFor)%></th>
			<td class="default">
        <input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text email" id="<%=info.fieldName(tmpFor)%>1" maxlength="100" /> @
        <input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text email" id="<%=info.fieldName(tmpFor)%>2" maxlength="100" />
				<select name="email_list" id="email_list" class="input_select">
				<%=GetMakeSelectForm(objXmlLang("option_user_input"), ",", "", "")%>
        <%=GetMakeSelectForm(info.formData(tmpFor) & "$$$" & info.formData(tmpFor), CHR(10), "", "")%>
				</select>
				<p class="tip"><%=info.memo(tmpFor)%></p>
			</td>
		</tr>
<%
			CASE "text", "url"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text" id="<%=info.fieldName(tmpFor)%>" style="width:<%=info.width(tmpFor)%>px;"  />
				<p class="tip"><%=info.memo(tmpFor)%></p>
			</td>
		</tr>
<%
			CASE "tel"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text tel integer ime_mode" id="<%=info.fieldName(tmpFor)%>1" maxlength="4" />&nbsp;-&nbsp;
				<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text tel integer ime_mode" id="<%=info.fieldName(tmpFor)%>2" maxlength="4" />&nbsp;-&nbsp;
				<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text tel integer ime_mode" id="<%=info.fieldName(tmpFor)%>3" maxlength="4" />
				<p class="tip"><%=info.memo(tmpFor)%></p>
			</td>
		</tr>
<%
			CASE "mobile"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<select name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>1" class="input_select">
				<%=GetMakeSelectForm(objXmlLang("option_select"), ",", "", "")%>
				<%=GetPhoneFirstNumber(info.formType(tmpFor), "")%>
				</select>
        &nbsp;-&nbsp;
				<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text tel integer ime_mode" id="<%=info.fieldName(tmpFor)%>2" maxlength="4" />&nbsp;-&nbsp;
				<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text tel integer ime_mode" id="<%=info.fieldName(tmpFor)%>3" maxlength="4" />
				<p class="tip"><%=info.memo(tmpFor)%></p>
			</td>
		</tr>
<%
			CASE "textarea"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<textarea name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>" class="input_textarea"></textarea>
				<p class="tip"><%=info.memo(tmpFor)%></p>
			</td>
		</tr>
<%
			CASE "sign"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="editorArea">
			<textarea id="<%=info.fieldName(tmpFor)%>" name="<%=info.fieldName(tmpFor)%>" class="none"></textarea>
			<!-- #include file = "../../../daum/editor_inc.asp" -->
			<p class="tip"><%=info.memo(tmpFor)%></p>
      </td>
		</tr>
<%
			CASE "checkbox"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
        <dl class="radio_form">
        <%=GetMakeCheckForm(REPLACE(info.formData(tmpFor), CHR(10), ",") & "$$$" & REPLACE(info.formData(tmpFor), CHR(10), ","), ",", "", info.fieldName(tmpFor), "<dd>", "</dd>")%>
        </dl>
				<p class="tip"><%=info.memo(tmpFor)%></p>
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
		RESPONSE.WRITE GetMakeRadioForm("1,0$$$" & REPLACE(info.formData(tmpFor), CHR(10), ","), ",", "", info.fieldName(tmpFor), "<dd>", "</dd>")
	CASE ELSE
		RESPONSE.WRITE GetMakeRadioForm(info.formData(tmpFor) & "$$$" & info.formData(tmpFor), CHR(10), "", info.fieldName(tmpFor), "<dd>", "</dd>")
	END SELECT
%>
				</dl>
				<p class="tip"><%=info.memo(tmpFor)%></p>
      </td>
		</tr>
<%
			CASE "select"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
        <select name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>" class="input_select">
        <%=GetMakeSelectForm(objXmlLang("option_select"), ",", "", "")%>
<%
	SELECT CASE info.fieldName(tmpFor)
	CASE "strSex", "bitMailing", "bitOpenInfo", "bitMemo"
		RESPONSE.WRITE GetMakeSelectForm("1,0$$$" & REPLACE(info.formData(tmpFor), CHR(10), ","), ",", "", "")
	CASE ELSE
		RESPONSE.WRITE GetMakeSelectForm(info.formData(tmpFor) & "$$$" & info.formData(tmpFor), CHR(10), "", "")
	END SELECT
%>
				</select>
				<p class="tip"><%=info.memo(tmpFor)%></p>
      </td>
		</tr>
<%
			CASE "birthday"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<input name="<%=info.fieldName(tmpFor)%>" type="text" id="<%=info.fieldName(tmpFor)%>1" class="input_text_calendar" size="10" readonly="readonly" /><input type="button" id="btnStartCal" class="btn_calendar" onClick="calendar(event, '<%=info.fieldName(tmpFor)%>1');" />
				<select name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>2" class="input_select">
				<%=GetMakeSelectForm(objXmlLang("option_select"), ",", "", "")%>
				<%=GetMakeSelectForm(objXmlLang("option_lunar_gregorian"), ",", "", "")%>
				</select>
				<p class="tip"><%=info.memo(tmpFor)%></p>
      </td>
		</tr>
<%
			CASE "date"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<input name="<%=info.fieldName(tmpFor)%>" type="text" id="<%=info.fieldName(tmpFor)%>" class="input_text_calendar" size="10" readonly="readonly" /><input type="button" id="btnStartCal" class="btn_calendar" onClick="calendar(event, '<%=info.fieldName(tmpFor)%>');" />
				<p class="tip"><%=info.memo(tmpFor)%></p>
      </td>
		</tr>
<%
			CASE "marry"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<select name="<%=info.fieldName(tmpFor)%>" id="<%=info.fieldName(tmpFor)%>1" class="input_select">
				<%=GetMakeSelectForm(objXmlLang("option_married"), ",", "", "")%>
				</select>
				<input name="<%=info.fieldName(tmpFor)%>" type="text" id="<%=info.fieldName(tmpFor)%>2" class="input_text_calendar" size="10" readonly="readonly" /><input type="button" id="btnStartCal" class="btn_calendar" onClick="calendar(event, '<%=info.fieldName(tmpFor)%>2');" />
				<p class="tip"><%=info.memo(tmpFor)%></p>
      </td>
		</tr>
<%
			CASE "addr"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<div class="krZip">
					<div class="item" id="zone_address_search_<%=info.fieldName(tmpFor)%>">
						<label for="krzip_address1_<%=info.fieldName(tmpFor)%>" class="zipLabel"><%=objXmlLang("kr_zip_messgae1")%></label>
						<input type="text" id="krzip_address1_<%=info.fieldName(tmpFor)%>" class="zipText input_text post" />
						<span class="button medium"><input type="button" value="<%=objXmlLang("cmd_search")%>" /></span>
					</div>
					<div class="item" id="zone_address_list_<%=info.fieldName(tmpFor)%>" style="display:none">
						<select name="address_list_<%=info.fieldName(tmpFor)%>" id="address_list_<%=info.fieldName(tmpFor)%>" class="input_select"></select>
						<span class="button medium"><input type="button" value="<%=objXmlLang("cmd_research")%>" /></span>
					</div>
					<div class="item address2">
						<label for="krzip_address2_<%=info.fieldName(tmpFor)%>" class="zipLabel"><%=objXmlLang("kr_zip_messgae2")%></label>
						<input type="text" name="zip" id="krzip_address2_<%=info.fieldName(tmpFor)%>" value="" class="zipText input_text addr" />
					</div>
				</div>
				<script type="text/javascript">jQuery(function($){ $.krzip('<%=info.fieldName(tmpFor)%>') });</script>
				<p class="tip"><%=info.memo(tmpFor)%></p>
      </td>
		</tr>
<%
			CASE "corpnum"
%>
		<tr>
			<th<% IF info.rquired(tmpFor) = True THEN %> class="require"<% END IF %>><%=info.title(tmpFor)%></th>
			<td class="default">
				<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text corpnum1 integer ime_mode" id="<%=info.fieldName(tmpFor)%>1" maxlength="3" />&nbsp;-&nbsp;
				<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text corpnum2 integer ime_mode" id="<%=info.fieldName(tmpFor)%>2" maxlength="3" />&nbsp;-&nbsp;
				<input name="<%=info.fieldName(tmpFor)%>" type="text" class="input_text corpnum3 integer ime_mode" id="<%=info.fieldName(tmpFor)%>3" maxlength="5" />
				<p class="tip"><%=info.memo(tmpFor)%></p>
      </td>
		</tr>
<%
			END SELECT
		END IF
	NEXT
%>
		</table>
		</div>
		<div class="btn_area">
			<span class="button large strong"><input type="submit" id="btn_ok" value="<%=objXmlLang("cmd_confirm")%>" /></span>
			<span class="button large strong"><a href="/"><%=objXmlLang("cmd_join_cancel")%></a></span>
		</div>
		</form>
	</div>
<!-- #include file = "common.footer.asp" -->