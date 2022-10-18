<!-- #include file = "../../../Include/Board.Write.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/write.js"></script>
	<form name="theForm" id="theForm" class="writeForm">
		<div class="write_header">
			<h3><% IF subAct = "write" THEN %><%=objXmlLang("document_write")%><% ELSE %><%=objXmlLang("document_modify")%><% END IF %></h3>
		<table>
<% IF WRITE_intMemberSrl = "0" THEN %>
			<tr>
				<th scope="row"><%=objXmlLang("writer")%></th>
				<td><input name="nickname" type="text" id="nickname" class="nick_name" /></td>
			</tr>
			<tr>
				<th scope="row"><%=objXmlLang("password")%></th>
				<td><input name="password" type="password" id="password" class="password" /></td>
			</tr>
			<tr>
				<th scope="row"><%=objXmlLang("email")%></th>
				<td><input name="email" type="text" id="email" class="email"></td>
			</tr>
			<tr>
				<th><%=objXmlLang("homepage")%></th>
				<td><input name="homepage" type="text" id="homepage" class="homepage"></td>
			</tr>
<% END IF %>
<% IF CONF_bitUseCategory = True THEN %>
			<tr>
				<th scope="row"><%=objXmlLang("category")%></th>
				<td>
					<select id="category_form" name="category_form" class="category">
						<option value=""><%=objXmlLang("category")%> <%=objXmlLang("select")%></option>
					</select>
				</td>
			</tr>
<% END IF %>
			<tr>
				<th scope="row"><%=objXmlLang("title")%></th>
				<td>
					<div class="title_editor">
						<div class="title_input">
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
				</td>
			</tr>
		</table>
		<!-- #include file = "../../../daum/editor_inc.asp" -->
		</div>
		<div class="write_body">
		<table>
			<tr>
				<th><%=objXmlLang("tag")%></th>
				<td><input name="tag" type="text" id="tag" class="tag"></td>
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
				<input type="text" id="<%=extraForm.field(tmpFor)%>" name="<%=extraForm.field(tmpFor)%>" class="default" style="width:90%;" />
<% CASE "checkbox" %>
				<ul class="form">
					<%=GetMakeCheckForm(extraForm.formData(tmpFor) & "$$$" & extraForm.formData(tmpFor), ",", "", extraForm.field(tmpFor), "<li>", "</li>")%>
				</ul>
<% CASE "tel" %>
				<input name="<%=extraForm.field(tmpFor)%>" type="text" class="default" id="<%=extraForm.field(tmpFor)%>1" value="" size="6" maxlength="4" />&nbsp;-&nbsp;
				<input name="<%=extraForm.field(tmpFor)%>" type="text" class="default" id="<%=extraForm.field(tmpFor)%>2" value="" size="6" maxlength="4" />&nbsp;-&nbsp;
				<input name="<%=extraForm.field(tmpFor)%>" type="text" class="default" id="<%=extraForm.field(tmpFor)%>3" value="" size="6" maxlength="4" />
<% CASE "textarea" %>
				<textarea name="<%=extraForm.field(tmpFor)%>" rows="5" id="<%=extraForm.field(tmpFor)%>"></textarea>
<% CASE "select" %>
				<select name="<%=extraForm.field(tmpFor)%>" id="<%=extraForm.field(tmpFor)%>" class="inputSelect">
				<%=GetMakeSelectForm(extraForm.formData(tmpFor) & "$$$" & extraForm.formData(tmpFor), ",", "", "")%>
				</select>
<% CASE "radio" %>
				<ul class="form">
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
				<input name="<%=extraForm.field(tmpFor)%>" type="text" id="<%=extraForm.field(tmpFor)%>" class="calendar" value="" size="10" readonly="readonly" /><input type="button" class="btn_calendar" onClick="calendar(event, '<%=extraForm.field(tmpFor)%>');" />
<% CASE "datetime" %>
				<select name="<%=extraForm.field(tmpFor)%>1" id="<%=extraForm.field(tmpFor)%>1">
				<%=GetMakeDateSelectForm("year", YEAR(NOW), YEAR(NOW) - 5, YEAR(NOW) + 5, 1, objXmlLang("year"))%>
				</select>
				<select name="<%=extraForm.field(tmpFor)%>2" id="<%=extraForm.field(tmpFor)%>2">
				<%=GetMakeDateSelectForm("month", MONTH(NOW), 1, 12, 1, objXmlLang("month"))%>
				</select>
				<select name="<%=extraForm.field(tmpFor)%>3" id="<%=extraForm.field(tmpFor)%>3">
				<%=GetMakeDateSelectForm("day", DAY(NOW), 1, 31, 1, objXmlLang("day"))%>
				</select>
				<select name="<%=extraForm.field(tmpFor)%>4" id="<%=extraForm.field(tmpFor)%>4">
				<%=GetMakeDateSelectForm("hour", HOUR(NOW), 0, 23, 1, objXmlLang("hour"))%>
				</select>
				<select name="<%=extraForm.field(tmpFor)%>5" id="<%=extraForm.field(tmpFor)%>5">
				<%=GetMakeDateSelectForm("minute", MINUTE(NOW), 0, 59, 1, objXmlLang("minute"))%>
				</select>
<% END SELECT %>
				</td>
			</tr>
<% END IF %>
<% NEXT %>
			<tr id="write_captcha">
				<th><%=objXmlLang("captcha")%></th>
				<td>
					<ul class="form">
						<li><img id="imgCaptcha" src="action/?Act=captcha" /></li>
						<li><input name="captcha" type="text" id="captcha" class="default captcha"></li>
						<li><span class="button small"><input id="btnCaptcha" type="button" value="<%=objXmlLang("captcha_change")%>" /></span></li>
						<li><%=objXmlLang("captcha_input")%></li>
					</ul>
				</td>
			</tr>
		</table>
		</div>
		<div class="buttonArea">
			<span class="button large strong"><input type="submit" value="<%=objXmlLang("cmd_regist")%>" /></span>&nbsp;
			<span class="button large"><input type="button" id="btn_cancel" value="<%=objXmlLang("cmd_cancel")%>" /></span>
		</div>
	</form>
<!-- #include file = "common.footer.asp" -->