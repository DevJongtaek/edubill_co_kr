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

	DIM strTitle, intBoardCount

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CATEGORY_READ] '" & intSrl & "', '" & intCode & "' ")
	
	strTitle      = RS("strTitle")
	intBoardCount = RS("intBoardCount")
%>
<script type="text/javascript" src="board/js/board.config.category.move.js"></script>
						<form id="moveForm" action="action/?subAct=boardconfigcategory&Act=document_move&intSrl=<%=intSrl%>">
						<input type="hidden" name="intCode" id="intCode" value="<%=intCode%>" />
						<input type="hidden" name="intDocumentCode" id="intDocumentCode" value="<%=intBoardCount%>" />
						<table id="detail_table" class="baseTable">
							<colgroup>
								<col width="90" /><col/>
							</colgroup>
							<tbody>
							<tr>
								<th><%=objXmlLang("title_category_name")%></th>
								<td><%=strTitle%></td>
							</tr>
							<tr>
								<th><%=objXmlLang("title_document_count")%></th>
								<td><%=intBoardCount%></td>
							</tr>
							<tr>
								<th><%=objXmlLang("title_move_category")%></th>
								<td>
									<select id="intTargetSrl" name="intTargetSrl">
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CATEGORY_LIST] '" & intSrl & "' ")

	DIM strSortCol

	WHILE NOT(RS.EOF)

	strSortCol = ""

	IF (LEN(RS("sortcol")) / 2) - 1 > 0 THEN
		FOR tmpFor = 1 TO (LEN(RS("sortcol")) / 2) - 1
			strSortCol = strSortCol & "&nbsp;"
		NEXT
	END IF
%>
									<option value="<%=RS("intModuleCode")%>"><%=strSortCol%><%=RS("strTitle")%></option>
<%
	RS.MOVENEXT
	WEND
%>
									</select>
								</td>
							</tr>
							</tbody>
						</table>
						<div class="formButtonBox mt10">
							<span class="button large strong"><input type="submit" value="<%=objXmlLang("btn_article_move")%>"></span>
						</div>
						</form>
<%
	SET RS = NOTHING : DBCON.CLOSE
%>