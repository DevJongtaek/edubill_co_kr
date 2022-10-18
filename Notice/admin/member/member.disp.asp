<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C01"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_CONFIG_READ] ")

	DIM strPhotoSize, strNameImgSize, strMarkImgSize

	strPhotoSize   = SPLIT(RS("strPhotoSize"), ",")
	strNameImgSize = SPLIT(RS("strNameImgSize"), ",")
	strMarkImgSize = SPLIT(RS("strMarkImgSize"), ",")

	DIM memberSeq, memberFilePath
	
	memberSeq      = GetInputReplce(REQUEST.QueryString("intSeq"), "")
	memberFilePath = GetNowFolderPath("../") & "\" & CONF_strFilePath & "\member\"
%>
<script type="text/javascript" src="../js/swfobject.js"></script>
<script type="text/javascript" src="member/js/member.disp.js"></script>
		<div id="content">
			<form id="theForm">
			<input type="hidden" id="intSeq" name="intSeq" value="<%=memberSeq%>">
			<input type="hidden" name="intPage" value="<%=REQUEST.FORM("intPage")%>">
			<input type="hidden" name="intPageSize" value="<%=REQUEST.FORM("intPageSize")%>">
			<input type="hidden" name="sortid" value="<%=REQUEST.FORM("sortid")%>">
			<input type="hidden" name="sortdsc" value="<%=REQUEST.FORM("sortdsc")%>">
			<input type="hidden" name="search_option" value="<%=REQUEST.FORM("search_option")%>">
			<input type="hidden" name="detail_search" value="<%=REQUEST.FORM("detail_search")%>">
			<input type="hidden" name="searchMode" value="<%=REQUEST.FORM("searchMode")%>">
			<input type="hidden" name="searchText" value="<%=REQUEST.FORM("searchText")%>">
			<input type="hidden" name="startTermDate" value="<%=REQUEST.FORM("startTermDate")%>">
			<input type="hidden" name="endTermDate" value="<%=REQUEST.FORM("endTermDate")%>">
			<input type="hidden" name="termType" value="<%=REQUEST.FORM("termType")%>">
			<input type="hidden" name="etcAuth" value="<%=REQUEST.FORM("etcAuth")%>">
			<input type="hidden" name="etcSex" value="<%=REQUEST.FORM("etcSex")%>">
			<input type="hidden" name="startPoint" value="<%=REQUEST.FORM("startPoint")%>">
			<input type="hidden" name="endPoint" value="<%=REQUEST.FORM("endPoint")%>">
			<input type="hidden" name="birthType" value="<%=REQUEST.FORM("birthType")%>">
			<input type="hidden" name="gradeList" value="<%=REQUEST.FORM("gradeList")%>">
			<input type="hidden" name="levelList" value="<%=REQUEST.FORM("levelList")%>">
			</form>
			<div id="subHead">
				<h3><%=objXmlLang("page_title_info")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description_2")%>
			</p>
			<div id="subBody">
<!-- #include file = "../../include/Member.Read.asp" -->
<!-- #include file = "../../include/Member.Form.asp" -->
			<h4><%=objXmlLang("page_sub_title_1")%></h4>
			<table class="tabletype01">
<%
	DIM tmpArrData, strInputValue
	FOR tmpFor = 0 TO UBOUND(info.fieldName)
		IF info.fieldName(tmpFor) <> "" AND info.fieldName(tmpFor) <> "strPassword" AND info.fieldName(tmpFor) <> "strSSN" THEN
			SELECT CASE info.formType(tmpFor)
			CASE "userid", "nick", "text", "tel", "mobile", "url", "textarea", "sign", "checkbox"
				strInputValue = objMemberInfo(info.fieldName(tmpFor))
			CASE "email"
				strInputValue = objMemberInfo(info.fieldName(tmpFor) & "1") & "@" & objMemberInfo(info.fieldName(tmpFor) & "2")
			CASE "radio", "select"
				SELECT CASE info.fieldName(tmpFor)
				CASE "strSex", "bitMailing", "bitOpenInfo", "bitMemo"
					strInputValue = GetOptionArrText("1,0$$$" & REPLACE(info.formData(tmpFor), CHR(13)&CHR(10), ","), objMemberInfo(info.fieldName(tmpFor)))
				CASE ELSE
					strInputValue = objMemberInfo(info.fieldName(tmpFor))
				END SELECT
			CASE "birthday"
				strInputValue = GetReplaceDateStr(objMemberInfo(info.fieldName(tmpFor)), ".") & " " & GetOptionArrText(objXmlLang("option_birthday"), RIGHT(objMemberInfo(info.fieldName(tmpFor)), 1))
			CASE "date"
				strInputValue = GetReplaceDateStr(objMemberInfo(info.fieldName(tmpFor)), ".")
			CASE "marry"
				strInputValue = GetOptionArrText(objXmlLang("option_marry"), LEFT(objMemberInfo(info.fieldName(tmpFor)), 1))
				IF LEFT(objMemberInfo(info.fieldName(tmpFor)), 1) = "1" THEN strInputValue = strInputValue & " " & GetReplaceDateStr(RIGHT(objMemberInfo(info.fieldName(tmpFor)), 8), ".")
			CASE "addr"
				tmpArrData = objMemberInfo(info.fieldName(tmpFor))
				IF tmpArrData <> "" AND ISNULL(tmpArrData) = False THEN
					tmpArrData = SPLIT(tmpArrData, "$$$")
					IF UBOUND(tmpArrData) <> 2 THEN tmpArrData = SPLIT("$$$$$$", "$$$")
				ELSE
					tmpArrData = SPLIT("$$$$$$", "$$$")
				END IF
				IF tmpArrData(0) <> "" THEN tmpArrData(0) = LEFT(tmpArrData(0), 3) & "-" & RIGHT(tmpArrData(0), 3)
				strInputValue = tmpArrData(0) & " " & tmpArrData(1) & " " & tmpArrData(2)
			CASE "corpnum"
				strInputValue = LEFT(objMemberInfo(info.fieldName(tmpFor)), 4) & "-" & MID(objMemberInfo(info.fieldName(tmpFor)), 4, 2) & "-" & MID(objMemberInfo(info.fieldName(tmpFor)), 6, 5)
			END SELECT
%>
					<tr>
						<th scope="row"><%=info.title(tmpFor)%></th>
						<td><%=strInputValue%></td>
					</tr>
<%
		END IF
	NEXT
%>
					<tr>
						<th scope="row"><%=objXmlLang("title_profile")%></th>
						<td class="detail">
<% IF objMemberInfo("strProfile") <> "" THEN %>
						<img src="../<%=CONF_strFilePath%>/member/profile/<%=AdRs_intSeq%>/<%=objMemberInfo("strProfile")%>" align="bottom" width="<%=strPhotoSize(0)%>" height="<%=strPhotoSize(1)%>">
<% END IF %>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_name_image")%></th>
						<td class="detail">
<% IF objMemberInfo("strNameFile") <> "" THEN %>
						<img src="../<%=CONF_strFilePath%>/member/name/<%=AdRs_intSeq%>/<%=objMemberInfo("strNameFile")%>" align="bottom" width="<%=strNameImgSize(0)%>" height="<%=strNameImgSize(1)%>">
<% END IF %>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_mark_image")%></th>
						<td class="detail">
<% IF objMemberInfo("strMarkFile") <> "" THEN %>
						<img src="../<%=CONF_strFilePath%>/member/mark/<%=AdRs_intSeq%>/<%=objMemberInfo("strMarkFile")%>" align="bottom" width="<%=strMarkImgSize(0)%>" height="<%=strMarkImgSize(1)%>">
<% END IF %>
						</td>
					</tr>
				</table>
			<h4><%=objXmlLang("page_sub_title_2")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_group")%></th>
						<td><%=objMemberInfo("strGroupName")%></td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_level")%></th>
						<td><%=objMemberInfo("strLevelName")%></td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_auth")%></th>
						<td><%=GetOptionArrText(objXmlLang("option_auth"), GetBitTypeNumberChg(objMemberInfo("bitAuth")))%></td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_admin")%></th>
						<td><%=GetOptionArrText(objXmlLang("option_admin"), objMemberInfo("strAdmin"))%></td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_area")%></th>
						<td><%=objMemberInfo("strSido")%></td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_article")%></th>
						<td><%=objMemberInfo("intArticle")%></td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_comment")%></th>
						<td><%=objMemberInfo("intComment")%></td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_point")%></th>
						<td><%=objMemberInfo("intPoint")%></td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_stop")%></th>
						<td><% IF objMemberInfo("bitStep") = True THEN %>Y<% ELSE %>N<% END IF %></td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_no_login")%></th>
						<td><%=objMemberInfo("strLoginNoDate")%></td>
					</tr>

					<tr>
						<th scope="row"><%=objXmlLang("title_visit")%></th>
						<td><%=objMemberInfo("intVisit")%>&nbsp;<%=objXmlLang("text_member_count")%>&nbsp;/&nbsp;<%=objXmlLang("text_lastdate")%>&nbsp;<%=objMemberInfo("strVisitDate")%>&nbsp;(<%=objMemberInfo("strVisitIp")%>)</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_regdate")%></th>
						<td><%=objMemberInfo("strRegDate")%></td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_memo")%></th>
						<td><%=objMemberInfo("strAdminMemo")%></td>
					</tr>
				</table>
				<div class="formButtonBox">
				<span class="button large strong"><input type="button" id="btnModify" value="<%=objXmlLang("btn_modify")%>"></span>
				<span class="button large"><input type="button" id="btnList" value="<%=objXmlLang("btn_list")%>"></span>
				</div>
			</div>
		</div>
<%
	SET objMemberInfo = NOTHING
%>
<!-- #include file = "../comm/sub.foot.asp" -->