<!-- #include file = "../../../Include/Board.Write.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/write.js"></script>
	<form name="theForm" id="theForm">
	<table class="write_table">
		<tr>
			<td>
				<div class="title_bg">
					<ul>
						<li class="category">
							<select id="category_form" name="category_form" class="inputSelect" title="<%=objXmlLang("category")%>" />
							<option value=""><%=objXmlLang("category")%> <%=objXmlLang("select")%></option>
							</select>
						</li>
						<li><input type="text" id="title" class="inputText title" title="<%=objXmlLang("title")%>" /></li>
					</ul>
				</div>
			</td>
		</tr>
		<tr id="write_guest">
			<td>
				<div class="title_bg">
					<ul>
						<li><input name="nickname" type="text" id="nickname" class="inputText nickname" title="<%=objXmlLang("nick_name")%>" /></li>
						<li><input name="password" type="password" id="password" class="inputText password" title="<%=objXmlLang("password")%>" /></li>
						<li><input name="email" type="text" id="email" class="inputText email" title="<%=objXmlLang("email")%>" /></li>
						<li><input name="homepage" type="text" id="homepage" class="inputText url" title="<%=objXmlLang("homepage")%>" /></li>
					</ul>
				</div>
			</td>
		</tr>
	</table>
	<!-- #include file = "../../../daum/editor_inc.asp" -->
	<div class="write_footer">
		<div class="box">
			<table>
				<tr>
					<th><%=objXmlLang("write_option")%></th>
					<td>
						<span id="opt_notice" class="mr10"><input type="checkbox" id="notice" name="notice" value="1" /><label for="notice" class="hand"><%=objXmlLang("cmd_notice")%></label></span>
						<span id="opt_secret" class="mr10"><input type="checkbox" id="secret" name="secret" value="1" /><label for="secret" class="hand"><%=objXmlLang("cmd_secret")%></label></span>
						<span id="opt_message" class="mr10"><input type="checkbox" id="message" name="message" value="1" /><label for="message" class="hand"><%=objXmlLang("cmd_message")%></label></span>
						<span class="mr10"><input type="checkbox" id="allow_comment" name="allow_comment" value="1" /><label for="allow_comment" class="hand"><%=objXmlLang("cmd_allow_comment")%></label></span>
						<span><input type="checkbox" id="allow_scrap" name="allow_scrap" value="1" /><label for="allow_scrap" class="hand"><%=objXmlLang("cmd_allow_scrap")%></label></span>
					</td>
				</tr>
				<tr>
					<th><%=objXmlLang("tag")%></th>
					<td><input name="tag" type="text" id="tag" class="inputText tag" title="<%=objXmlLang("tag")%>" /></td>
				</tr>
<% FOR tmpFor = 1 TO 15 %>
<% IF extraForm.use(tmpFor) = True THEN %>
				<tr>
					<th><%=extraForm.title(tmpFor)%></th>
					<td>
<%
	SELECT CASE extraForm.formType(tmpFor)
	CASE "text","url", "email"
%>
						<input type="text" id="<%=extraForm.field(tmpFor)%>" name="<%=extraForm.field(tmpFor)%>" class="inputText <%=extraForm.formType(tmpFor)%>" title="<%=extraForm.title(tmpFor)%>" />
<% CASE "checkbox" %>
						<ul>
							<%=GetMakeCheckForm(extraForm.formData(tmpFor) & "$$$" & extraForm.formData(tmpFor), ",", "", extraForm.field(tmpFor), "<li>", "</li>")%>
						</ul>
<% CASE "tel" %>
						<input name="<%=extraForm.field(tmpFor)%>" type="text" class="inputText" id="<%=extraForm.field(tmpFor)%>1" value="" size="6" maxlength="4" title="<%=extraForm.title(tmpFor)%>" />&nbsp;-&nbsp;
						<input name="<%=extraForm.field(tmpFor)%>" type="text" class="inputText" id="<%=extraForm.field(tmpFor)%>2" value="" size="6" maxlength="4" title="<%=extraForm.title(tmpFor)%>" />&nbsp;-&nbsp;
						<input name="<%=extraForm.field(tmpFor)%>" type="text" class="inputText" id="<%=extraForm.field(tmpFor)%>3" value="" size="6" maxlength="4" title="<%=extraForm.title(tmpFor)%>" />
<% CASE "textarea" %>
						<textarea name="<%=extraForm.field(tmpFor)%>" rows="5" class="inputTextarea <%=extraForm.formType(tmpFor)%>" id="<%=extraForm.field(tmpFor)%>" title="<%=extraForm.title(tmpFor)%>" /></textarea>
<% CASE "select" %>
						<select name="<%=extraForm.field(tmpFor)%>" id="<%=extraForm.field(tmpFor)%>" title="<%=extraForm.title(tmpFor)%>" class="inputSelect" />
						<%=GetMakeSelectForm(extraForm.formData(tmpFor) & "$$$" & extraForm.formData(tmpFor), ",", "", "")%>
						</select>
<% CASE "radio" %>
						<ul>
						<%=GetMakeRadioForm(extraForm.formData(tmpFor) & "$$$" & extraForm.formData(tmpFor), ",", "", extraForm.field(tmpFor), "<li>", "</li>")%>
						</ul>
<% CASE "addr" %>
				<div class="krZip">
					<div class="item" id="zone_address_search_<%=extraForm.field(tmpFor)%>">
						<label for="krzip_address1_<%=extraForm.field(tmpFor)%>" class="zipLabel"><%=objXmlLang("kr_zip_messgae1")%></label>
						<input type="text" id="krzip_address1_<%=extraForm.field(tmpFor)%>" class="zipText inputText post" />
						<span class="button btn01"><input type="button" value="<%=objXmlLang("cmd_search")%>" /></span>
					</div>
					<div class="item" id="zone_address_list_<%=extraForm.field(tmpFor)%>" style="display:none">
						<select name="zip" id="address_list_<%=extraForm.field(tmpFor)%>" class="inputSelect"></select>
						<span class="button btn01"><input type="button" value="<%=objXmlLang("cmd_research")%>" /></span>
					</div>
					<div class="item address2">
						<label for="krzip_address2_<%=extraForm.field(tmpFor)%>" class="zipLabel"><%=objXmlLang("kr_zip_messgae2")%></label>
						<input type="text" name="zip" id="krzip_address2_<%=extraForm.field(tmpFor)%>" value="" class="zipText inputText addr" />
					</div>
					<script type="text/javascript">jQuery(function($){ $.krzip('<%=extraForm.field(tmpFor)%>') });</script>
				</div>
<% CASE "date" %>
						<input name="<%=extraForm.field(tmpFor)%>" type="text" id="<%=extraForm.field(tmpFor)%>" class="inputCalendar" size="10" readonly="readonly" title="<%=extraForm.title(tmpFor)%>" /><input type="button" class="btn_calendar" onClick="calendar(event, '<%=extraForm.field(tmpFor)%>');" />
<% CASE "datetime" %>
						<ul>
							<li>
								<select name="<%=extraForm.field(tmpFor)%>1" id="<%=extraForm.field(tmpFor)%>1" title="<%=extraForm.title(tmpFor)%>" class="inputSelect" />
								<%=GetMakeDateSelectForm("year", YEAR(NOW), YEAR(NOW) - 5, YEAR(NOW) + 5, 1, objXmlLang("year"))%>
								</select>
							</li>
							<li>
								<select name="<%=extraForm.field(tmpFor)%>2" id="<%=extraForm.field(tmpFor)%>2" title="<%=extraForm.title(tmpFor)%>" class="inputSelect" />
								<%=GetMakeDateSelectForm("month", MONTH(NOW), 1, 12, 1, objXmlLang("month"))%>
								</select>
							</li>
							<li>
								<select name="<%=extraForm.field(tmpFor)%>3" id="<%=extraForm.field(tmpFor)%>3" title="<%=extraForm.title(tmpFor)%>" class="inputSelect" />
								<%=GetMakeDateSelectForm("day", DAY(NOW), 1, 31, 1, objXmlLang("day"))%>
								</select>
							</li>
							<li>
								<select name="<%=extraForm.field(tmpFor)%>4" id="<%=extraForm.field(tmpFor)%>4" title="<%=extraForm.title(tmpFor)%>" class="inputSelect" />
								<%=GetMakeDateSelectForm("hour", HOUR(NOW), 0, 23, 1, objXmlLang("hour"))%>
								</select>
							</li>
							<li>
								<select name="<%=extraForm.field(tmpFor)%>5" id="<%=extraForm.field(tmpFor)%>5" title="<%=extraForm.title(tmpFor)%>" class="inputSelect" />
								<%=GetMakeDateSelectForm("minute", MINUTE(NOW), 0, 59, 1, objXmlLang("minute"))%>
								</select>
							</li>
						</ul>
<%
	END SELECT
%>
					</td>
				</tr>
<% END IF %>
<% NEXT %>
				<tr id="write_captcha">
					<th><%=objXmlLang("captcha")%></th>
					<td>
						<ul>
							<li><img id="imgCaptcha" src="action/?Act=captcha" alt="captcha" /></li>
							<li class="mt5"><input name="captcha" type="text" id="captcha" class="inputText captcha" title="<%=objXmlLang("captcha")%>" /></li>
							<li class="mt5"><span class="button btn01"><input id="btnCaptcha" type="button" value="<%=objXmlLang("captcha_change")%>" /></span></li>
							<li class="mt10"><%=objXmlLang("captcha_input")%></li>
						</ul>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="write_btn_area">
		<span class="button btn04 strong"><input type="submit" value="<%=objXmlLang("cmd_regist")%>" /></span>
		<span class="button btn03"><input type="button" id="btn_cancel" value="<%=objXmlLang("cmd_cancel")%>" /></span>
	</div>
	</form>
<!-- #include file = "common.footer.asp" -->