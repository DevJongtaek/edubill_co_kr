<!-- #include file = "../../../Include/Board.Write.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/write.js"></script>
	<form name="theForm" id="theForm">
	<div class="write_header">
		<table class="write_member">
			<tr>
				<th><%=objXmlLang("writer")%></th>
				<td><input type="text" id="nickname" class="inputText nickname" title="nickname" /></td>
			</tr>
			<tr>
				<th><%=objXmlLang("password")%></th>
				<td><input type="password" id="password" class="inputText password" title="password" /></td>
			</tr>
			<tr>
				<th><%=objXmlLang("email")%></th>
				<td><input type="text" id="email" class="inputText email" title="email"></td>
			</tr>
			<tr>
				<th><%=objXmlLang("homepage")%></th>
				<td><input type="text" id="homepage" class="inputText homepage" title="homepage"></td>
			</tr>
		</table>		
		<div class="title_editor">
			<div class="title_input">
			<h4><%=objXmlLang("title")%></h4>
			<input type="text" maxlength="150" class="inputText" id="title" title="title" />
			</div>
			<div class="title_button">
				<ul>
					<li>
						<a href="#btn_font_size" id="btn_font_size" class="btn_font_size" onclick="return false;"><span>9pt</span></a>
						<div class="font_size_select"></div>
					</li>
					<li><a href="#btn_font_bold" id="btn_font_bold" class="btn_font_bold" onclick="return false;">Bold</a></li>
					<li>
						<a href="#btn_font_color" id="btn_font_color" class="btn_font_color" onclick="return false;">Color</a>
						<div class="font_color_select"></div>
					</li>
					<li><a href="#btn_font_reset" id="btn_font_reset" class="btn_font_reset" onclick="return false;">Reset</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="write_body">
		<!-- #include file = "../../../daum/editor_inc.asp" -->
		<table>
			<tr id="write_category">
				<th><%=objXmlLang("category")%></th>
				<td>
					<select id="category_form" name="category_form" class="inputSelect" title="category">
						<option value=""><%=objXmlLang("category")%> <%=objXmlLang("select")%></option>
					</select>
				</td>
			</tr>
			<tr>
				<th><%=objXmlLang("write_option")%></th>
				<td>
					<ul class="write_opt">
						<li><input type="checkbox" id="notice" value="1" /><label for="notice" class="hand"><%=objXmlLang("cmd_notice")%></label></li>
						<li><input type="checkbox" id="secret" value="1" /><label for="secret" class="hand"><%=objXmlLang("cmd_secret")%></label></li>
						<li><input type="checkbox" id="message" value="1" /><label for="message" class="hand"><%=objXmlLang("cmd_message")%></label></li>
						<li><input type="checkbox" id="allow_comment" value="1" /><label for="allow_comment" class="hand"><%=objXmlLang("cmd_allow_comment")%></label></li>
						<li><input type="checkbox" id="allow_scrap" value="1" /><label for="allow_scrap" class="hand"><%=objXmlLang("cmd_allow_scrap")%></label></li>
					</ul>
				</td>
			</tr>
			<tr>
				<th><%=objXmlLang("tag")%></th>
				<td><input name="tag" type="text" id="tag" class="inputText tag" title="tag"></td>
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
				<input type="text" id="<%=extraForm.field(tmpFor)%>" class="inputText" style="width:90%;" title="<%=extraForm.title(tmpFor)%>" />
	<% CASE "checkbox" %>
				<ul class="check_form">
					<%=GetMakeCheckForm(extraForm.formData(tmpFor) & "$$$" & extraForm.formData(tmpFor), ",", "", extraForm.field(tmpFor), "<li>", "</li>")%>
				</ul>
	<% CASE "tel" %>
				<input type="text" class="inputText" id="<%=extraForm.field(tmpFor)%>1" value="" size="6" maxlength="4" title="<%=extraForm.title(tmpFor)%>" />&nbsp;-&nbsp;
				<input type="text" class="inputText" id="<%=extraForm.field(tmpFor)%>2" value="" size="6" maxlength="4" title="<%=extraForm.title(tmpFor)%>" />&nbsp;-&nbsp;
				<input type="text" class="inputText" id="<%=extraForm.field(tmpFor)%>3" value="" size="6" maxlength="4" title="<%=extraForm.title(tmpFor)%>" />
	<% CASE "textarea" %>
				<textarea rows="5" class="inputTextarea" id="<%=extraForm.field(tmpFor)%>" title="<%=extraForm.title(tmpFor)%>"></textarea>
	<% CASE "select" %>
				<select id="<%=extraForm.field(tmpFor)%>" class="inputSelect" title="<%=extraForm.title(tmpFor)%>">
				<%=GetMakeSelectForm(extraForm.formData(tmpFor) & "$$$" & extraForm.formData(tmpFor), ",", "", "")%>
				</select>
	<% CASE "radio" %>
				<ul class="radio_form">
				<%=GetMakeRadioForm(extraForm.formData(tmpFor) & "$$$" & extraForm.formData(tmpFor), ",", "", extraForm.field(tmpFor), "<li>", "</li>")%>
				</ul>
	<% CASE "addr" %>
				<div class="krZip">
					<div class="item" id="zone_address_search_<%=extraForm.field(tmpFor)%>">
						<label for="krzip_address1_<%=extraForm.field(tmpFor)%>" class="zipLabel"><%=objXmlLang("kr_zip_messgae1")%></label>
						<input type="text" id="krzip_address1_<%=extraForm.field(tmpFor)%>" class="zipText inputText post" />
						<span class="button medium"><input type="button" value="<%=objXmlLang("cmd_search")%>" /></span>
					</div>
					<div class="item" id="zone_address_list_<%=extraForm.field(tmpFor)%>" style="display:none">
						<select name="zip" id="address_list_<%=extraForm.field(tmpFor)%>" class="inputSelect"></select>
						<span class="button medium"><input type="button" value="<%=objXmlLang("cmd_research")%>" /></span>
					</div>
					<div class="item address2">
						<label for="krzip_address2_<%=extraForm.field(tmpFor)%>" class="zipLabel"><%=objXmlLang("kr_zip_messgae2")%></label>
						<input type="text" name="zip" id="krzip_address2_<%=extraForm.field(tmpFor)%>" value="" class="zipText inputText addr" />
					</div>
				</div>
				<script type="text/javascript">jQuery(function($){ $.krzip('<%=extraForm.field(tmpFor)%>') });</script>
	<% CASE "date" %>
				<input type="text" id="<%=extraForm.field(tmpFor)%>" class="inputTextCalendar" value="" size="10" readonly="readonly" title="<%=extraForm.title(tmpFor)%>" /><input type="button" class="btn_calendar" onClick="calendar(event, '<%=extraForm.field(tmpFor)%>');" />
	<% CASE "datetime" %>
				<select id="<%=extraForm.field(tmpFor)%>1" title="<%=extraForm.title(tmpFor)%>">
				<%=GetMakeDateSelectForm("year", YEAR(NOW), YEAR(NOW) - 5, YEAR(NOW) + 5, 1, objXmlLang("year"))%>
				</select>
				<select id="<%=extraForm.field(tmpFor)%>2" title="<%=extraForm.title(tmpFor)%>">
				<%=GetMakeDateSelectForm("month", MONTH(NOW), 1, 12, 1, objXmlLang("month"))%>
				</select>
				<select id="<%=extraForm.field(tmpFor)%>3" title="<%=extraForm.title(tmpFor)%>">
				<%=GetMakeDateSelectForm("day", DAY(NOW), 1, 31, 1, objXmlLang("day"))%>
				</select>
				<select id="<%=extraForm.field(tmpFor)%>4" title="<%=extraForm.title(tmpFor)%>">
				<%=GetMakeDateSelectForm("hour", HOUR(NOW), 0, 23, 1, objXmlLang("hour"))%>
				</select>
				<select id="<%=extraForm.field(tmpFor)%>5" title="<%=extraForm.title(tmpFor)%>">
				<%=GetMakeDateSelectForm("minute", MINUTE(NOW), 0, 59, 1, objXmlLang("minute"))%>
				</select>
	<% END SELECT %>
				</td>
			</tr>
	<% END IF %>
	<% NEXT %>
			<tr class="write_captcha">
				<th><%=objXmlLang("captcha")%></th>
				<td>
					<ul class="captcha_form">
						<li><img id="imgCaptcha" src="action/?Act=captcha" alt="captcha" /></li>
						<li class="mt5"><input name="captcha" type="text" id="captcha" class="inputText captcha" title="captcha input"></li>
						<li class="mt5"><span class="button small"><input id="btnCaptcha" type="button" value="<%=objXmlLang("captcha_change")%>" /></span></li>
						<li class="mt5"><%=objXmlLang("captcha_input")%></li>
					</ul>
				</td>
			</tr>
		</table>
	</div>
	<div class="write_footer">
		<span class="button large strong"><input type="submit" value="<%=objXmlLang("cmd_regist")%>" /></span>&nbsp;
		<span class="button large"><input type="button" id="btn_cancel" value="<%=objXmlLang("cmd_cancel")%>" /></span>
	</div>
	</form>
<!-- #include file = "common.footer.asp" -->