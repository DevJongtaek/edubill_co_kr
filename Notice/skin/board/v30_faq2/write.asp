<!-- #include file = "../../../Include/Board.Write.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="js/Calendar.js"></script>
<script type="text/javascript" src="<%=CONF_skinPath%>js/write.js"></script>
	<div id="boardModule">
	<form name="theForm" id="theForm" class="writeForm">
		<h4><% IF subAct = "write" THEN %><%=objXmlLang("document_write")%><% ELSE %><%=objXmlLang("document_modify")%><% END IF %></h4>
		<table class="input_table">
			<tr class="user_info">
				<th scope="row"><%=objXmlLang("writer")%></th>
				<td><input name="nickname" type="text" id="nickname" class="input_text nick_name" /></td>
			</tr>
			<tr class="user_info">
				<th scope="row"><%=objXmlLang("password")%></th>
				<td><input name="password" type="password" id="password" class="input_text password" /></td>
			</tr>
			<tr class="user_info">
				<th scope="row"><%=objXmlLang("email")%></th>
				<td><input name="email" type="text" id="email" class="input_text email"></td>
			</tr>
			<tr class="user_info">
				<th><%=objXmlLang("homepage")%></th>
				<td><input name="homepage" type="text" id="homepage" class="input_text homepage"></td>
			</tr>
			<tr id="write_category">
				<th scope="row"><%=objXmlLang("category")%></th>
				<td>
					<select id="category_form" name="category_form" class="category">
						<option value=""><%=objXmlLang("category")%> <%=objXmlLang("select")%></option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row"><%=objXmlLang("title")%></th>
				<td>
					<table class="title_table">
						<tr>
							<td><input type="text" id="title" class="title" /></td>
							<td class="btn_area">
<ul class="title_editor_menu">
							<li>
								<div class="title_style">
									<a href="javascript:;" class="font_size" id="btn_fontsize"><span>9pt</span></a>
								</div>
								<div id="tx_titleFontSize_menu">
									<ul>
										<li><a href="javascript:;" id="8pt" class="tx-8pt">가나다라마바사 (8pt)</a></li>
										<li><a href="javascript:;" id="9pt" class="tx-9pt">가나다라마바사 (9pt)</a></li>
										<li><a href="javascript:;" id="10pt" class="tx-10pt">가나다라마바사 (10pt)</a></li>
										<li><a href="javascript:;" id="12pt" class="tx-12pt">가나다라마바사 (12pt)</a></li>
										<li><a href="javascript:;" id="18pt" class="tx-18pt">가나다라마바사 (18pt)</a></li>
									</ul>
								</div>
							</li>
							<li>
								<div class="title_style">
									<a href="javascript:;" class="font_bold" id="btn_fontbold">bold</a>
								</div>
							</li>
							<li>
								<div class="title_style" id="title_font_color">
									<a href="javascript:;" class="font_color" id="btn_fontcolor">color</a>
								</div>
								<div id="tx_titleFontColor_menu"></div>
							</li>
							<li>
								<div class="title_style">
									<a href="javascript:;" class="font_reset" id="btn_fontreset">Reset</a>
								</div>
							</li>
						</ul>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<div><!-- #include file = "../../../daum/editor_inc.asp" --></div>
		<div style="border-top:1px solid #EDEDED;">
		<table class="input_table">
			<tr>
				<th><%=objXmlLang("tag")%></th>
				<td><input name="tag" type="text" id="tag" class="input_text tag"></td>
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
				<input type="text" id="<%=extraForm.field(tmpFor)%>" name="<%=extraForm.field(tmpFor)%>" class="input_text" style="width:90%;" />
<% CASE "checkbox" %>
				<ul class="checkbox">
					<%=GetMakeCheckForm(extraForm.formData(tmpFor) & "$$$" & extraForm.formData(tmpFor), ",", "", extraForm.field(tmpFor), "<li>", "</li>")%>
				</ul>
<% CASE "tel" %>
				<input name="<%=extraForm.field(tmpFor)%>" type="text" class="input_text" id="<%=extraForm.field(tmpFor)%>1" value="" size="6" maxlength="4" />&nbsp;-&nbsp;
				<input name="<%=extraForm.field(tmpFor)%>" type="text" class="input_text" id="<%=extraForm.field(tmpFor)%>2" value="" size="6" maxlength="4" />&nbsp;-&nbsp;
				<input name="<%=extraForm.field(tmpFor)%>" type="text" class="input_text" id="<%=extraForm.field(tmpFor)%>3" value="" size="6" maxlength="4" />
<% CASE "textarea" %>
				<textarea name="<%=extraForm.field(tmpFor)%>" rows="5" id="<%=extraForm.field(tmpFor)%>"></textarea>
<% CASE "select" %>
				<select name="<%=extraForm.field(tmpFor)%>" id="<%=extraForm.field(tmpFor)%>" class="inputSelect">
				<%=GetMakeSelectForm(extraForm.formData(tmpFor) & "$$$" & extraForm.formData(tmpFor), ",", "", "")%>
				</select>
<% CASE "radio" %>
				<ul class="radio">
				<%=GetMakeRadioForm(extraForm.formData(tmpFor) & "$$$" & extraForm.formData(tmpFor), ",", "", extraForm.field(tmpFor), "<li>", "</li>")%>
				</ul>
<% CASE "addr" %>
				<div class="krZip">
					<div class="item" id="zone_address_search_<%=extraForm.field(tmpFor)%>">
						<label for="krzip_address1_<%=extraForm.field(tmpFor)%>" class="zipLabel"><%=objXmlLang("kr_zip_messgae1")%></label>
						<input type="text" id="krzip_address1_<%=extraForm.field(tmpFor)%>" class="zipText input_text post" />
						<span class="button medium"><input type="button" value="<%=objXmlLang("cmd_search")%>" /></span>
					</div>
					<div class="item" id="zone_address_list_<%=extraForm.field(tmpFor)%>" style="display:none">
						<select name="zip" id="address_list_<%=extraForm.field(tmpFor)%>"></select>
						<span class="button medium"><input type="button" value="<%=objXmlLang("cmd_research")%>" /></span>
					</div>
					<div class="item address2">
						<label for="krzip_address2_<%=extraForm.field(tmpFor)%>" class="zipLabel"><%=objXmlLang("kr_zip_messgae2")%></label>
						<input type="text" name="zip" id="krzip_address2_<%=extraForm.field(tmpFor)%>" value="" class="zipText input_text addr" />
					</div>
				</div>
				<script type="text/javascript">jQuery(function($){ $.krzip('<%=extraForm.field(tmpFor)%>') });</script>
<% CASE "date" %>
				<input name="<%=extraForm.field(tmpFor)%>" type="text" id="<%=extraForm.field(tmpFor)%>" class="input_text" value="" size="10" readonly="readonly" /><input type="button" class="btn_calendar" onClick="calendar(event, '<%=extraForm.field(tmpFor)%>');" />
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
					<ul>
						<li><img id="imgCaptcha" src="action/?Act=captcha" /></li>
						<li><input name="captcha" type="text" id="captcha" class="default captcha"></li>
						<li><span class="button small"><input id="btnCaptcha" type="button" value="<%=objXmlLang("captcha_change")%>" /></span></li>
						<li class="text"><%=objXmlLang("captcha_input")%></li>
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
	</div>
<!-- #include file = "common.footer.asp" -->