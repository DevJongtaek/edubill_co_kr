<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C09"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.out.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount

	intPage = GetInputReplce(REQUEST.QueryString("intPage"), False)
	IF isNumeric(intPage) = False THEN intPage = ""
	IF intPage = "" THEN intPage     = 1

	intPageSize = REQUEST.FORM("intPageSize")
	IF intPageSize = "" THEN intPageSize = 10

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_OUT_LIST] 'Y' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
<script type="text/javascript" src="member/js/member.out.list.js"></script>
<script type="text/javascript">

	var SET_intPage = "<%=intPage%>";

</script>
		<div id="content">
			<div id="subHead">
				<h3><%=objXmlLang("page_title")%></h3>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description")%></p>
			<div id="subBody">
			<form id="theForm" method="post" action="?act=layout">
				<div class="list_info">
					<div class="left">
						<p><%=objXmlLang("text_total")%> <span id="totalNum"><%=intTotalCount%></span></p>
					</div>
					<div class="right">
						<ul>
							<li>
								<select name="intPageSize" id="intPageSize" onChange="changeViewList();">
								<%=GetMakeSelectForm(objXmlLang("option_page_list"), ",", intPageSize, "int")%>
								</select>
							</li>
						</ul>
					</div>
				</div>
				<table class="tableType3">
				<colgroup>
					<col width="1" /><col width="22" /><col width="45" /><col width="100" /><col width="60" /><col /><col width="100" /><col width="100" /><col width="85" /><col width="85" /><col width="60" /><col width="50" />
				</colgroup>
					<thead>
						<tr>
							<th class="lineL"></th>
							<th></th>
							<th><%=objXmlLang("list_num")%></th>
							<th class="bar"><%=objXmlLang("list_group")%></th>
							<th class="bar"><%=objXmlLang("list_level")%></th>
							<th class="bar"><%=objXmlLang("list_userid")%></th>
							<th class="bar"><%=objXmlLang("list_name")%></th>
							<th class="bar"><%=objXmlLang("list_nick")%></th>
							<th class="bar"><%=objXmlLang("list_regdate")%></th>
							<th class="bar"><%=objXmlLang("list_lastdate")%></th>
							<th class="bar"><%=objXmlLang("list_visit")%></th>
							<th class="lineR bar"><%=objXmlLang("list_memo")%></th>
						</tr>
					</thead>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_OUT_LIST] 'N', '" & intPageSize & "', '" & intPage & "' ")

	DIM iCount, intNumber
	WHILE NOT(RS.EOF)
	
		iCount = iCount + 1
		intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
						<tr>
							<td></td>
							<td class="chk"><input name="intSeq" type="checkbox" id="intSeq" value="<%=RS("intSeq")%>"></td>
							<td class="detail num"><%=intNumber%></td>
							<td class="detail"><%=RS("strGroupCode")%></td>
							<td class="detail"><%=RS("intLevel")%></td>
							<td class="detail"><%=RS("strLoginID")%></td>
							<td class="detail"><%=RS("strUserName")%></td>
							<td class="detail"><%=RS("strNickName")%></td>
							<td class="detail num"><%=REPLACE(LEFT(RS("strRegDate"),10), "-", ".")%></td>
							<td class="detail num"><% IF RS("strVisitDate") <> "" AND ISNULL(RS("strVisitDate")) = False THEN %><%=REPLACE(LEFT(RS("strVisitDate"),10), "-", ".")%><% ELSE %>-<% END IF %></td>
							<td class="detail num"><%=RS("intVisit")%></td>
							<td class="detail num"><span class="button small"><a name="btn_view" id="<%=RS("intSeq")%>"><%=objXmlLang("btn_view")%></a></span></td>
						</tr>
						<tr id="memo_<%=RS("intSeq")%>" style="display:none;">
							<td colspan="12" class="memberOutMemo">
							<p><%=GetReplaceTag2Text(RS("strLeaveMemo"))%></p>
							<p><%=RS("strLeaveDate")%></p>
							</td>
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
						<li><span class="button small btn"><a id="btn_remove"><%=objXmlLang("btn_remove")%></a></span></li>
						<li><span class="button small btn"><a id="btn_out_cancel"><%=objXmlLang("btn_out_cancel")%></a></span></li>
					</ul>
				</div>
				<div id="pagingArea">
				<%=GetPageHTML(intPage, intPageCount, objXmlLang("btn_prev_page"), objXmlLang("btn_next_page"), "goPage") %>
				</div>
			</form>
			</div>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->