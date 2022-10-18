<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 4
	menuID      = "D02"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.board.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount

	intPage = GetInputReplce(REQUEST.QueryString("intPage"), "")
	IF GetNumericCheck(intPage, "i") = False THEN intPage = ""
	IF intPage = "" THEN intPage = 1

	intPageSize = REQUEST.FORM("intPageSize")
	IF GetNumericCheck(intPageSize, "i") = False THEN intPageSize = ""
	IF intPageSize = "" THEN intPageSize = 10

	DIM strCateCode
	strCateCode = GetInputReplce(REQUEST.FORM("strCateCode"), "")

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_LIST] 'C', '" & strCateCode & "' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
<script type="text/javascript" src="board/js/board.list.js"></script>
		<div id="content">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_list")%></h3>
				<div class="right_area">
					<span class="button medium icon"><span class="add"></span><button id="btn_board_add" type="button"><%=objXmlLang("btn_board_add")%></button></span>
				</div>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description_list")%></p>
			<div id="subBody">
			<form id="theForm" method="post" action="?act=boardlist">
			<input type="hidden" id="intPage" value="<%=intPage%>">
				<div class="list_info">
					<div class="left">
						<p><%=objXmlLang("text_total")%> <span id="totalNum"><%=intTotalCount%></span></p>
					</div>
					<div class="right">
						<ul>
							<li>
								<select name="strCateCode" id="strCateCode" style="width:250px;" onChange="javascript:$('#theForm').submit();">
								<%=GetMakeSelectForm(objXmlLang("option_category"), ",", strCateCode, "")%>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_SYSCODE_READ] 'C000000003' ")
	WHILE NOT(RS.EOF)
%>
								<option value="<%=RS("strSecondCode")%>"<% IF RS("strSecondCode") = strCateCode THEN %> selected<% END IF %>><%=RS("strName")%></option>
<%
	RS.MOVENEXT
	WEND
%>
								</select>
							</li>
							<li>
								<select name="intPageSize" id="intPageSize" onChange="javascript:$('#theForm').submit();">
								<%=GetMakeSelectForm(objXmlLang("option_page_list"), ",", intPageSize, "int")%>
								</select>
							</li>
						</ul>
					</div>
				</div>
				<table class="tableType3">
				<colgroup>
					<col width="1" /><col width="45" /><col width="60" /><col width="140" /><col width="120" /><col /><col width="80" /><col width="100" /><col width="50" /><col width="50" />
				</colgroup>
					<thead>
						<tr>
							<th class="lineL"></th>
							<th><%=objXmlLang("list_num")%></th>
							<th class="bar"><%=objXmlLang("list_unique")%></th>
							<th class="bar"><%=objXmlLang("list_category")%></th>
							<th class="bar"><%=objXmlLang("list_id")%></th>
							<th class="bar"><%=objXmlLang("list_name")%></th>
							<th class="bar"><%=objXmlLang("list_stat")%></th>
							<th class="bar"><%=objXmlLang("list_regdate")%></th>
							<th class="bar"><%=objXmlLang("list_config")%></th>
							<th class="lineR bar"><%=objXmlLang("list_remove")%></th>
						</tr>
					</thead>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_LIST] 'N', '" & strCateCode & "', '" & intPage & "', '" & intPageSize & "' ")

	DIM iCount, intNumber
	
	WHILE NOT(RS.EOF)
		iCount = iCount + 1
		intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
						<tr>
							<td class="detail"></td>
							<td class="detail num"><%=intNumber%></td>
							<td class="detail num"><%=RS("intSrl")%></td>
							<td class="detail num"><%=RS("strCateName")%></td>
							<td class="detail"><a href="../?bid=<%=RS("strBoardID")%>" target="_blank"><%=RS("strBoardID")%></a></td>
							<td class="detail"><%=RS("strTitle")%></td>
							<td class="detail num"><%=RS("intArticle")%> / <%=RS("intComment")%></td>
							<td class="detail num"><%=REPLACE(LEFT(RS("strRegDate"),10),"-",".")%></td>
							<td class="detail"><span class="button small"><a name="btn_config" id="<%=RS("intSrl")%>"><%=objXmlLang("btn_config")%></a></span></td>
							<td class="detail"><span class="button small"><a name="btn_remove" id="<%=RS("intSrl")%>"><%=objXmlLang("btn_remove")%></a></span></td>
						</tr>
<%
	RS.MOVENEXT
	WEND
%>
				</table>
				<div id="noDataDiv" class="lineB" style="display:<% IF intTotalCount = 0 THEN %>block<% ELSE %>none<% END IF %>;"><%=objXmlLang("text_nodata")%></div>
				<div id="pagingArea">
				<%=GetPageHTML(intPage, intPageCount, objXmlLang("btn_prev_page"), objXmlLang("btn_next_page"), "goPage") %>
				</div>
			</form>
			</div>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->