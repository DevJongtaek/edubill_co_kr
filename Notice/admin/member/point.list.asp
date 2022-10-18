<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C08"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.point.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM intPage, intPageSize, intTotalCount, intPageCount

	intPage = 1
	intPageSize = 10

	SET RS = DBCON.EXECUTE("[ARTY30_SP_LAYOUT_LIST] ")

	intTotalCount = RS(0)
	intPageCount = INT((intTotalCount - 1) / intPageSize) + 1
%>
<script type="text/javascript" src="member/js/member.point.list.js"></script>
		<div id="content">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_list")%></h3>
				<div class="right_area">
					<ul>
						<li>
							<select name="searchMode" class="wd100" id="searchMode">
							<%=GetMakeSelectForm(objXmlLang("option_search"), ",", searchMode, "")%>
							</select>
						</li>
						<li><input name="searchText" type="text" id="searchText" size="25" maxlength="20" /></li>
						<li><span class="button medium"><input type="button" id="btn_search" value="<%=objXmlLang("btn_search")%>" /></span></li>
					</ul>
				</div>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description_list")%></p>
			<div id="subBody">
				<div style="border-bottom: 1px solid #DADADA; margin-bottom:20px;">
				<table class="admin_tab">
					<colgroup>
					<col width="5"/><col /><col width="9"/>
					<col width="5"/><col /><col width="6"/>
					<col width="5"/><col /><col width="6"/>
					<col/>
					</colgroup>
				<tbody>
				<tr>
					<td class="tabL2"/>
					<th><a href="?act=pointconfig"><%=objXmlLang("tab_menu1")%></a></th>
					<td class="tabR2"/>
					<td class="tabL1"/>
					<th class="over"><%=objXmlLang("tab_menu2")%></th>
					<td class="tabR1"/>
					<td class="tar"/>
				</tr>
				</tbody>
				</table>
				</div>
			<form id="theForm" method="post" action="?act=layout">
				<div class="list_info">
					<div class="left">
						<p><%=objXmlLang("text_total")%> <span id="totalCnt"><%=intTotalCount%></span></p>
					</div>
					<div class="right">
						<ul>
							<li>
								<select name="pointType" id="pointType" onChange="Point.MakeListBody(nowPage);">
								<%=GetMakeSelectForm(objXmlLang("option_category"), ",", "", "")%>
								</select>
							</li>
							<li>
								<select name="intYear" id="intYear" onChange="Point.MakeListBody(nowPage);">
								<%=GetMakeSelectForm(objXmlLang("option_year"), ",", "", "")%>
<%
	FOR tmpFor = YEAR(NOW) TO 2000 STEP - 1
		RESPONSE.WRITE "<option value=""" & tmpFor & """>" & tmpFor & "</option>" & CHR(10)
	NEXT
%>
								</select>
							</li>
							<li>
								<select name="intMonth" id="intMonth" onChange="Point.MakeListBody(nowPage);">
								<%=GetMakeSelectForm(objXmlLang("option_month"), ",", "", "")%>
								<%=GetMakeDateSelectForm("month", "", 1, 12, "1", "")%>
								</select>
							</li>
							<li>
								<select name="intDay" id="intDay" onChange="Point.MakeListBody(nowPage);">
								<%=GetMakeSelectForm(objXmlLang("option_day"), ",", "", "")%>
								<%=GetMakeDateSelectForm("day", "", 1, 31, "1", "")%>
								</select>
							</li>
							<li>
								<select name="intPageSize" id="intPageSize" onChange="Point.MakeListBody(nowPage);">
								<%=GetMakeSelectForm(objXmlLang("option_page_list"), ",", intPageSize, "int")%>
								</select>
							</li>
						</ul>
					</div>
				</div>
				<table class="tableType3">
				<colgroup>
					<col width="1" /><col width="22" /><col width="45" /><col width="100" /><col width="100" /><col width="100" /><col /><col width="80" /><col width="80" />
				</colgroup>
					<thead id="pointListHead">
						<tr>
							<th class="lineL"></th>
							<th></th>
							<th><%=objXmlLang("list_num")%></th>
							<th class="bar"><%=objXmlLang("list_id")%></th>
							<th class="bar"><%=objXmlLang("list_name")%></th>
							<th class="bar"><%=objXmlLang("list_nick")%></th>
							<th class="bar"><%=objXmlLang("list_memo")%></th>
							<th id="thPoint" class="bar"><div><%=objXmlLang("list_point")%></div></th>
							<th id="thReg" class="lineR bar"><div><%=objXmlLang("list_regdate")%></div></th>
						</tr>
					</thead>
					<tbody id="pointListBody"></tbody>
				</table>
				<div id="noDataDiv" class="lineB" style="display:none;"><%=objXmlLang("text_nodata")%></div>
				<div class="list_control">
					<ul>
						<li class="chk"><input type="checkbox" id="checkall" cid="n" /></li>
						<li class="lbl"><%=objXmlLang("text_select")%></li>
						<li><span class="button small btn"><a id="btn_remove"><%=objXmlLang("btn_remove")%></a></span></li>
					</ul>
				</div>
				<div id="pagingArea"></div>
			</form>
			</div>
		</div>
	<div id="loadingBox" style="display:none;">
		<div id="loadingIcon"></div>
	</div>
	<div id="loadingLayer" style="display:none;"></div>
<!-- #include file = "../comm/sub.foot.asp" -->