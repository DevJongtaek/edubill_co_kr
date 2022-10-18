<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 2
	menuID      = "B02"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.layout.page.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<script type="text/javascript" src="layout/js/page.list.js"></script>
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

	SET RS = DBCON.EXECUTE("[ARTY30_SP_PAGE_LIST] '" & strCateCode & "' ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
		<div id="content">
			<div id="subHead">
				<h3><%=objXmlLang("page_title")%></h3>
				<div class="right_area">
					<span class="button medium icon"><span class="add"></span><button id="btn_page_Add" type="button"><%=objXmlLang("btn_page_add")%></button></span>
					</div>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description")%></p>
			<div id="subBody">
			<form id="theForm" method="post" action="?act=page">
			<input type="hidden" id="intPage" value="<%=intPage%>">
				<div class="list_info">
					<div class="left">
						<p><%=objXmlLang("text_total")%> <span id="totalNum"><%=intTotalCount%></span></p>
					</div>
					<div class="right">
						<ul>
							<li>
								<select name="strCateCode" id="strCateCode" style="width:250px;" onChange="javascript:$('#theForm').submit();">
								<%=GetMakeSelectForm(objXmlLang("option_page_category"), ",", strCateCode, "")%>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_SYSCODE_READ] 'C000000001' ")
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
					<col width="1" /><col width="22" /><col width="45" /><col width="140" /><col /><col width="80" /><col width="100" /><col width="50" />
				</colgroup>
					<thead>
						<tr>
							<th class="lineL"></th>
							<th></th>
							<th><%=objXmlLang("list_num")%></th>
							<th class="bar"><%=objXmlLang("list_category")%></th>
							<th class="bar"><%=objXmlLang("list_page_title")%></th>
							<th class="bar"><%=objXmlLang("list_use")%></th>
							<th class="bar"><%=objXmlLang("list_regdate")%></th>
							<th class="lineR bar"><%=objXmlLang("list_modify")%></th>
						</tr>
					</thead>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_PAGE_LIST] '" & strCateCode & "', 'N', '" & intPage & "', '" & intPageSize & "' ")

	DIM iCount, intNumber
	
	WHILE NOT(RS.EOF)
		iCount = iCount + 1
		intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
						<tr>
							<td class="detail"></td>
							<td class="chk"><input name="strPid" type="checkbox" id="strPid" value="<%=RS("strPid")%>"></td>
							<td class="detail num"><%=intNumber%></td>
							<td class="detail num"><%=RS("strCateName")%></td>
							<td class="lfpd"><a href="../?pid=<%=RS("strPid")%>" target="_blank"><%=RS("strTitle")%></a></td>
							<td class="detail"><%=GetOptionArrText(objXmlLang("option_use"), GetBitTypeNumberChg(RS("bitUse")))%></td>
							<td class="detail num"><%=REPLACE(LEFT(RS("strRegDate"),10),"-",".")%></td>
							<td class="detail"><span class="button small"><a href="#" name="btn_modify" id="<%=RS("strPid")%>"><%=objXmlLang("btn_modify")%></a></span></td>
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
					</ul>
				</div>
				<div id="pagingArea">
				<%=GetPageHTML(intPage, intPageCount, objXmlLang("btn_prev_page"), objXmlLang("btn_next_page"), "goPage") %>
				</div>
			</form>
			</div>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->