<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C03"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.group.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<script type="text/javascript" src="member/js/member.group.list.js"></script>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_LIST] 'Y' ")

	DIM intTotalCount
	intTotalCount = RS(0)
%>
		<div id="content">
			<div id="subHead">
				<h3><%=objXmlLang("page_title")%></h3>
				<div class="right_area">
					<span class="button medium icon"><span class="add"></span><button id="btn_group_add" type="button"><%=objXmlLang("btn_group_add")%></button></span>
				</div>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description")%></p>
			<div id="subBody">
				<h4><%=objXmlLang("sub_title")%></h4>

				<div class="list_info">
					<div class="left">
						<p><%=objXmlLang("text_total")%> <span id="totalNum"><%=intTotalCount%></span></p>
					</div>
				</div>
				<form id="theForm" method="post" action="?act=membergroup">
				<table class="tableType3">
				<colgroup>
					<col width="1" /><col width="22" /><col width="200" /><col /><col width="70" /><col width="60" /><col width="80" /><col width="50" /><col width="50" />
				</colgroup>
						<tr>
							<th class="lineL"></th>
							<th></th>
							<th><%=objXmlLang("list_subject")%></th>
							<th class="bar"><%=objXmlLang("list_memo")%></th>
							<th class="bar"><%=objXmlLang("list_group")%></th>
							<th class="bar"><%=objXmlLang("list_member")%></th>
							<th class="bar"><%=objXmlLang("list_regdate")%></th>
							<th id="thReg" class="bar"><%=objXmlLang("list_modify")%></th>
							<th id="thCnt" class="lineR bar"><%=objXmlLang("list_remove")%></th>
						</tr>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_LIST] ")

	WHILE NOT(RS.EOF)
%>
						<tr>
							<td class="detail"></td>
							<td class="chk"><input name="strGroupCode" type="checkbox" id="strGroupCode" value="<%=RS("strGroupCode")%>"></td>
							<td class="lfpd"><%=RS("strTitle")%></td>
							<td class="lfpd"><%=RS("strDescription")%></td>
							<td class="detail"><% IF RS("bitDefault") = True THEN %>Y<% END IF %></td>
							<td class="detail"><%=RS("intMemberCount")%></td>
							<td class="detail num"><%=REPLACE(LEFT(RS("strRegDate"),10),"-",".")%></td>
							<td class="detail"><span class="button small"><a name="btn_modify" id="<%=RS("strGroupCode")%>"><%=objXmlLang("btn_modify")%></a></span></td>
							<td class="detail">
							<% IF RS("strGroupCode") = "G000000000" OR RS("strGroupCode") = "G000000001" THEN %><% ELSE %><span class="button small"><a name="btn_delete" id="<%=RS("strGroupCode")%>" member="<%=RS("intMemberCount")%>"><%=objXmlLang("btn_remove")%></a></span><% END IF %>
							</td>
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
						<li>
							<select name="strMoveGroup" id="strMoveGroup">
							<%=GetMakeSelectForm(objXmlLang("option_move_group"), ",", "", "")%>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_LIST] ")

	WHILE NOT(RS.EOF)
%>
							<option value="<%=RS("strGroupCode")%>"<% IF RS("strGroupCode") = strJoinGroup THEN %> selected<% END IF %>><%=RS("strTitle")%></option>
<%
	RS.MOVENEXT
	WEND
%>
							</select>
						</li>
						<li><span class="button small btn"><a id="btn_select_move"><%=objXmlLang("btn_move")%></a></span></li>
					</ul>
				</div>
				</form>
			</div>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->