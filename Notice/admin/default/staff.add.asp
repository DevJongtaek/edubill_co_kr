<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 1
	menuID      = "A02"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.default.staff.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<script type="text/javascript" src="default/js/staff.add.js"></script>
<%
	DIM Act, intMemberSrl
	Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), "S"))
	IF Act = "" THEN Act = "staffadd"

	intMemberSrl = GetInputReplce(REQUEST.QueryString("intMemberSrl"), "S")

	DIM intPage, intPageSize

	intPage = GetInputReplce(REQUEST.QueryString("intPage"), "")
	IF GetNumericCheck(intPage, "i") = False THEN intPage = ""

	intPageSize = REQUEST.FORM("intPageSize")
	IF GetNumericCheck(intPageSize, "i") = False THEN intPageSize = ""

	DIM strStaffMenuUser

	IF Act = "staffmodify" THEN

		SET RS = DBCON.EXECUTE("[ARTY30_SP_STAFF_MENU_LIST] '" & intMemberSrl & "' ")

		WHILE NOT(RS.EOF)

			IF strStaffMenuUser <> "" THEN strStaffMenuUser = strStaffMenuUser & ","
			strStaffMenuUser = strStaffMenuUser & RS("strMenuID")

		RS.MOVENEXT
		WEND

	END IF

	xmlDOM.Load langXmlPath & "lang\" & CONF_strLangType & "\lang.comm.menu.xml"
	Set objRoot = xmlDOM.documentElement

	SET rootNode = xmlDOM.selectNodes(LCASE("/root"))

	DIM strFirstMenuID, strFirstMenuName, strSecondMenuID, strSecondMenuName

		FOR firstLoop = 0 To objRoot.childNodes.Length-1
			FOR secondLoop = 0 to objRoot.childNodes(firstLoop).childNodes.Length - 1
				SELECT CASE LCASE(rootNode(0).childNodes(firstLoop).nodename)
				CASE "topmenu"
					IF strFirstMenuID <> "" THEN
						strFirstMenuID = strFirstMenuID & "$$$"
						strFirstMenuName = strFirstMenuName & "$$$"
					END IF
					strFirstMenuID = strFirstMenuID & rootNode(0).childNodes(firstLoop).childNodes(secondLoop).getAttribute("id")
					strFirstMenuName = strFirstMenuName & rootNode(0).childNodes(firstLoop).childNodes(secondLoop).text
				CASE "leftmenu"
					IF strSecondMenuID <> "" THEN
						strSecondMenuID = strSecondMenuID & "$$$"
						strSecondMenuName = strSecondMenuName & "$$$"
					END IF
					strSecondMenuID = strSecondMenuID & rootNode(0).childNodes(firstLoop).childNodes(secondLoop).getAttribute("id")
					strSecondMenuName = strSecondMenuName & rootNode(0).childNodes(firstLoop).childNodes(secondLoop).text
				END SELECT
			NEXT
		NEXT

	strFirstMenuID    = SPLIT(strFirstMenuID, "$$$")
	strFirstMenuName  = SPLIT(strFirstMenuName, "$$$")
	strSecondMenuID   = SPLIT(strSecondMenuID, "$$$")
	strSecondMenuName = SPLIT(strSecondMenuName, "$$$")
%>
		<form id="extForm" method="post" class="none">
		<input type="hidden" id="intPage" value="<%=intPage%>">
		<input type="hidden" name="intPageSize" value="<%=intPageSize%>">
		</form>
		<div id="content">
			<form id="theForm" action="action/?subAct=staffadd">
			<input type="hidden" id="Act" name="Act" value="<%=Act%>">
			<div id="subHead">
				<h3><%=objXmlLang("page_title")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description")%>
			</p>
			<div id="subBody">
				<h4><%=objXmlLang("page_sub_title_1")%></h4>
				<table class="tabletype01">
<% IF Act = "staffadd" THEN %>
					<tr>
						<th scope="row"><%=objXmlLang("title_member_search")%></th>
						<td>
							<span class="mr5">
								<select name="searchTarget" id="searchTarget">
								<%=GetMakeSelectForm(objXmlLang("option_member_search"), ",", "", "")%>
								</select>
							</span>
							<span class="fl ml5"><input name="searchText" type="text" id="searchText" size="30"></span>
							<span>
							<span class="button medium"><input type="button" id="btn_search" value="<%=objXmlLang("btn_search")%>" /></span>
							</span>
							<div id="search_list" class="both pt5">
							</div>
						<p class="tip"><%=objXmlLang("about_member_search")%></p>
						</td>
					</tr>
<%
	ELSE
		SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_READ] '" & intMemberSrl & "' ")
%>
					<tr>
						<th scope="row"><%=objXmlLang("title_staff_info")%></th>
						<td><%=RS("strLoginID")%> (<%=RS("strUserName")%>)<input type="hidden" id="memberSrl" name="memberSrl" value="<%=intMemberSrl%>"></td>
					</tr>
<% END IF %>
<%
	FOR tmpFor = 0 TO UBOUND(strFirstMenuID)
%>
					<tr>
						<th scope="row"><a href="#" name="select_sub_all" id="<%=strFirstMenuID(tmpFor)%>" onClick="return false;"><%=strFirstMenuName(tmpFor)%></a></th>
						<td>
							<ul>
<%
	FOR tmpFor2 = 0 TO UBOUND(strSecondMenuID)
		IF strFirstMenuID(tmpFor) = LEFT(strSecondMenuID(tmpFor2), "1") THEN
%>
								<li class="fl ml10" style="width:120px;"><input type="checkbox" id="<%=strSecondMenuID(tmpFor2)%>" name="menuID" value="<%=strSecondMenuID(tmpFor2)%>"<% IF INSTR(strStaffMenuUser,strSecondMenuID(tmpFor2)) > 0 THEN %> checked<% END IF %>><label for="<%=strSecondMenuID(tmpFor2)%>" class="hand"><%=strSecondMenuName(tmpFor2)%></label></li>
<%
		END IF
	NEXT
%>
							</ul>
						</td>
					</tr>
<%
	NEXT
%>
				</table>
				<div class="formButtonBox">
					<span class="button large fl"><input type="button" id="btn_select_all" value="<%=objXmlLang("btn_select_all")%>"></span>
					<span class="button large strong"><input type="submit" value="<%=objXmlLang("btn_save")%>"></span>
				</div>
			</div>
			</form>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->