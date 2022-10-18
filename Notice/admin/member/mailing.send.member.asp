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
	IF Act = "" THEN Act = "mailingsendadd"

	DIM intPage, intPageSize

	intPage = GetInputReplce(REQUEST.QueryString("intPage"), "")
	IF GetNumericCheck(intPage, "i") = False THEN intPage = ""

	intPageSize = REQUEST.FORM("intPageSize")
	IF GetNumericCheck(intPageSize, "i") = False THEN intPageSize = ""

	DIM strCode, strTitle
	strCode = GetInputReplce(REQUEST.QueryString("strCode"), "")

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_READ] 'N', '" & strCode & "' ")

	strTitle = RS("strTitle")
%>
<script type="text/javascript" src="../js/jquery.textarearesizer.js"></script>
<script type="text/javascript" src="member/js/mailing.send.member.js"></script>
		<form id="extForm" method="post" class="none">
		<input type="hidden" id="intPage" value="<%=intPage%>">
		<input type="hidden" name="intPageSize" value="<%=intPageSize%>">
		</form>
		<div id="content">
			<form id="theForm" action="action/?subAct=mailingsend&Act=mailingsendmember">
			<input type="hidden" name="strCode" value="<%=strCode%>">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_target")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description_target")%>
			</p>
			<div id="subBody">
				<h4><%=objXmlLang("page_sub_title_1")%></h4>
				<table class="tabletype02">
					<tr>
						<th scope="row"><%=objXmlLang("title_subject")%></th>
						<td class="detail">
						<%=strTitle%>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_group")%></th>
						<td class="detail">
						<div class="radiocheckArea pt5 pb5">
							<ul>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_LIST] ")

	tmpFor = 0

	WHILE NOT(RS.EOF)

		tmpFor = tmpFor + 1
		RESPONSE.WRITE "<li><input type=""checkbox"" name=""strMemberGroup"" id=""strMemberGroup" & tmpFor & """ value=""" & RS("strGroupCode") & """"
		IF strAccessGroup <> "" AND ISNULL(strAccessGroup) = False THEN
			IF INSTR(strAccessGroup, RS("strGroupCode")) <> 0 THEN RESPONSE.WRITE " checked"
		END IF
		RESPONSE.WRITE " /><label for=strMemberGroup" & tmpFor & ">" & RS("strTitle") & " <span class=num>(" & RS("intMemberCount") & ")</span></label></li>" & CHR(13)
	RS.MOVENEXT
	WEND
%>
							</ul>
						</div>
						<p class="tip"><%=objXmlLang("about_group")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_mailing_group")%></th>
						<td class="detail">
						<div class="radiocheckArea pt5 pb5">
							<ul>
<%
	SET RS = DBCON.EXECUTE("ARTY30_SP_MAILING_GROUP_LIST 'A' ")

	tmpFor = 0

	WHILE NOT(RS.EOF)

		tmpFor = tmpFor + 1
		RESPONSE.WRITE "<li><input type=""checkbox"" name=""strMailGroup"" id=""strMailGroup" & tmpFor & """ value=""" & RS("strGroupCode") & """"
		IF strAccessGroup <> "" AND ISNULL(strAccessGroup) = False THEN
			IF INSTR(strAccessGroup, RS("strGroupCode")) <> 0 THEN RESPONSE.WRITE " checked"
		END IF
		RESPONSE.WRITE " /><label for=strMailGroup" & tmpFor & ">" & RS("strTitle") & " <span class=num>(" & RS("intMember") & ")</span></label></li>" & CHR(13)
	RS.MOVENEXT
	WEND
%>
							</ul>
						</div>
						<p class="tip"><%=objXmlLang("about_mailing_group")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_userid")%></th>
						<td class="detail">
						<textarea name="strMemberID" id="strMemberID" cols="45" rows="5" class="resizable"></textarea>
						<p class="tip"><%=objXmlLang("about_userid")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_user_input")%></th>
						<td class="detail">
							<textarea name="strMemberEmail" id="strMemberEmail" cols="45" rows="5" class="resizable"></textarea>
							<p class="tip"><%=objXmlLang("about_user_input")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_etc_mail")%></th>
						<td class="detail">
							<%=GetMakeCheckForm(objXmlLang("option_etcuser"), ",", "", "strMemberEtc", "", "")%>
							<p class="tip"><%=objXmlLang("about_etc_mail")%></p>
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