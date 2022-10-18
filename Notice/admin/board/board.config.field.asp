<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 4
	menuID      = "D02"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.board.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM intSrl
	intSrl = GetInputReplce(REQUEST.QueryString("intSrl"), "")

	DIM intTotalCount

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_FIELD_LIST] '" & intSrl & "', '0', '0', '1' ")

	intTotalCount = RS(0)
%>
<script type="text/javascript" src="board/js/board.config.field.js"></script>
		<div id="content">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_config_field")%></h3>
				<div class="right_area">
					<span class="button medium icon"><span class="add"></span><button id="btn_field_add" type="button"><%=objXmlLang("btn_field_add")%></button></span>
				</div>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description_config_field")%></p>
			<div id="subBody">
<!-- #include file = "board.config.comm.asp" -->
			<form id="theForm" method="post">
				<table class="tableType3">
				<colgroup>
					<col width="1" /><col width="22" /><col width="45" /><col width="120" /><col /><col width="140" /><col width="70" /><col width="70" /><col width="70" /><col width="60" /><col width="60" /><col width="50" />
				</colgroup>
					<thead>
						<tr>
							<th class="lineL"></th>
							<th></th>
							<th><%=objXmlLang("list_num")%></th>
							<th class="bar"><%=objXmlLang("list_filed")%></th>
							<th class="bar"><%=objXmlLang("list_field_name")%></th>
							<th class="bar"><%=objXmlLang("list_type")%></th>
							<th class="bar"><%=objXmlLang("list_use")%></th>
							<th class="bar"><%=objXmlLang("list_rquired")%></th>
							<th class="bar"><%=objXmlLang("list_read_disp")%></th>
							<th class="bar"><%=objXmlLang("list_search")%></th>
							<th class="bar"></th>
							<th class="lineR bar"><%=objXmlLang("list_modify")%></th>
						</tr>
					</thead>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_FIELD_LIST] '" & intSrl & "' ")

	DIM intNumber
	
	WHILE NOT(RS.EOF)
		intNumber = intNumber + 1
%>
						<tr>
							<td class="detail"></td>
							<td class="chk"><input name="strFieldRecord" type="checkbox" id="strFieldRecord" value="<%=RS("strFieldRecord")%>"></td>
							<td class="detail num"><%=intNumber%></td>
							<td class="detail"><%=RS("strFieldRecord")%></td>
							<td class="detail"><%=RS("strFieldName")%></td>
							<td class="detail"><%=GetOptionArrText(objXmlLang("option_field_type"), RS("strFieldType"))%></td>
							<td class="detail"><%=GetOptionArrText(objXmlLang("option_use"), GetBitTypeNumberChg(RS("bitUse")))%></td>
							<td class="detail"><% IF RS("bitRquired") = True THEN %>Y<% ELSE %>N<% END IF %></td>
							<td class="detail"><% IF RS("bitReadDisplay") = True THEN %>Y<% ELSE %>N<% END IF %></td>
							<td class="detail"><% IF RS("bitSearch") = True THEN %>Y<% ELSE %>N<% END IF %></td>
							<td class="detail">
							<a name="btn_move_up" id="<%=RS("strFieldRecord")%>"><img id="menuMoveUp" src="images/blank.gif" width="20" height="20"<% IF intNumber > 1 THEN %> class="btnMenuUp_01 hand"<% END IF %> /></a>
							<a name="btn_move_down" id="<%=RS("strFieldRecord")%>"><img id="menuMoveDown" src="images/blank.gif" width="20" height="20"<% IF intTotalCount <> intNumber THEN %> class="btnMenuDown_01 hand"<% END IF %> /></a>
							</td>
							<td class="detail"><span class="button small"><a name="btn_modify" id="<%=RS("strFieldRecord")%>"><%=objXmlLang("btn_modify")%></a></span></td>
						</tr>
<%
	RS.MOVENEXT
	WEND
%>
				</table>
				<div id="noDataDiv" class="lineB" style="display:<% IF intNumber = 0 THEN %>block<% ELSE %>none<% END IF %>;"><%=objXmlLang("text_nodata")%></div>
				<div class="list_control">
					<ul>
						<li class="chk"><input type="checkbox" id="checkall" cid="n" /></li>
						<li class="lbl"><%=objXmlLang("text_select")%></li>
						<li><span class="button small btn"><a id="btn_remove"><%=objXmlLang("btn_remove")%></a></span></li>
					</ul>
				</div>
			</form>
			</div>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->