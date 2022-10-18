<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM langXmlPath, langXmlFile

	langXmlPath = Server.MapPath("../") & "\"
	langXmlFile = "lang.board.xml"

	DIM act
	act = GetInputReplce(REQUEST.QueryString("act"), "")

	DIM xmlDOM, objRoot, firstLoop, secondLoop, thirdLoop
	Set xmlDOM = Server.CreateObject("Microsoft.XMLDOM")
	xmlDOM.async = false
%>
<!-- #include file = "../lang/lang.admin.page.control.asp" -->
<%
	DIM intSrl, intCode
	intSrl  = GetInputReplce(REQUEST.FORM("intSrl"), "")
	intCode = GetInputReplce(REQUEST.FORM("intCode"), "")

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CATEGORY_READ] '" & intSrl & "', '" & intCode & "' ")
	
	DIM intParentCode, strTitle, strParentTitle, strFontColor, bitDispArticleCount, strGroupCode

	IF NOT(RS.EOF) THEN

		intParentCode       = RS("intParentCode")
		strTitle            = RS("strTitle")
		strFontColor        = REPLACE(RS("strFontColor"), "#", "")
		bitDispArticleCount = GetBitTypeNumberChg(RS("bitDispArticleCount"))
		strGroupCode        = RS("strGroupCode")

	END IF
%>
<script type="text/javascript" src="board/js/board.config.category.add.js"></script>
						<form id="addForm" action="action/?subAct=boardconfigcategory&Act=modify&intSrl=<%=intSrl%>">
						<input type="hidden" name="intCode" id="intCode" value="<%=intCode%>" />
						<table id="detail_table" class="baseTable">
							<colgroup>
								<col width="90" /><col/>
							</colgroup>
							<tbody>
							<tr>
								<th><%=objXmlLang("title_category_name")%></th>
								<td><input name="strTitle" type="text" id="strTitle" value="<%=strTitle%>" size="50" maxlength="100" /></td>
							</tr>
							<tr>
								<th><%=objXmlLang("title_font_color")%></th>
								<td><input name="strFontColor" type="text" id="strFontColor" value="<%=strFontColor%>" size="10" readonly class="hand"></td>
							</tr>
							<tr>
								<th><%=objXmlLang("title_category_count")%></th>
								<td><%=GetMakeCheckForm(objXmlLang("option_use_count"), ",", bitDispArticleCount, "bitDispArticleCount", "", "")%></td>
							</tr>
							<tr>
								<th><%=objXmlLang("title_group")%></th>
								<td>
									<div id="groupDiv" class="radiocheckArea pt5 pb5">
										<ul>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_LIST] ")

	tmpFor = 0

	WHILE NOT(RS.EOF)

		tmpFor = tmpFor + 1
		RESPONSE.WRITE "<li><input type=""checkbox"" name=""strGroupCode"" id=""strGroupCode" & tmpFor & """ value=""" & RS("strGroupCode") & """"
		IF strGroupCode <> "" AND ISNULL(strGroupCode) = False THEN
			IF INSTR(strGroupCode, RS("strGroupCode")) <> 0 THEN RESPONSE.WRITE " checked"
		END IF
		RESPONSE.WRITE " /><label for=strGroupCode" & tmpFor & ">" & RS("strTitle") & "</label></li>" & CHR(13)
	RS.MOVENEXT
	WEND
%>
										</ul>
									</div>
									<p class="tip"><%=objXmlLang("text_group")%></p>
								</td>
							</tr>
							</tbody>
						</table>
						<div class="formButtonBox mt10">
							<span class="button large strong"><input type="submit" value="<%=objXmlLang("btn_save")%>"></span>
						</div>
						</form>
<%
	SET RS = NOTHING : DBCON.CLOSE
%>