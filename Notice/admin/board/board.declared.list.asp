<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 4
	menuID      = "D06"
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

	SET RS = DBCON.EXECUTE("[ARTY30_SP_DECLARED_LIST] ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
<script type="text/javascript" src="board/js/board.declared.list.js"></script>
		<div id="content">
			<form id="theForm" method="post" action="?act=boarddeclared">
			<input type="hidden" id="intPage" value="<%=intPage%>">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_declared")%></h3>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description_declared")%></p>
			<div id="subBody">
			<div class="tab_box">
				<table class="admin_tab">
					<colgroup>
					<col width="5"/><col /><col width="6"/>
					<col width="5"/><col /><col width="6"/>
					<col/>
					</colgroup>
				<tbody>
				<tr>
					<td class="tabL<% IF LCASE(REQUEST.QueryString("Act")) = "boarddeclared" THEN %>1<% ELSE %>2<% END IF %>"/>
					<th<% IF LCASE(REQUEST.QueryString("Act")) = "boarddeclared" THEN %> class="over"<% END IF %>><% IF LCASE(REQUEST.QueryString("Act")) = "boarddeclared" THEN %><%=objXmlLang("text_board")%><% ELSE %><a href="?act=boarddeclared"><%=objXmlLang("text_board")%></a><% END IF %></th>
					<td class="tabR<% IF LCASE(REQUEST.QueryString("Act")) = "boarddeclared" THEN %>1<% ELSE %>2<% END IF %>"/>

					<td class="tabL<% IF LCASE(REQUEST.QueryString("Act")) = "commentdeclared" THEN %>1<% ELSE %>2<% END IF %>"/>
					<th<% IF LCASE(REQUEST.QueryString("Act")) = "commentdeclared" THEN %> class="over"<% END IF %>><% IF LCASE(REQUEST.QueryString("Act")) = "commentdeclared" THEN %><%=objXmlLang("text_comment")%><% ELSE %><a href="?act=commentdeclared"><%=objXmlLang("text_comment")%></a><% END IF %></th>
					<td class="tabR<% IF LCASE(REQUEST.QueryString("Act")) = "commentdeclared" THEN %>1<% ELSE %>2<% END IF %>"/>
					<td class="tar"/>
				</tr>
				</tbody>
				</table>
				</div>
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
					<col width="1" /><col width="22" /><col width="45" /><col /><col width="140" /><col width="80" /><col width="80" />
				</colgroup>
					<thead>
						<tr>
							<th class="lineL"></th>
							<th></th>
							<th><%=objXmlLang("list_num")%></th>
							<th class="bar"><%=objXmlLang("list_title")%></th>
							<th class="bar"><%=objXmlLang("list_user")%></th>
							<th class="bar"><%=objXmlLang("list_regdate")%></th>
							<th class="lineR bar"><%=objXmlLang("list_ip")%></th>
						</tr>
					</thead>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_DECLARED_LIST] 'L', 'B', '" & intPage & "', '" & intPageSize & "' ")

	DIM iCount, intNumber
	
	WHILE NOT(RS.EOF)
		iCount = iCount + 1
		intNumber = int(intTotalCount) - (INT(intPageSize) * (INT(intPage) - 1)) - iCount + 1
%>
						<tr>
							<td class="detail"></td>
							<td class="chk"><input type="checkbox" id="intSeq" name="intSeq" value="<%=RS("intBoardSeq")%>" class="d_<%=RS("intSeq")%>"></td>
							<td class="detail num"><%=intNumber%></td>
							<td class="detail lfpd"><a href="../?act=bbs&subAct=view&bid=<%=RS("strBoardID")%>&seq=<%=RS("intBoardSeq")%>" target="_blank"><%=RS("strTitle")%></a></td>
							<td class="detail"><%=SPLIT(RS("strDeclaredUser"),"|")(1)%>&nbsp;(<%=SPLIT(RS("strDeclaredUser"),"|")(0)%>)</td>
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
						<li>
							<span class="button small btn"><a id="btn_manage"><%=objXmlLang("btn_article_manager")%></a></span>
							<span class="button small btn"><a id="btn_declared_cancel"><%=objXmlLang("btn_declared_cancel")%></a></span>
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