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

	DIM searchMode, searchText
	searchMode = GetInputReplce(REQUEST.FORM("searchMode"), "")
	searchText = GetInputReplce(REQUEST.FORM("searchText"), "")

	DIM intSeq, strName, strEmail, strCompany, strPostion, strClass, strTel, strMobile, strFax, strPost, strAddr1, strAddr2
	DIM strMemo, bitSend

	intSeq = LCASE(GetInputReplce(REQUEST.QueryString("intSeq"), "S"))

	SELECT CASE Act
	CASE "mailingetcadd"

		bitSend = "1"

	CASE "mailingetcedit"

		SET RS = DBCON.EXECUTE("[ARTY30_SP_MAILING_ETC_READ] '" & intSeq & "' ")

		strName    = GetReplaceTag2Text(RS("strName"))
		strEmail   = GetReplaceTag2Text(RS("strEmail"))
		strCompany = GetReplaceTag2Text(RS("strCompany"))
		strPostion = GetReplaceTag2Text(RS("strPostion"))
		strClass   = GetReplaceTag2Text(RS("strClass"))
		strTel     = GetReplaceTag2Text(RS("strTel"))
		strMobile  = GetReplaceTag2Text(RS("strMobile"))
		strFax     = GetReplaceTag2Text(RS("strFax"))
		strPost    = RS("strPost")
		strAddr1   = RS("strAddr1")
		strAddr2   = GetReplaceTag2Text(RS("strAddr2"))
		bitSend    = GetBitTypeNumberChg(RS("bitSend"))

		IF strPost <> "" AND ISNULL(strPost) = False THEN strPost = LEFT(strPost, 3) & "-" & RIGHT(strPost, 3)

	END SELECT
%>
<script type="text/javascript" src="../js/jquery.textarearesizer.js"></script>
<script type="text/javascript" src="member/js/mailing.etc.add.js"></script>
		<form id="extForm" method="post" class="none">
		<input type="hidden" id="intPage" value="<%=intPage%>">
		<input type="hidden" name="intPageSize" value="<%=intPageSize%>">
		<input type="hidden" name="searchMode" value="<%=searchMode%>">
		<input type="hidden" name="searchText" value="<%=searchText%>">
		</form>
		<div id="content">
			<form id="theForm" action="action/?subAct=mailingetc&Act=<%=Act%>">
			<input type="hidden" name="intSeq" value="<%=intSeq%>">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_etc_add")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description_etc")%>
			</p>
			<div id="subBody">
				<h4><%=objXmlLang("page_sub_title_6")%></h4>
				<table class="tabletype02">
					<tr>
						<th scope="row"><%=objXmlLang("title_name")%></th>
						<td class="detail">
						<input name="strName" type="text" id="strName" value="<%=strName%>" size="30" maxlength="50"/>
						<p class="tip"><%=objXmlLang("about_name")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_email")%></th>
						<td class="detail">
						<input name="strEmail" type="text" id="strEmail" value="<%=strEmail%>" size="60" maxlength="100"/>
						<p class="tip"><%=objXmlLang("about_email")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_company")%></th>
						<td class="detail">
						<input name="strCompany" type="text" id="strCompany" value="<%=strCompany%>" size="60" maxlength="100"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_position")%></th>
						<td class="detail">
						<input name="strPostion" type="text" id="strPostion" value="<%=strPostion%>" size="40" maxlength="100"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_class")%></th>
						<td class="detail">
						<input name="strClass" type="text" id="strClass" value="<%=strClass%>" size="40" maxlength="100"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_tel")%></th>
						<td class="detail">
						<input name="strTel" type="text" id="strTel" value="<%=strTel%>" size="20" maxlength="30"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_mobile")%></th>
						<td class="detail">
						<input name="strMobile" type="text" id="strMobile" value="<%=strMobile%>" size="20" maxlength="30"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_fax")%></th>
						<td class="detail">
						<input name="strFax" type="text" id="strFax" value="<%=strFax%>" size="20" maxlength="30"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_addr")%></th>
						<td class="detail">
						<div id="addrForm_strAddr1" class="both" style="display:none;">
							<dd class="fl mr5"><input type="text" name="strAddr1" id="strAddr1"></dd>
							<dd class="fl mr5"><span class="button small"><input type="button" onClick="Post.SearchFormAddr('strAddr');" value="<%=objXmlLang("btn_search")%>"></span></dd>
							<dd><span class="button small"><input type="button" onClick="Post.SearchFormCancel('strAddr');" value="<%=objXmlLang("btn_cancel")%>"></span></dd>
						</div>
						<div id="addrForm_strAddr2" class="both" style="display:none;">
							<select name="strAddr2" id="strAddr2">
							<option value="">SELECT</option>
							</select>
							<span class="fl ml5"><span class="button small"><input type="button" onClick="Post.SearchFormSelect('strAddr');" value="<%=objXmlLang("btn_select")%>"></span></span>
							<span class="fl ml5"><span class="button small"><input type="button" onClick="Post.SearchFormListCancel('strAddr');" value="<%=objXmlLang("btn_cancel")%>"></span></span>
						</div>
						<div id="addrForm_strAddr3">
							<ul>
								<li class="fl mb5">
									<span class="fl mr5"><input name="strAddr3" type="text" id="strAddr3" size="10" readonly value="<%=strPost%>"></span>
									<span class="fl"><span class="button small"><input type="button" onClick="Post.SearchForm('strAddr');" value="<%=objXmlLang("btn_post_find")%>"></span></span>
								</li>
								<li class="both mb5"><input name="strAddr4" type="text" id="strAddr4" value="<%=strAddr1%>" size="80" maxlength="150" readonly></li>
								<li><input name="strAddr5" type="text" id="strAddr5" value="<%=strAddr2%>" size="80" maxlength="150"></li>
							</ul>
						</div>
						<p class="tip"><%=objXmlLang("about_addr")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_memo")%></th>
						<td class="detail">
						<textarea name="strMemo" id="strMemo" class="resizable"><%=strMemo%></textarea>
						<p class="tip"><%=objXmlLang("about_memo")%></p>
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_maling")%></th>
						<td class="detail">
						<dl class="radio_form">
							<%=GetMakeRadioForm(objXmlLang("option_use"), ",", bitSend, "bitSend", "<dd>", "</dd>")%>
						</dl>
						<p class="tip"><%=objXmlLang("about_maling")%></p>
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