<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #include file = "../../files/config/db.config.asp" -->
<!-- #include file = "../../libs/dbconn.asp" -->
<%
	Response.CharSet = "utf-8"

	DIM langXmlPath, langXmlFile

	langXmlPath = Server.MapPath("../") & "\"
	langXmlFile = "lang.member.group.xml"

	DIM xmlDOM, objRoot, firstLoop, secondLoop, thirdLoop

	Set xmlDOM = Server.CreateObject("Microsoft.XMLDOM")
	xmlDOM.async = false
%>
<!-- #include file = "../lang/lang.admin.page.control.asp" -->
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_MEMBER_GROUP_LIST] ")

	WHILE NOT(RS.EOF)
%>
						<tr>
							<td class="detail"></td>
							<td class="chk"><input name="strGroupCode" type="checkbox" id="strGroupCode" value="<%=RS("strGroupCode")%>"></td>
							<td class="lfpd"><%=RS("strTitle")%></td>
							<td class="lfpd"><%=RS("strDescription")%></td>
							<td class="detail"><% IF RS("bitDefault") = True THEN %>Y<% END IF %></td>
							<td class="detail"><%=RS("intMemberCount")%></td>
							<td class="detail num"><%=REPLACE(LEFT(RS("strRegDate"),10),"-",".")%></td>
							<td class="detail"><span class="button h20"><a name="btn_modify" id="<%=RS("strGroupCode")%>"><%=objXmlLang("btn_modify")%></a></span></td>
							<td class="detail">
							<% IF RS("strGroupCode") = "G000000000" OR RS("strGroupCode") = "G000000001" THEN %><% ELSE %><span class="button h20"><a name="btn_delete" id="<%=RS("strGroupCode")%>" member="<%=RS("intMemberCount")%>"><%=objXmlLang("btn_remove")%></a></span><% END IF %>
							</td>
						</tr>
<%
	RS.MOVENEXT
	WEND

	SET RS = NOTHING : DBCON.CLOSE
	SET xmlDOM = NOTHING : SET objRoot = NOTHING : SET rootNode = NOTHING : SET objXmlLang = NOTHING
%>
<script type="text/javascript">

	$(document).ready(function() {

		$("input:checkbox").checkbox();
		$("input:radio").checkbox({cls:"jquery-radio"});

	});

</script>