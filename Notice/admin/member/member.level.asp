<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C07"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.level.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<script type="text/javascript" src="member/js/member.level.js"></script>
<%
	DIM strLevelIconFolder

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_CONFIG_READ] ")

	strLevelIconFolder = RS("strLevelIconFolder")
%>
		<div id="content">
			<div id="subHead">
				<h3><%=objXmlLang("page_title")%></h3>
				<div class="right_area">
					<ul>
						<li>
							<select name="intAddLevel" id="intAddLevel">
							<%=GetMakeSelectForm(objXmlLang("option_level"), ",", "", "")%>
<%
	FOR tmpFor = 1 TO 100
%>
							<option value="<%=tmpFor%>"><%=tmpFor%> <%=objXmlLang("text_level")%></option>
<%
	NEXT
%>
							</select>
						</li>
						<li><span class="button medium icon"><span class="add"></span><button id="btn_level_add" type="button"><%=objXmlLang("btn_level_add")%></button></span></li>
					</ul>
				</div>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description")%></p>
			<div id="subBody">
			<form id="theForm" method="post" action="?act=memberdeniedid">
				<table class="tableType3">
				<colgroup>
					<col width="1" /><col width="22" /><col width="60" /><col width="100" /><col /><col width="100" /><col width="100" />
				</colgroup>
					<thead>
						<tr>
							<th class="lineL"></th>
							<th></th>
							<th><%=objXmlLang("list_level")%></th>
							<th class="bar"><%=objXmlLang("list_icon")%> </th>
							<th class="bar"><%=objXmlLang("list_subject")%> </th>
							<th class="bar"><%=objXmlLang("list_point")%> </th>
							<th class="bar lineR"><%=objXmlLang("list_members")%>  </th>
						</tr>
					</thead>
<%
	DIM iCount
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_LEVEL_LIST] ")

	WHILE NOT(RS.EOF)
		iCount = iCount + 1
%>
						<tr>
							<td class="detail"></td>
							<td class="chk"><input name="intSeq" type="checkbox" id="intSeq" value="<%=RS("intSeq")%>"></td>
							<td class="detail"><%=RS("intLevel")%></td>
							<td class="detail"><img src="../<%=CONF_strFilePath%>/member/level/<%=strLevelIconFolder%>/<%=RS("intLevel")%>.gif"></td>
							<td class="lfpd"><input type="text" name="strLevelTitle" id="strLevelTitle" value="<%=RS("strLevelTitle")%>" style="width:380px;"></td>
							<td class="lfpd"><input type="text" name="intPoint" id="intPoint" value="<%=RS("intPoint")%>" style="width:70px;" class="ime_mode integer"></td>
							<td class="detail num"><%=RS("intMember")%></td>
						</tr>
<%
	RS.MOVENEXT
	WEND
%>
				</table>
				<div class="list_control">
					<ul>
						<li class="chk"><input type="checkbox" id="checkall" cid="n" /></li>
						<li class="lbl"><%=objXmlLang("text_select")%></li>
						<li><span class="button small btn"><a id="btn_remove"><%=objXmlLang("btn_remove")%></a></span></li>
						<li><span class="button small btn"><a id="btn_modify"><%=objXmlLang("btn_modify")%></a></span></li>
						<li><span class="bar"></span></li>
						<li class="lbl"><%=objXmlLang("text_cal")%></li>
						<li><input name="applyPoint" type="text" id="applyPoint" value="300" size="10" maxlength="10" class="ime_moce integer"></li>
						<li><span class="button small btn"><a id="btn_apply"><%=objXmlLang("btn_apply")%></a></span></li>
					</ul>
				</div>
				<div id="noDataDiv" class="lineB" style="display:<% IF iCount = 0 THEN %>block<% ELSE %>none<% END IF %>;"><%=objXmlLang("text_total")%></div>
			</form>
			</div>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->