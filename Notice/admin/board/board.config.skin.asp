<!--METADATA TYPE="typelib" NAME="ADODB Type Library" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll"-->
<%
	DIM topMenu, menuID, langXmlPath, langXmlFile

	topMenu     = 4
	menuID      = "D02"
	langXmlPath = Server.MapPath(".") & "\"
	langXmlFile = "lang.board.xml"
%>
<!-- #include file = "../comm/sub.head.asp" -->
<%
	ON ERROR RESUME NEXT

	DIM intSrl
	intSrl = GetInputReplce(REQUEST.QueryString("intSrl"), "")

	DIM strSkinName, strSkinXmlPath

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_READ] '" & intSrl & "' ")

	strSkinName    = RS("strSkinName")
	strSkinXmlPath = Server.MapPath("../") & "\skin\board\" & strSkinName & "\"

	xmlDOM.Load strSkinXmlPath & "skin.xml"

	SET rootNode = xmlDOM.selectNodes(LCASE("/skin"))

	DIM objSkinInfo
	SET objSkinInfo = Server.CreateObject("Scripting.Dictionary")

	FOR rootLoop = 0 To rootNode(0).childNodes.Length-1

		SELECT CASE rootNode(0).childNodes(rootLoop).nodename
		CASE "title"
			IF rootNode(0).childNodes(rootLoop).getAttribute("lang") = CONF_strLangType THEN
				objSkinInfo.Add "skinTitle", rootNode(0).childNodes(rootLoop).text
			END IF
		CASE "description"
			IF rootNode(0).childNodes(rootLoop).getAttribute("lang") = CONF_strLangType THEN
				objSkinInfo.Add "skinMemo", rootNode(0).childNodes(rootLoop).text
			END IF
		CASE "version"
			objSkinInfo.Add "skinVersion", rootNode(0).childNodes(rootLoop).text
		CASE "date"
			objSkinInfo.Add "skinDate", rootNode(0).childNodes(rootLoop).text
		CASE "author"
			FOR firstLoop = 0 TO rootNode(0).childNodes(rootLoop).childNodes.length - 1
				IF rootNode(0).childNodes(rootLoop).childNodes(firstLoop).getAttribute("lang") = CONF_strLangType THEN
					objSkinInfo.Add "skinAuthor", rootNode(0).childNodes(rootLoop).childNodes(firstLoop).text
				END IF
			NEXT
			IF rootNode(0).childNodes(rootLoop).getAttribute("email_address") <> "" THEN
				objSkinInfo.Add "skinEmail", rootNode(0).childNodes(rootLoop).getAttribute("email_address")
			END IF
			IF rootNode(0).childNodes(rootLoop).getAttribute("link") <> "" THEN
				objSkinInfo.Add "skinLink", rootNode(0).childNodes(rootLoop).getAttribute("link")
			END IF
		CASE "license"
			objSkinInfo.Add "skinLicense", rootNode(0).childNodes(rootLoop).text
		END SELECT

	NEXT

	DIM objSkinConfig
	SET objSkinConfig = Server.CreateObject("Scripting.Dictionary")

	DIM AdCmd, AdRS

	SET	AdCmd	= SERVER.CREATEOBJECT("ADODB.Command")
	SET	AdRS	= SERVER.CREATEOBJECT("ADODB.RecordSet")

	AdRs_GetRows_Count = ""
	WITH AdCmd
			
		.ActiveConnection	= db_connect
		.CommandText    = "ARTY30_SP_BOARD_SKIN_CONFIG_LIST"
		.CommandTimeOut = 10
		.CommandType    = adCmdStoredProc
		.Parameters.Append	.CreateParameter("intSrl",			adInteger,	adParamInput,	,	intSrl)

		AdRs.Open .Execute

		IF (NOT (AdRs.EOF OR AdRs.BOF)) THEN
			AdRs_GetRows 		= AdRs.GetRows
			AdRs_GetRows_Count	= UBOUND(AdRs_GetRows, 2)
		END IF

		AdRs.Close
			
	END WITH

	WITH objSkinConfig

		IF AdRs_GetRows_Count <> "" THEN
			FOR tmpFor = 0 TO AdRs_GetRows_Count
				.Add AdRs_GetRows(0, tmpFor), AdRs_GetRows(1, tmpFor)
			NEXT
		END IF
	
	END WITH

	SET	AdCmd	= NOTHING
	SET	AdRS	= NOTHING
%>
<script type="text/javascript" src="board/js/board.config.skin.js"></script>
		<div id="content">
			<form id="theForm">
			<input type="hidden" name="intSrl" id="intSrl" value="<%=intSrl%>">
			<div id="subHead">
				<h3><%=objXmlLang("page_title_config_skin")%></h3>
			</div>
			<p class="subHeadDesc">
			<%=objXmlLang("page_description_config_skin")%>
			</p>
			<div id="subBody">
<!-- #include file = "board.config.comm.asp" -->
				<h4><%=objXmlLang("page_sub_title_11")%></h4>
				<table class="tabletype02">
					<tr>
						<th scope="row"><%=objXmlLang("title_skin_name")%></th>
						<td class="text"><%=objSkinInfo("skinTitle")%><% IF objSkinInfo("skinVersion") <> "" THEN %> (<%=objSkinInfo("skinVersion")%>)<% END IF %></td>
					</tr>
<% IF objSkinInfo("skinAuthor") <> "" THEN %>
					<tr>
						<th scope="row"><%=objXmlLang("title_maker")%></th>
						<td class="text"><%=objSkinInfo("skinAuthor")%><% IF objSkinInfo("skinEmail") <> "" OR objSkinInfo("skinLink") <> "" THEN %> (<% IF objSkinInfo("skinLink") <> "" THEN %><a href="<%=objSkinInfo("skinLink")%>" target="_blank"><%=objSkinInfo("skinLink")%></a><% END IF %><% IF objSkinInfo("skinEmail") <> "" THEN %><% IF objSkinInfo("skinLink") <> "" THEN %>, <% END IF %><a href="mailto:<%=objSkinInfo("skinEmail")%>"><%=objSkinInfo("skinEmail")%></a><% END IF %>)<% END IF %></td>
					</tr>
<% END IF %>
<% IF objSkinInfo("skinDate") <> "" THEN %>
					<tr>
						<th scope="row"><%=objXmlLang("title_date")%></th>
						<td class="text"><%=objSkinInfo("skinDate")%></td>
					</tr>
<% END IF %>
<% IF objSkinInfo("skinLicense") <> "" THEN %>
					<tr>
						<th scope="row"><%=objXmlLang("title_licenSe")%></th>
						<td class="text"><%=objSkinInfo("skinLicense")%></td>
					</tr>
<% END IF %>
<% IF objSkinInfo("skinMemo") <> "" THEN %>
					<tr>
						<th scope="row"><%=objXmlLang("title_memo")%></th>
						<td class="text"><%=objSkinInfo("skinMemo")%></td>
					</tr>
<% END IF %>
				</table>
				<div class="pt10"></div>
				<h4><%=objXmlLang("page_sub_title_12")%></h4>
				<table class="tabletype01">
<%
	SET rootNode = xmlDOM.selectNodes(LCASE("/skin/extra_vars"))

	DIM strSkinExtTitle, strSkinExtMemo, strSkinDimName, strSkinDimType, strSKinDefaultValue, strOptionTitle, strOptionValue

	FOR rootLoop = 0 To rootNode(0).childNodes.Length - 1

		strSkinDimName      = rootNode(0).childNodes(rootLoop).getAttribute("name")
		strSkinDimType      = rootNode(0).childNodes(rootLoop).getAttribute("type")
		strSKinDefaultValue = rootNode(0).childNodes(rootLoop).getAttribute("default")
		strSkinExtTitle     = ""
		strSkinExtMemo      = ""
		strOptionTitle      = ""
		strOptionValue      = ""

		IF objSkinConfig(strSkinDimName) = "" THEN objSkinConfig(strSkinDimName) = strSKinDefaultValue

		FOR firstLoop = 0 TO rootNode(0).childNodes(rootLoop).childNodes.length - 1
			SELECT CASE rootNode(0).childNodes(rootLoop).childNodes(firstLoop).nodename
			CASE "title"
				IF rootNode(0).childNodes(rootLoop).childNodes(firstLoop).getAttribute("lang") = CONF_strLangType THEN
					strSkinExtTitle = rootNode(0).childNodes(rootLoop).childNodes(firstLoop).text
				END IF
			CASE "description"
				IF rootNode(0).childNodes(rootLoop).childNodes(firstLoop).getAttribute("lang") = CONF_strLangType THEN
					strSkinExtMemo = rootNode(0).childNodes(rootLoop).childNodes(firstLoop).text
				END IF
			CASE "options"
				IF strOptionTitle <> "" THEN strOptionTitle = strOptionTitle & "|||"
				IF strOptionValue <> "" THEN strOptionValue = strOptionValue & "|||"
				strOptionValue = strOptionValue & rootNode(0).childNodes(rootLoop).childNodes(firstLoop).getAttribute("value")
				FOR secondLoop = 0 TO rootNode(0).childNodes(rootLoop).childNodes(firstLoop).childNodes.length - 1
					IF rootNode(0).childNodes(rootLoop).childNodes(firstLoop).childNodes(secondLoop).getAttribute("lang") = CONF_strLangType THEN
						strOptionTitle = strOptionTitle & rootNode(0).childNodes(rootLoop).childNodes(firstLoop).childNodes(secondLoop).text
					END IF
				NEXT
			END SELECT
		NEXT
%>
					<tr>
						<th scope="row"><%=strSkinExtTitle%></th>
						<td>
<%
	SELECT CASE strSkinDimType
	CASE "text"
%>
							<input name="<%=strSkinDimName%>" type="text" id="<%=strSkinDimName%>" size="80" value="<%=objSkinConfig(strSkinDimName)%>">
<%
	CASE "textarea"
%>
							<textarea name="<%=strSkinDimName%>" id="<%=strSkinDimName%>" cols="100" rows="10"><%=objSkinConfig(strSkinDimName)%></textarea>
<%
	CASE "select"
%>
							<select name="<%=strSkinDimName%>" id="<%=strSkinDimName%>">
							<%=GetMakeSelectForm(strOptionValue & "$$$" & strOptionTitle, "|||", objSkinConfig(strSkinDimName), "")%>
							</select>
<%
	CASE "radio"
%>
							<dl class="radio_form">
								<%=GetMakeRadioForm(strOptionValue & "$$$" & strOptionTitle, "|||", objSkinConfig(strSkinDimName), "bitDispNotice", "<dd>", "</dd>")%>
							</dl>
<%
	END SELECT
%>
							<% IF strSkinExtMemo <> "" THEN %><p class="tip"><%=strSkinExtMemo%></p><% END IF %>
							</td>
					</tr>
<%
	NEXT
%>
				</table>
				<div class="formButtonBox">
					<span class="button large strong"><input name="submit" type="submit" value="<%=objXmlLang("btn_save")%>"></span>
				</div>
			</div>
			</form>
		</div>
<%
	IF err.Number <> 0 THEN
		RESPONSE.WRITE "<script type=""text/javascript"">" & CHR(10)
		RESPONSE.WRITE "alert('" & objXmlLang("text_error") & "\n\nERR:" & err.Number & ":" & err.Description & "');" & CHR(10)
		RESPONSE.WRITE "history.back(-1);" & CHR(10)
		RESPONSE.WRITE "</script>" & CHR(10)
		RESPONSE.End()
	END IF

	SET objSkinInfo = NOTHING : SET objSkinConfig = NOTHING
%>
<!-- #include file = "../comm/sub.foot.asp" -->