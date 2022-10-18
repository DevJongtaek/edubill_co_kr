<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C01"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM intPage, intPageSize, sortid, sortdsc
	DIM search_option, detail_search, searchMode, searchText, startTermDate, endTermDate, termType, etcAuth, etcSex
	DIM startPoint, endPoint, birthType, memberType, gradeList, levelList
	
	WITH REQUEST

		intPage       = GetInputReplce(.FORM("intPage"), "")
		intPageSize   = GetInputReplce(.FORM("intPageSize"), "")
		sortid        = .FORM("sortid")
		sortdsc       = .FORM("sortdsc")
		search_option = .FORM("search_option")
		detail_search = .FORM("detail_search")
		searchMode    = .FORM("searchMode")
		searchText    = GetInputReplce(.FORM("searchText"), "")
		startTermDate = .FORM("startTermDate")
		endTermDate   = .FORM("endTermDate")
		termType      = .FORM("termType")
		etcAuth       = .FORM("etcAuth")
		etcSex        = .FORM("etcSex")
		startPoint    = .FORM("startPoint")
		endPoint      = .FORM("endPoint")
		birthType     = .FORM("birthType")
		memberType    = .FORM("memberType")
		gradeList     = .FORM("gradeList")
		levelList     = .FORM("levelList")

		IF startTermDate = "" THEN startTermDate = REPLACE(LEFT(NOW(),10), "-", ".")
		IF endTermDate   = "" THEN endTermDate   = REPLACE(LEFT(NOW(),10), "-", ".")
		IF termType      = "" THEN termType      = "join"
		IF detail_search = "" THEN detail_search = "0"

	END WITH

	IF GetNumericCheck(intPage, "i") = False THEN intPage = ""
	IF intPage = "" THEN intPage = 1

	IF GetNumericCheck(intPageSize, "i") = False THEN intPageSize = ""
	IF intPageSize = "" THEN intPageSize = 10

	IF sortid = "" THEN sortid = "thReg"
	IF sortdsc = "" THEN sortdsc = "dsc"
%>
<script type="text/javascript" src="../js/Calendar.js"></script>
<script type="text/javascript" src="../js/jquery.cookie.js"></script>
<script type="text/javascript">

	var nowSortID = "<%=sortid%>";
	var nowSortDsc = "<%=sortdsc%>";
	var nowPage = "<%=intPage%>";
	var clickAreaCheck = false;
	var searchOption = "<%=search_option%>";

</script>
<script type="text/javascript" src="member/js/member.list.js"></script>
		<div id="content">
			<form id="theForm" method="post">
			<input type="hidden" name="strLeaveMemo" id="strLeaveMemo">
			<input type="hidden" name="intPage" id="intPage" value="<%=intPage%>">
			<input type="hidden" name="sortid" id="sortid" value="<%=sortid%>">
			<input type="hidden" name="sortdsc" id="sortdsc" value="<%=sortdsc%>">
			<input type="hidden" name="search_option" id="search_option" value="<%=search_option%>">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_list")%></h3>
				<div class="right_area">
					<ul>
						<li>
							<select name="searchMode" class="wd100" id="searchMode">
							<%=GetMakeSelectForm(objXmlLang("option_search_item1"), ",", searchMode, "")%>
							</select>
						</li>
						<li><input name="searchText" type="text" id="searchText" value="<%=searchText%>" size="25" maxlength="20" /></li>
						<li><span class="button medium"><input type="button" id="btn_search" value="<%=objXmlLang("btn_search")%>" /></span></li>
						<li><span class="button medium "><button id="btn_search_detail" type="button"><%=objXmlLang("btn_detail_search")%></button></span></li>
					</ul>
				</div>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description_1")%>
			</p>
			<div id="detailSearchDiv" class="deatil_search_area">
				<dl id="detailSearcForm" class="radio_form">
					<%=GetMakeRadioForm(objXmlLang("option_search_item2"), ",", detail_search, "detail_search", "<dd><b>", "</b></dd>")%>
				</dl>
				<div id="termSearch" class="detail_box" style="display:block;">
					<span class="fl mr5">
					<input name="startTermDate" type="text" id="startTermDate" style="color:#666; background:#fff;" value="<%=startTermDate%>" size="10" readonly="readonly" /><input type="button" id="btnStartCal" class="btn_calendar" onClick="calendar(event, 'startTermDate');" /> ~
						<input name="endTermDate" type="text" id="endTermDate" style="color:#666; background:#fff;" value="<%=endTermDate%>" size="10" readonly="readonly" /><input type="button" id="btnEndCal" class="btn_calendar" onClick="calendar(event, 'endTermDate');" />
					</span>
					<span class="fl mr5">
						<select name="termType" id="termType">
						<%=GetMakeSelectForm(objXmlLang("option_search_item3"), ",", termType, "")%>
						</select>
					</span>
					<span class="fl">
						<span class="button medium"><a id="btn_term_search"><%=objXmlLang("btn_search")%></a></span>
					</span>
				</div>
				<div id="etcSearch" class="detail_box">
					<span class="fl mr5">
						<select name="etcAuth" id="etcAuth">
						<%=GetMakeSelectForm(objXmlLang("option_auth"), ",", etcAuth, "")%>
						</select>
					</span>
					<span class="fl mr5">
						<select name="etcSex" id="etcSex">
						<%=GetMakeSelectForm(objXmlLang("option_search_item4"), ",", etcSex, "")%>
						</select>
					</span>
					<span class="fl">
						<span class="button medium"><a id="btn_etc_search"><%=objXmlLang("btn_search")%></a></span>
					</span>
				</div>
				<div id="pointSearch" class="detail_box">
					<span class="fl mr5">
					<input name="startPoint" type="text" class="ime_mode integer" id="startPoint" value="<%=startPoint%>" size="10" />
					~
					<input name="endPoint" type="text" class="ime_mode integer" id="endPoint" value="<%=endPoint%>" size="10" />
					</span>
					<span class="fl">
						<span class="button medium"><a id="btn_point_search"><%=objXmlLang("btn_search")%></a></span>
					</span>
				</div>
				<div id="birthSearch" class="detail_box">
					<span class="fl mr5">
						<select name="birthType" id="birthType">
						<%=GetMakeSelectForm(objXmlLang("option_search_item5"), ",", birthType, "")%>
						</select>
					</span>
					<span class="fl">
						<span class="button medium"><a id="btn_birth_search"><%=objXmlLang("btn_search")%></a></span>
					</span>
				</div>
			</div>
			<div id="memberPointDiv" class="deatil_search_area">
				<span class="fl mr5" style="padding-top:3px;">
				<%=objXmlLang("text_select")%>
				</span>
				<span class="fl mr5">
				<select name="addminus" id="addminus">
				<option value="+">+</option>
				<option value="-">-</option>
				</select>
				</span>
				<span class="fl mr5">
				<input type="text" id="addpoint" name="addpoint" size="15" class="ime_mode integer">
				</span>
				<span class="fl mr5">
				<%=objXmlLang("text_point")%>&nbsp;<input type="text" id="pointMemo" name="pointMemo" size="50">
				</span>
				<span class="fl">
				<span class="button medium"><input type="button" id="btn_point_add" value="<%=objXmlLang("btn_point_add")%>"></span>
				</span>&nbsp;
			</div>
			<div id="subBody">

				<div class="list_info">
					<div class="left">
						<p><%=objXmlLang("text_total")%> <span id="totalCnt"></span> <%=objXmlLang("text_member_count")%></p>
					</div>
					<div class="right">
						<ul>
							<li>
								<select name="viewMemberType" id="viewMemberType" onChange="Member.MakeBody(nowPage);">
								<%=GetMakeSelectForm(objXmlLang("option_member_type"), ",", memberType, "")%>
								</select>
							</li>
							<li>
								<select name="viewLevelList" id="viewLevelList" onChange="Member.MakeBody(nowPage);">
								<%=GetMakeSelectForm(objXmlLang("option_total_level"), ",", levelList, "")%>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_LEVEL_LIST] ")

	WHILE NOT(RS.EOF)
%>
								<option value="<%=RS("intLevel")%>"><%=RS("strLevelTitle")%></option>
<%
	RS.MOVENEXT
	WEND
%>
								</select>
							</li>
							<li>
								<select name="viewGradeList" id="viewGradeList" onChange="Member.MakeBody(nowPage);">
								<%=GetMakeSelectForm(objXmlLang("option_total_group"), ",", gradeList, "")%>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_LIST] ")

	WHILE NOT(RS.EOF)
%>
								<option value="<%=RS("strGroupCode")%>"><%=RS("strTitle")%></option>
<%
	RS.MOVENEXT
	WEND
%>
								</select>
							</li>
							<li>
								<select name="intPageSize" id="intPageSize" onChange="Member.MakeBody(nowPage);">
								<%=GetMakeSelectForm(objXmlLang("option_page_list"), ",", intPageSize, "int")%>
								</select>
							</li>
						</ul>
					</div>
				</div>
			<table class="tableType3">
				<thead id="memberListHead">
				<tr>
					<th class="lineL chk"></th>
					<th class="bar"><%=objXmlLang("list_num")%></th>
					<th class="bar"><%=objXmlLang("list_group")%></th>
					<th class="bar"><%=objXmlLang("list_level")%></th>
					<th class="bar"><%=objXmlLang("list_id")%></th>
					<th class="bar"><%=objXmlLang("list_name")%></th>
					<th class="bar"><%=objXmlLang("list_nick")%></th>
					<th id="thReg" class="bar"><div><%=objXmlLang("list_regdate")%></div></th>
					<th id="thLast" class="bar"><div><%=objXmlLang("list_lastdate")%></div></th>
					<th id="thVisit" class="bar"><div><%=objXmlLang("list_visit")%></div></th>
					<th id="thArticle" class="bar"><div><%=objXmlLang("list_article")%></div></th>
					<th id="thComment" class="bar"><div><%=objXmlLang("list_comment")%></div></th>
					<th class="bar"><%=objXmlLang("list_sex")%></th>
					<th class="bar"><%=objXmlLang("list_birthday")%></th>
					<th class="bar"><%=objXmlLang("list_area")%></th>
					<th class="bar"><%=objXmlLang("list_mailing")%></th>
					<th class="bar"><%=objXmlLang("list_auth")%></th>
					<th class="bar"><%=objXmlLang("list_point")%></th>
					<th class="bar"><%=objXmlLang("list_stop")%></th>
					<th class="bar"><%=objXmlLang("list_no_login")%></th>
					<th class="bar" style="padding:0;">
						<a id="btn_column_set" class="open_column" style="border-right:1px solid #c7c7c7;"></a>
					</th>
				</tr>
				</thead>
				<tbody id="memberListBody"></tbody>
			</table>
			<div id="noDataDiv" class="lineB" style="display:none;"><%=objXmlLang("text_nodata")%></div>
			<div id="columnSetLayer" style="display:none; z-index:9999;">
				<ul>
					<li><input type="checkbox" value="7" checked /><%=objXmlLang("list_regdate")%></li>
					<li><input type="checkbox" value="8" checked /><%=objXmlLang("list_lastdate")%></li>
					<li><input type="checkbox" value="9" checked /><%=objXmlLang("list_visit")%></li>
					<li><input type="checkbox" value="10" checked /><%=objXmlLang("list_article")%></li>
					<li><input type="checkbox" value="11" /><%=objXmlLang("list_comment")%></li>
					<li><input type="checkbox" value="12" /><%=objXmlLang("list_sex")%></li>
					<li><input type="checkbox" value="13" /><%=objXmlLang("list_birthday")%></li>
					<li><input type="checkbox" value="14" /><%=objXmlLang("list_area")%></li>
					<li><input type="checkbox" value="15" /><%=objXmlLang("list_mailing")%></li>
					<li><input type="checkbox" value="16" /><%=objXmlLang("list_auth")%></li>
					<li><input type="checkbox" value="17" /><%=objXmlLang("list_point")%></li>
					<li><input type="checkbox" value="18" /><%=objXmlLang("list_stop")%></li>
					<li><input type="checkbox" value="19" /><%=objXmlLang("list_no_login")%></li>
				</ul>
				<p><%=objXmlLang("text_max")%>    <b class="point">4</b> <%=objXmlLang("text_select_message")%></p>
			</div>
			<div class="list_control">
				<ul>
					<li class="chk"><input type="checkbox" id="checkall" cid="n" /></li>
					<li class="lbl"><%=objXmlLang("text_select")%></li>
					<li>
						<select name="gradeList" id="gradeList">
						<%=GetMakeSelectForm(objXmlLang("option_group_select"), ",", "", "")%>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_LIST] ")

	WHILE NOT(RS.EOF)
%>
						<option value="<%=RS("strGroupCode")%>"><%=RS("strTitle")%></option>
<%
	RS.MOVENEXT
	WEND
%>
						</select>
					</li>
					<li>
						<select name="levelList" id="levelList">
						<%=GetMakeSelectForm(objXmlLang("option_level_select"), ",", "", "")%>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_LEVEL_LIST] ")

	WHILE NOT(RS.EOF)
%>
					<option value="<%=RS("intLevel")%>"><%=RS("strLevelTitle")%></option>
<%
	RS.MOVENEXT
	WEND
%>
						</select>
					</li>
					<li><span class="button small"><a id="btn_change"><%=objXmlLang("btn_change")%></a></span></li>
					<li><span class="bar"></span></li>
					<li>
						<span class="button small"><a id="btn_member_remove"><%=objXmlLang("btn_remove")%></a></span>
						<span class="button small"><a id="btn_withdraw"><%=objXmlLang("btn_withdraw")%></a></span>
						<span class="button small"><a id="btn_point_toggle"><%=objXmlLang("btn_point_add")%></a></span>
					</li>
					<li><span class="bar"></span></li>
					<li>
						<select name="excelKind" id="excelKind">
						<%=GetMakeSelectForm(objXmlLang("option_excel"), ",", "all", "")%>
						</select>
					</li>
					<li>
						<select name="excelCount" id="excelCount">
						<option value="1"></option>
						</select>
					</li>
					<li><span class="button small"><a id="btn_excel_down"><%=objXmlLang("btn_excel_down")%></a></span></li>
				</ul>
			</div>
			<div id="pagingArea"></div>
		</div>
		</form>
	</div>
	<div id="loadingBox" style="display:none;">
		<div id="loadingIcon"></div>
	</div>
	<div id="loadingLayer" style="display:none;"></div>
<!-- #include file = "../comm/sub.foot.asp" -->