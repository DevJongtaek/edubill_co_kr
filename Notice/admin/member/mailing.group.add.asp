<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 3
	menuID      = "C10"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.member.mailing.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	DIM Act
	Act = LCASE(GetInputReplce(REQUEST.QueryString("Act"), "S"))
	IF Act = "" THEN Act = "mailinggroupadd"

	DIM intPage, intPageSize

	intPage = GetInputReplce(REQUEST.QueryString("intPage"), "")
	IF GetNumericCheck(intPage, "i") = False THEN intPage = ""

	intPageSize = REQUEST.FORM("intPageSize")
	IF GetNumericCheck(intPageSize, "i") = False THEN intPageSize = ""

	DIM strGroupCode, strTitle, strDescription

	strGroupCode = GetInputReplce(REQUEST.QueryString("strGroupCode"), "")

	IF Act = "mailinggroupedit" THEN

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_GROUP_READ] 'N', '" & strGroupCode & "' ")

		strTitle       = GetReplaceTag2Text(RS("strTitle"))
		strDescription = RS("strDescription")

	END IF
%>
<script type="text/javascript" src="member/js/mailing.group.add.js"></script>
		<form id="extForm" method="post" class="none">
		<input type="hidden" id="intPage" value="<%=intPage%>">
		<input type="hidden" name="intPageSize" value="<%=intPageSize%>">
		</form>
		<div id="content">
			<form id="theForm" action="action/?subAct=mailinggroup&Act=<%=Act%>">
			<input type="hidden" name="strGroupCode" value="<%=strGroupCode%>">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_group_add")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description_group")%>
			</p>
			<div id="subBody">
				<h4><%=objXmlLang("page_sub_title_3")%></h4>
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_group_name")%></th>
						<td class="detail">
						<input name="strTitle" type="text" id="strTitle" value="<%=strTitle%>" size="100" maxlength="200"/>
						<p class="tip"><%=objXmlLang("about_group_name")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_group_memo")%></th>
						<td class="detail">
						<textarea name="strDescription" id="strDescription" class="textareaCode"><%=strDescription%></textarea>
						<p class="tip"><%=objXmlLang("about_group_memo")%></p>
						</td>
					</tr>
				</table>
				<div class="formButtonBox">
					<span class="button large strong"><input type="submit" value="<%=objXmlLang("btn_save")%>"></span>
					<span class="button large"><input type="button" id="btn_cancel" value="<%=objXmlLang("btn_cancel")%>"></span>
				</div>
			</div>
			</form>
		</div>
<!-- #include file = "../comm/sub.foot.asp" -->