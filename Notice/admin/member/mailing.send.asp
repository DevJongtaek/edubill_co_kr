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

	DIM strCode, strTitle, strName, strEmail, intMember, strContent
	strCode = GetInputReplce(REQUEST.QueryString("strCode"), "")

	SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_SEND_READ] 'N', '" & strCode & "' ")

	strTitle       = RS("strTitle")
	strName        = RS("strName")
	strEmail       = RS("strEmail")
	intMember      = RS("intMember")
	strContent     = RS("strContent")
%>
<script type="text/javascript" src="member/js/mailing.send.js"></script>
		<form id="extForm" method="post" class="none">
		<input type="hidden" id="intPage" value="<%=intPage%>">
		<input type="hidden" name="intPageSize" value="<%=intPageSize%>">
		</form>
		<div id="content">
			<form id="theForm" action="action/?subAct=mailingsend&Act=mailingsendmember">
			<input type="hidden" id="strCode" name="strCode" value="<%=strCode%>">
			<input type="hidden" id="intTotalCount" name="intTotalCount" value="<%=intMember%>">
			<input type="hidden" id="intPageCountTemp" name="intPageCountTemp" value="1">
			<input type="hidden" id="intPageCount" value="1">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_send")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description_send")%>
			</p>
			<div id="subBody">
				<h4><%=objXmlLang("sub_title_1")%></h4>
				<table class="tabletype02">
					<tr>
						<th scope="row"><%=objXmlLang("title_user")%></th>
						<td class="detail">
						<%=strName%> &lt;<%=strEmail%>&gt;
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_user_count")%></th>
						<td class="detail">
						<%=intMember%> <%=objXmlLang("text_count")%>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_subject")%> </th>
						<td class="detail">
						<%=strTitle%>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_preview")%></th>
						<td class="detail">
						<iframe width="100%" height="400px;" src="action/?subAct=mailingsend&Act=mailingsendprev&strCode=<%=strCode%>"></iframe>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_part_send")%></th>
						<td class="detail">
						<select id="intSendPage">
						<%=GetMakeSelectForm(objXmlLang("option_sendcount"), ",", "100", "")%>
						</select>
						<p class="tip"><%=objXmlLang("about_part_send")%></p>
						</td>
					</tr>
				</table>
				<div id="submitButton" class="formButtonBox">
					<span class="button large strong"><input type="button" id="btn_send_mailing" value="<%=objXmlLang("btn_mailing_send")%>"></span>
					<span class="button large"><input type="button" id="btn_cancel" value="<%=objXmlLang("btn_cancel")%>"></span>
				</div>
			</div>
			</form>
		</div>

<div id="mailsendBox" style="display:none;">
	<div id="loadingIcon"></div>
	<div style="padding:35px 20px 0 0;font-size:11px; float:right;"><span id="sendCnt">0</span><%=objXmlLang("text_send_count")%></div>
	<div style="padding-left:20px; clear:both; font-size:11px; background-color:#F00;">
	<div style="width:160px; float:left; background:#EEE; height:10px; margin-top:5px;"><img id="sendGrp" name="sendGrp" src="images/mailing_grp.gif" width="0" height="10"></div>
	<div style="width:50px; float:right;"><span id="sendPercent">0</span>%</div>
	</div>
</div>
<!-- #include file = "../comm/sub.foot.asp" -->