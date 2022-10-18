<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 4
	menuID      = "D07"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.board.comm.xml"
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

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_TRASH_LIST] 'Y' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
<script type="text/javascript" src="board/js/board.trash.list.js"></script>
		<div id="content">
			<form id="theForm" method="post" action="?act=boardtrash">
			<input type="hidden" id="intPage" value="<%=intPage%>">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_trash")%></h3>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description_trash")%></p>
			<div id="subBody">
				<div class="list_info">
					<div class="left">
						<p><%=objXmlLang("text_total")%> <span id="totalNum"><%=intTotalCount%></span></p>
					</div>
					<div class="right">
						<ul>
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
					<col width="1" /><col width="22" /><col width="45" /><col width="120" /><col /><col width="100" /><col width="80" /><col width="80" />
				</colgroup>
					<thead>
						<tr>
							<th class="lineL"></th>
							<th></th>
							<th><%=objXmlLang("list_num")%></th>
							<th class="bar"><%=objXmlLang("list_board")%></th>
							<th class="bar"><%=objXmlLang("list_title")%></th>
							<th class="bar"><%=objXmlLang("list_nick")%></th>
							<th class="bar"><%=objXmlLang("list_regdate")%></th>
							<th class="lineR bar"><%=objXmlLang("list_trash_date")%></th>
						</tr>
					</thead>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_TRASH_LIST] 'N', '" & intPage & "', '" & intPageSize & "' ")

	DIM iCount, intNumber
	
	WHILE NOT(RS.EOF)
		iCount = iCount + 1
		intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
						<tr>
							<td class="detail"></td>
							<td class="chk"><input type="checkbox" id="intSeq" name="intSeq" value="<%=RS("intSrl")%>,<%=RS("intSeq")%>"></td>
							<td class="detail num"><%=intNumber%></td>
							<td class="detail"><a href="../?bid=<%=RS("strBoardID")%>" target="_blank"><%=RS("strBoardTitle")%></a></td>
							<td class="detail lfpd"><a href="#" onClick="dispContent('bd_<%=RS("intSeq")%>');return false;"><%=GetCutDispData(GetStripTags(RS("strTitle")), 36, "..")%></a><% IF RS("intComment") > 0 THEN %>&nbsp;<span class="num">[<%=RS("intComment")%>]</span><% END IF %></td>
							<td class="detail"><%=RS("strNickName")%></td>
							<td class="detail num"><%=REPLACE(LEFT(RS("strRegDate"),10),"-",".")%></td>
							<td class="detail num"><%=REPLACE(LEFT(RS("strTrashDate"),10),"-",".")%></td>
						</tr>
						<tr id="bd_<%=RS("intSeq")%>" style="display:none;">
							<td colspan="9" class="lfpd" style="width:100%;"><%=GetCutDispData(GetStripTags(RS("strContent")), 400, "..")%></td>
						</tr>
<%
	RS.MOVENEXT
	WEND
%>
				</table>
				<div id="noDataDiv" class="lineB" style="display:<% IF intTotalCount = 0 THEN %>block<% ELSE %>none<% END IF %>;"><%=objXmlLang("text_nodata")%></div>
				<div class="list_control">
					<ul>
						<li class="chk"><input type="checkbox" id="checkall" cid="n" /></li>
						<li class="lbl"><%=objXmlLang("text_select")%></li>
						<li>
							<span class="button small btn"><a id="btn_remove"><%=objXmlLang("btn_remove")%></a></span>
							<span class="button small btn"><a id="btn_restore"><%=objXmlLang("btn_restore")%></a></span>
						</li>
					</ul>
				</div>
				<div id="pagingArea">
				<%=GetPageHTML(intPage, intPageCount, objXmlLang("btn_prev_page"), objXmlLang("btn_next_page"), "goPage") %>
				</div>
			</div>
			</form>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->