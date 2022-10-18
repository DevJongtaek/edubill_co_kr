<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C08"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.point.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM bitPointUse, strLevelUpdate, bitGroupUpdate

	SET RS = DBCON.EXECUTE("[ARTY30_SP_POINT_CONFIG] ")

	bitPointUse    = GetBitTypeNumberChg(RS("bitPointUse"))
	strLevelUpdate = RS("strLevelUpdate")
	bitGroupUpdate = GetBitTypeNumberChg(RS("bitGroupUpdate"))
%>
<script type="text/javascript" src="member/js/member.point.config.js"></script>
		<div id="content">
			<form id="theForm">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_config")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description_config")%>
			</p>
			<div id="subBody">
				<div style="border-bottom: 1px solid #DADADA; margin-bottom:20px;">
				<table class="admin_tab">
					<colgroup>
					<col width="5"/><col /><col width="9"/>
					<col width="5"/><col /><col width="6"/>
					<col width="5"/><col /><col width="6"/>
					<col/>
					</colgroup>
				<tbody>
				<tr>
					<td class="tabL1"/>
					<th class="over"><%=objXmlLang("tab_menu1")%></th>
					<td class="tabR1"/>
					<td class="tabL2"/>
					<th><a href="?act=pointlist"><%=objXmlLang("tab_menu2")%></a></th>
					<td class="tabR2"/>
					<td class="tar"/>
				</tr>
				</tbody>
				</table>
				</div>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_point")%></th>
						<td>
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitPointUse, "bitPointUse", "<dd>", "</dd>")%>
						</dl>
						<p class="tip"><%=objXmlLang("about_point")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_level_update")%></th>
						<td>
						<dl>
							<%=GetMakeRadioForm(objXmlLang("option_nouse"), ",", strLevelUpdate, "strLevelUpdate", "<li>", "</li>")%>
						</dl>
						<p class="tip"><%=objXmlLang("about_level_update")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_group_update")%></th>
						<td>
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_update"), ",", bitGroupUpdate, "bitGroupUpdate", "<dd>", "</dd>")%>
						</dl>
						<p class="tip"><%=objXmlLang("about_group_update")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_group_level")%></th>
						<td>
						<ul>
<%
	DIM Arr_intLevel, Arr_strLevelTitle, I

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_LEVEL_LIST] ")

	WHILE NOT(RS.EOF)

		IF Arr_intLevel <> "" THEN
			Arr_intLevel      = Arr_intLevel & ","
			Arr_strLevelTitle = Arr_strLevelTitle & ","
		END IF

		Arr_intLevel      = Arr_intLevel & RS("intLevel")
		Arr_strLevelTitle = Arr_strLevelTitle & RS("strLevelTitle")

	RS.MOVENEXT
	WEND

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_LIST] ")

	tmpFor = 0
	WHILE NOT(RS.EOF)
		tmpFor = tmpFor + 1
%>
							<li class="both">
								<dd class="fl mb5"><input type="text" name="strGroupCode" id="strGroupCode" value="<%=RS("strTitle")%>" readonly class="wd200"></dd>
								<dd class="fl ml5">
								<select name="intLevel" id="<%=RS("strGroupCode")%>" style="width:150px;" onChange="chgGroupLevel($(this));">
								<option value="0">none</option>
								<%=GetMakeSelectForm(Arr_intLevel & "$$$" & Arr_strLevelTitle, ",", RS("intUpLevel"), "int")%>
								</select>
								</dd>
							</li>
<%
	RS.MOVENEXT
	WEND
%>
						</ul>
						<p class="tip"><%=objXmlLang("about_group_level")%></p>
						</td>
					</tr>
				</table>
				<div class="formButtonBox">
				<span class="button large strong"><input type="submit" id="btn_save" value="<%=objXmlLang("btn_save")%>"></span>
				</div>
			</div>
			</form>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->