<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C05"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.document.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount, strCateCode

	intPage = GetInputReplce(REQUEST.QueryString("intPage"), False)
	IF isNumeric(intPage) = False THEN intPage = ""
	IF intPage = "" THEN intPage     = 1

	intPageSize = REQUEST.FORM("intPageSize")
	IF GetNumericCheck(intPageSize, "i") = False THEN intPageSize = ""
	IF intPageSize = "" THEN intPageSize = 10

	strCateCode = REQUEST.FORM("strCateCode")

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_DOCUMENT_LIST] '" & strCateCode & "', 'Y' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
<script type="text/javascript" src="member/js/member.document.list.js"></script>
		<div id="content">
			<div id="subHead">
				<h3><%=objXmlLang("page_title")%></h3>
				<div class="right_area">
					<span class="button medium icon"><span class="add"></span><button id="btn_document_add" type="button"><%=objXmlLang("btn_document_add")%></button></span>
				</div>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description")%></p>
			<div id="subBody">
			<form id="theForm" method="post" action="?act=memberdoc">
			<input type="hidden" id="intPage" value="<%=intPage%>">
				<div class="list_info">
					<div class="left">
						<p><%=objXmlLang("text_total")%> <span id="totalNum"><%=intTotalCount%></span></p>
					</div>
					<div class="right">
						<ul>
							<li>
								<select name="strCateCode" id="strCateCode" onChange="javascript:$('#theForm').submit();">
								<%=GetMakeSelectForm(objXmlLang("option_category"), ",", strCateCode, "")%>
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
					<col width="1" /><col width="22" /><col width="45" /><col width="140" /><col /><col width="80" /><col width="80" /><col width="80" /><col width="45" />
				</colgroup>
					<thead>
						<tr>
							<th class="lineL"></th>
							<th></th>
							<th><%=objXmlLang("list_num")%></th>
							<th class="bar"><%=objXmlLang("list_category")%></th>
							<th class="bar"><%=objXmlLang("list_subject")%></th>
							<th class="bar"><%=objXmlLang("list_default")%></th>
							<th class="bar"><%=objXmlLang("list_modifydate")%></th>
							<th class="bar"><%=objXmlLang("list_regdate")%></th>
							<th class="lineR bar"><%=objXmlLang("list_modify")%></th>
						</tr>
					</thead>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_DOCUMENT_LIST] '" & strCateCode & "', 'N', '" & intPage & "', '" & intPageSize & "' ")

	DIM iCount, intNumber
	WHILE NOT(RS.EOF)
	
		iCount = iCount + 1
		intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
						<tr>
							<td class="detail"></td>
							<td class="chk"><input name="strDocCode" type="checkbox" id="strDocCode" value="<%=RS("strDocCode")%>"></td>
							<td class="detail num"><%=intNumber%></td>
							<td class="lfpd"><%=GetOptionArrText(objXmlLang("option_category"), RS("strCateCode"))%></td>
							<td class="lfpd"><%=RS("strSubject")%></td>
							<td class="detail"><% IF RS("bitDefault") = True THEN %>Y<% ELSE %>N<% END IF %></td>
							<td class="detail num"><%=REPLACE(LEFT(RS("strRegDate"),10),"-",".")%></td>
							<td class="detail num"><%=REPLACE(LEFT(RS("strRegDate"),10),"-",".")%></td>
							<td class="detail"><span class="button small"><a name="btn_modify" id="<%=RS("strDocCode")%>"><%=objXmlLang("btn_modify")%></a></span></td>
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
						<li><span class="button small"><a id="btnRemoveSelect"><%=objXmlLang("btn_remove")%></a></span></li>
					</ul>
				</div>
				<div id="pagingArea">
				<%=GetPageHTML(intPage, intPageCount, objXmlLang("btn_prev_page"), objXmlLang("btn_next_page"), "goPage") %>
				</div>
			</form>
			</div>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->