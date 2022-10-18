<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<!-- #include file = "../../libs/function.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM langXmlPath, langXmlFile

	langXmlPath = Server.MapPath("../") & "\"
	langXmlFile = "lang.member.denied.id.xml"

	DIM xmlDOM, objRoot, firstLoop, secondLoop, thirdLoop
	Set xmlDOM = Server.CreateObject("Microsoft.XMLDOM")
	xmlDOM.async = false
%>
<!-- #include file = "../lang/lang.admin.page.control.asp" -->
<script type="text/javascript" src="member/js/member.denied.id.add.js"></script>
			<h4><%=objXmlLang("sub_description_1")%></h4>
			<form id="theAddForm" action="action/?subAct=memberdeniedid&Act=memberdeniedidadd">
				<table class="tabletype01">
					<tr>
						<th scope="row"><%=objXmlLang("title_id")%></th>
						<td>
						<input name="strUserID" type="text" class="ime_mode" id="strUserID" size="60" maxlength="32" style="width:400px;" />
						</td>
					</tr>
					<tr>
						<th scope="row"><%=objXmlLang("title_memo")%></th>
						<td><textarea name="strDescription" id="strDescription" cols="45" rows="5" style="width:400px;"></textarea></td>
					</tr>
				</table>
				<div class="formButtonBox">
					<span class="button large strong"><input type="submit" value="<%=objXmlLang("btn_save")%>"></span>
					<span class="button large"><input type="button" id="btn_cancel" value="<%=objXmlLang("btn_cancel")%>"></span>
				</div>
			</form>
<%
	SET RS = NOTHING : DBCON.CLOSE
%>