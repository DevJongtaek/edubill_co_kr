<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 4
	menuID      = "D03"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.board.search.xml"
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

	DIM strDateType, strStartDate, strEndDate, intBoardSrl, strSearchField, strSearchKeyword, strSearchDate1, strSearchDate2

	WITH REQUEST

		strDateType      = GetInputReplce(.FORM("strDateType"), "")
		strStartDate     = GetInputReplce(.FORM("strStartDate"), "")
		strEndDate       = GetInputReplce(.FORM("strEndDate"), "")
		intBoardSrl      = GetInputReplce(.FORM("intBoardSrl"), "")
		strSearchField   = GetInputReplce(.FORM("strSearchField"), "")
		strSearchKeyword = GetInputReplce(.FORM("strSearchKeyword"), "")

	END WITH

	IF strDateType = "" THEN strDateType = "1"

	IF strStartDate = "" THEN strStartDate = REPLACE(LEFT(DATEADD("m", -1, NOW()), 10), "-", ".")
	IF strEndDate   = "" THEN strEndDate   = REPLACE(LEFT(NOW(), 10), "-", ".")

	IF strDateType = "2" THEN
		strSearchDate1 = REPLACE(strStartDate, ".", "-")
		strSearchDate2 = REPLACE(strEndDate, ".", "-")
	END IF

	IF strSearchField = "intRead" OR strSearchField = "intVote" OR strSearchField = "intBlamed" OR strSearchField = "intComment" THEN
		IF GetNumericCheck(strSearchKeyword, "i") = False THEN strSearchKeyword = ""
	END IF

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_LIST_ADMIN] 'C', '', '', '" & strSearchDate1 & "', '" & strSearchDate2 & "', '" & strSearchField & "', '" & strSearchKeyword & "' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
<script type="text/javascript" src="../js/Calendar.js"></script>
<script type="text/javascript" src="board/js/board.search.list.js"></script>
		<div id="content">
			<form id="theForm" method="post" action="?act=boardsearch">
			<input type="hidden" id="intPage" value="<%=intPage%>">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_board")%></h3>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description_board")%></p>
			<div class="deatil_search_area">
				<div class="detail_box2">
					<ul>
						<%=GetMakeRadioForm(objXmlLang("option_date"), ",", strDateType, "strDateType", "<li class=""mr10"">", "</li>")%>
						<li id="term_search">
						<input name="strStartDate" type="text" id="strStartDate" style="color:#666; background:#fff;" value="<%=strStartDate%>" size="10" readonly="readonly" /><input type="button" id="btnStartCal" class="btn_calendar" onClick="calendar(event, 'strStartDate')" /> ~
						<input name="strEndDate" type="text" id="strEndDate" style="color:#666; background:#fff;" value="<%=strEndDate%>" size="10" readonly="readonly" /><input type="button" id="btnEndCal" class="btn_calendar" onClick="calendar(event, 'strEndDate')" />
						</li>
					</ul>
				</div>
				<div class="detail_box2">
					<ul>
						<li>
							<select name="intBoardSrl" id="intBoardSrl">
							<%=GetMakeSelectForm(objXmlLang("option_board"), ",", intBoardSrl, "")%>
<%
	SET RS = DBCON.EXECUTE("ARTY30_SP_BOARD_CONFIG_LIST 'L', '', '', '' ")

	WHILE NOT(RS.EOF)
		RESPONSE.WRITE "<option value=""" & RS("intSrl") & """"
		IF intBoardSrl <> "" THEN
			IF INT(intBoardSrl) = RS("intSrl") THEN RESPONSE.WRITE " selected"
		END IF
		RESPONSE.WRITE ">" & RS("strTitle") & "</option>" & CHR(10)
	RS.MOVENEXT
	WEND
%>
							</select>
						</li>
						<li>
						<select name="strSearchField" id="strSearchField">
						<%=GetMakeSelectForm(objXmlLang("option_search_field_board"), ",", strSearchField, "")%>
						</select>
						</li>
						<li>
						<input name="strSearchKeyword" type="text" id="strSearchKeyword" value="<%=strSearchKeyword%>" size="30">
						</li>
						<li>
							<span class="button medium"><input type="button" id="btn_search" value="<%=objXmlLang("btn_search")%>"></span>
						</li>
					</ul>
				</div>
			</div>
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
					<col width="1" /><col width="22" /><col width="45" /><col /><col width="100" /><col width="60" /><col width="60" /><col width="80" /><col width="80" />
				</colgroup>
					<thead>
						<tr>
							<th class="lineL"></th>
							<th></th>
							<th><%=objXmlLang("list_num")%></th>
							<th class="bar"><%=objXmlLang("list_title")%></th>
							<th class="bar"><%=objXmlLang("list_nick")%></th>
							<th class="bar"><%=objXmlLang("list_read")%></th>
							<th class="bar"><%=objXmlLang("list_vote")%></th>
							<th class="bar"><%=objXmlLang("list_regdate")%></th>
							<th class="lineR bar"><%=objXmlLang("list_ip")%></th>
						</tr>
					</thead>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_LIST_ADMIN] 'L', '" & intPage & "', '" & intPageSize & "', '" & strSearchDate1 & "', '" & strSearchDate2 & "', '" & strSearchField & "', '" & strSearchKeyword & "' ")

	DIM iCount, intNumber
	
	WHILE NOT(RS.EOF)
		iCount = iCount + 1
		intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
						<tr>
							<td class="detail"></td>
							<td class="chk"><input type="checkbox" id="intSeq" value="<%=RS("intSeq")%>"></td>
							<td class="detail num"><%=intNumber%></td>
							<td class="detail lfpd"><a href="../?act=bbs&subAct=view&bid=<%=RS("strBoardID")%>&seq=<%=RS("intSeq")%>" target="_blank"><%=GetCutDispData(GetStripTags(RS("strTitle")), 32, "..")%><% IF RS("intComment") > 0 THEN %>&nbsp;<span class="num">(<%=RS("intComment")%>)</span><% END IF %></a></td>
							<td class="detail"><%=RS("strNickName")%></td>
							<td class="detail num"><%=RS("intRead")%></td>
							<td class="detail num"><%=RS("intVote")%> / <%=RS("intBlamed")%></td>
							<td class="detail num"><%=REPLACE(LEFT(RS("strRegDate"),10),"-",".")%></td>
							<td class="detail num"><%=RS("strIpAddr")%></td>
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
						<li><span class="button small btn"><a id="btn_manage"><%=objXmlLang("btn_article_manager")%></a></span></li>
					</ul>
				</div>
				<div id="pagingArea">
				<%=GetPageHTML(intPage, intPageCount, objXmlLang("btn_prev_page"), objXmlLang("btn_next_page"), "goPage") %>
				</div>
			</div>
			</form>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->