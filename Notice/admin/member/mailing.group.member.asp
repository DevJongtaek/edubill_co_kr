<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C10"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.mailing.xml"
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

	DIM strGroupCode, strGroupName
	strGroupCode = GetInputReplce(REQUEST.QueryString("strGroupCode"), "")

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_GROUP_READ] 'N', '" & strGroupCode & "' ")

	strGroupName = RS("strTitle")

	DIM strGradeText, strGradeValue, strLevelText, strLevelValue

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_LIST] ")

	WHILE NOT(RS.EOF)

		IF strGradeText <> "" THEN
			strGradeText = strGradeText & "$$$"
			strGradeValue = strGradeValue  & "$$$"
		END IF
		strGradeText = strGradeText & RS("strTitle")
		strGradeValue = strGradeValue & RS("strGroupCode")

	RS.MOVENEXT
	WEND

	strGradeText  = SPLIT(strGradeText, "$$$")
	strGradeValue = SPLIT(strGradeValue, "$$$")

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_LEVEL_LIST] ")

	WHILE NOT(RS.EOF)

		IF strLevelText <> "" THEN
			strLevelText = strLevelText & "$$$"
			strLevelValue = strLevelValue & "$$$"
		END IF

		strLevelText = strLevelText & RS("strLevelTitle")
		strLevelValue = strLevelValue & RS("intLevel")

	RS.MOVENEXT
	WEND

	strLevelText = SPLIT(strLevelText, "$$$")
	strLevelValue = SPLIT(strLevelValue, "$$$")
%>
<script type="text/javascript" src="member/js/mailing.group.member.js"></script>
<script type="text/javascript">

	var SET_strGroupCode = "<%=strGroupCode%>";

</script>
		<form id="extForm" method="post" class="none">
		<input type="hidden" id="intPage" value="<%=intPage%>">
		<input type="hidden" name="intPageSize" value="<%=intPageSize%>">
		</form>
		<div id="content">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_group_member")%> - <%=strGroupName%></h3>
				<div class="fr">
					<span class="button medium"><button id="btn_mailing_group_list" type="button"><%=objXmlLang("btn_mailing_group_list")%></button></span>
				</div>
			</div>
			<p class="subHeadDesc"><%=objXmlLang("page_description_group_member")%></p>
			<div id="subBody">
			<form id="theForm" method="post" action="?act=mailingsendlist">
			<input type="hidden" id="intPage" value="<%=intPage%>">
				<div class="list_info">
					<div class="left">
						<p><%=objXmlLang("page_sub_title_4")%> <span id="totalCnt1"></span></p>
					</div>
					<div class="right">
						<ul>
							<li>
								<select name="viewLevelList1" id="viewLevelList1" onChange="Member.List('1', '1');">
								<%=GetMakeSelectForm(objXmlLang("option_level"), ",", "", "")%>
<%
	FOR tmpFor = 0 TO UBOUND(strLevelText)
%>
								<option value="<%=strLevelValue(tmpFor)%>"><%=strLevelText(tmpFor)%></option>
<%
	NEXT
%>
								</select>
							</li>
							<li>
								<select name="viewGradeList1" id="viewGradeList1" onChange="Member.List('1', '1');">
								<%=GetMakeSelectForm(objXmlLang("option_group"), ",", "", "")%>
<%
	FOR tmpFor = 0 TO UBOUND(strGradeText)
%>
								<option value="<%=strGradeValue(tmpFor)%>"><%=strGradeText(tmpFor)%></option>
<%
	NEXT
%>
								</select>
							</li>
							<li>
								<select name="intPageSize1" id="intPageSize1" onChange="Member.List('1', '1');">
								<%=GetMakeSelectForm(objXmlLang("option_page_list"), ",", intPageSize, "int")%>
								</select>
							</li>
						</ul>
					</div>
				</div>
				<table class="tableType3">
				<colgroup>
					<col width="1" /><col width="22" /><col width="45" /><col width="100" /><col width="60" /><col /><col width="100" /><col width="100" /><col width="85" /><col width="85" /><col width="60" />
				</colgroup>
					<thead id="pointListHead">
						<tr>
							<th class="lineL"></th>
							<th></th>
							<th><%=objXmlLang("list_num")%></th>
							<th class="bar"><%=objXmlLang("list_group")%></th>
							<th class="bar"><%=objXmlLang("list_level")%></th>
							<th class="bar"><%=objXmlLang("list_userid")%></th>
							<th class="bar"><%=objXmlLang("list_name")%></th>
							<th class="bar"><%=objXmlLang("list_nick")%></th>
							<th class="bar"><%=objXmlLang("list_join_date")%></th>
							<th class="bar"><%=objXmlLang("list_lastdate")%></th>
							<th class="lineR bar"><%=objXmlLang("list_visit")%></th>
						</tr>
					</thead>
					<tbody id="memberList1"></tbody>
				</table>
				<div id="noDataDiv1" class="lineB" style="display:none;"><%=objXmlLang("text_nodata")%></div>
				<div class="list_control">
					<ul>
						<li class="chk"><input type="checkbox" id="checkall1" cid="n" /></li>
						<li class="lbl"><%=objXmlLang("text_select")%></li>
						<li><span class="button small btn"><a id="btn_remove"><%=objXmlLang("btn_remove")%></a></span></li>
						<li style="float:right;">
							<dl class="fl mr5">
								<select name="searchMode1" class="wd100" id="searchMode1">
								<%=GetMakeSelectForm(objXmlLang("option_search"), ",", "", "")%>
								</select>
							</dl>
							<dl class="fl">
								<input name="searchText1" type="text" id="searchText1" value="<%=searchText%>" size="25" maxlength="20" />
								<span class="button small"><input type="button" id="btn_search1" value="<%=objXmlLang("btn_search")%>"/></span>
								<span class="button small"><input type="button" id="btn_cancel1" value="<%=objXmlLang("btn_cancel")%>" /></span>
							</dl>
						</li>
					</ul>
				</div>
				<div id="pagingArea">
				</div>
			</form>
			<form id="theForm2" method="post" action="?act=mailingsendlist">
			<input type="hidden" id="intPage" value="<%=intPage%>">
				<div class="list_info">
					<div class="left">
						<p><%=objXmlLang("page_sub_title_5")%> <span id="totalCnt2"></span></p>
					</div>
					<div class="right">
						<ul>
							<li>
								<select name="viewLevelList2" id="viewLevelList2" onChange="Member.List('1', '2');">
								<%=GetMakeSelectForm(objXmlLang("option_level"), ",", "", "")%>
<%
	FOR tmpFor = 0 TO UBOUND(strLevelText)
%>
								<option value="<%=strLevelValue(tmpFor)%>"><%=strLevelText(tmpFor)%></option>
<%
	NEXT
%>
								</select>
							</li>
							<li>
								<select name="viewGradeList2" id="viewGradeList2" onChange="Member.List('1', '2');">
								<%=GetMakeSelectForm(objXmlLang("option_group"), ",", "", "")%>
<%
	FOR tmpFor = 0 TO UBOUND(strGradeText)
%>
								<option value="<%=strGradeValue(tmpFor)%>"><%=strGradeText(tmpFor)%></option>
<%
	NEXT
%>
								</select>
							</li>
							<li>
								<select name="intPageSize2" id="intPageSize2" onChange="Member.List('1', '2');">
								<%=GetMakeSelectForm(objXmlLang("option_page_list"), ",", intPageSize, "int")%>
								</select>
							</li>
						</ul>
					</div>
				</div>
				<table class="tableType3">
				<colgroup>
					<col width="1" /><col width="22" /><col width="45" /><col width="100" /><col width="60" /><col /><col width="100" /><col width="100" /><col width="85" /><col width="85" /><col width="60" />
				</colgroup>
					<thead id="pointListHead">
						<tr>
							<th class="lineL"></th>
							<th></th>
							<th><%=objXmlLang("list_num")%></th>
							<th class="bar"><%=objXmlLang("list_group")%></th>
							<th class="bar"><%=objXmlLang("list_level")%></th>
							<th class="bar"><%=objXmlLang("list_userid")%></th>
							<th class="bar"><%=objXmlLang("list_name")%></th>
							<th class="bar"><%=objXmlLang("list_nick")%></th>
							<th class="bar"><%=objXmlLang("list_join_date")%></th>
							<th class="bar"><%=objXmlLang("list_lastdate")%></th>
							<th class="lineR bar"><%=objXmlLang("list_visit")%></th>
						</tr>
					</thead>
					<tbody id="memberList2"></tbody>
				</table>
				<div id="noDataDiv2" class="lineB" style="display:none;"><%=objXmlLang("text_nodata")%></div>
				<div class="list_control">
					<ul>
						<li class="chk"><input type="checkbox" id="checkall2" cid="n" /></li>
						<li class="lbl"><%=objXmlLang("text_select")%></li>
						<li><span class="button small btn"><a id="btn_add"><%=objXmlLang("btn_add")%></a></span></li>
						<li style="float:right;">
							<dl class="fl mr5">
							<select name="searchMode2" class="wd100" id="searchMode2">
							<%=GetMakeSelectForm(objXmlLang("option_search"), ",", "", "")%>
							</select>
							</dl>
							<dl class="fl">
								<input name="searchText2" type="text" id="searchText2" size="25" maxlength="20" />
								<span class="button small"><input type="button" id="btn_search2" value="<%=objXmlLang("btn_search")%>" /></span>
								<span class="button small"><input type="button" id="btn_cancel2" value="<%=objXmlLang("btn_cancel")%>" /></span>
							</dl>
						</li>
					</ul>
				</div>
				<div id="pagingArea2"></div>
			</form>
			</div>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->