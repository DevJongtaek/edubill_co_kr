			<div class="tab_box">
				<table class="admin_tab">
					<colgroup>
					<col width="5"/><col /><col width="6"/>
					<col width="5"/><col /><col width="6"/>
					<col width="5"/><col /><col width="6"/>
					<col width="5"/><col /><col width="6"/>
					<col width="5"/><col /><col width="6"/>
					<col width="5"/><col /><col width="6"/>
					<col width="5"/><col /><col width="6"/>
					<col width="5"/><col /><col width="6"/>
					<col/>
					</colgroup>
				<tbody>
				<tr>
					<td class="tabL2"/>
					<th><a href="?act=boardlist"><%=objXmlLang("tab_menu1")%></a></th>
					<td class="tabR2"/>

					<td class="tabL<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigdefault" THEN %>1<% ELSE %>2<% END IF %>"/>
					<th<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigdefault" THEN %> class="over"<% END IF %>><% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigdefault" THEN %><%=objXmlLang("tab_menu2")%><% ELSE %><a href="?act=boardconfigdefault&intSrl=<%=intSrl%>"><%=objXmlLang("tab_menu2")%></a><% END IF %></th>
					<td class="tabR<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigdefault" THEN %>1<% ELSE %>2<% END IF %>"/>

					<td class="tabL<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigaddition" THEN %>1<% ELSE %>2<% END IF %>"/>
					<th<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigaddition" THEN %> class="over"<% END IF %>><% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigaddition" THEN %><%=objXmlLang("tab_menu3")%><% ELSE %><a href="?act=boardconfigaddition&intSrl=<%=intSrl%>"><%=objXmlLang("tab_menu3")%></a><% END IF %></th>
					<td class="tabR<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigaddition" THEN %>1<% ELSE %>2<% END IF %>"/>

					<td class="tabL<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigfield" OR LCASE(REQUEST.QueryString("Act")) = "boardconfigfieldadd" OR LCASE(REQUEST.QueryString("Act")) = "boardconfigfieldmodify" THEN %>1<% ELSE %>2<% END IF %>"/>
					<th<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigfield" OR LCASE(REQUEST.QueryString("Act")) = "boardconfigfieldadd"OR LCASE(REQUEST.QueryString("Act")) = "boardconfigfieldmodify" THEN %> class="over"<% END IF %>><% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigfield" OR LCASE(REQUEST.QueryString("Act")) = "boardconfigfieldadd" OR LCASE(REQUEST.QueryString("Act")) = "boardconfigfieldmodify" THEN %><%=objXmlLang("tab_menu4")%><% ELSE %><a href="?act=boardconfigfield&intSrl=<%=intSrl%>"><%=objXmlLang("tab_menu4")%></a><% END IF %></th>
					<td class="tabR<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigfield" OR LCASE(REQUEST.QueryString("Act")) = "boardconfigfieldadd" OR LCASE(REQUEST.QueryString("Act")) = "boardconfigfieldmodify" THEN %>1<% ELSE %>2<% END IF %>"/>
					
					<td class="tabL<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigcategory" THEN %>1<% ELSE %>2<% END IF %>"/>
					<th<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigcategory" THEN %> class="over"<% END IF %>><% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigcategory" THEN %><%=objXmlLang("tab_menu5")%><% ELSE %><a href="?act=boardconfigcategory&intSrl=<%=intSrl%>"><%=objXmlLang("tab_menu5")%></a><% END IF %></th>
					<td class="tabR<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigcategory" THEN %>1<% ELSE %>2<% END IF %>"/>

					<td class="tabL<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfiggrantinfo" THEN %>1<% ELSE %>2<% END IF %>"/>
					<th<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfiggrantinfo" THEN %> class="over"<% END IF %>><% IF LCASE(REQUEST.QueryString("Act")) = "boardconfiggrantinfo" THEN %><%=objXmlLang("tab_menu6")%><% ELSE %><a href="?act=boardconfiggrantinfo&intSrl=<%=intSrl%>"><%=objXmlLang("tab_menu6")%></a><% END IF %></th>
					<td class="tabR<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfiggrantinfo" THEN %>1<% ELSE %>2<% END IF %>"/>

					<td class="tabL<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigpoint" THEN %>1<% ELSE %>2<% END IF %>"/>
					<th<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigpoint" THEN %> class="over"<% END IF %>><% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigpoint" THEN %><%=objXmlLang("tab_menu7")%><% ELSE %><a href="?act=boardconfigpoint&intSrl=<%=intSrl%>"><%=objXmlLang("tab_menu7")%></a><% END IF %></th>
					<td class="tabR<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigpoint" THEN %>1<% ELSE %>2<% END IF %>"/>

					<td class="tabL<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigskin" THEN %>1<% ELSE %>2<% END IF %>"/>
					<th<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigskin" THEN %> class="over"<% END IF %>><% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigskin" THEN %><%=objXmlLang("tab_menu8")%><% ELSE %><a href="?act=boardconfigskin&intSrl=<%=intSrl%>"><%=objXmlLang("tab_menu8")%></a><% END IF %></th>
					<td class="tabR<% IF LCASE(REQUEST.QueryString("Act")) = "boardconfigskin" THEN %>1<% ELSE %>2<% END IF %>"/>
					<td class="tar"/>
				</tr>
				</tbody>
				</table>
				</div>
				<div class="fr mb5">
				<input type="hidden" id="boardAct" value="<%=REQUEST.QueryString("Act")%>" />
				<select name="confBoard" id="confBoard" onchange="configBoardChange(this);">
				<%=GetMakeSelectForm(objXmlLang("option_board_select"), ",", "", "")%>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_CONFIG_LIST] 'L', '', '', '' ")

	DIM strConfigBoardID

	WHILE NOT(RS.EOF)
		IF INT(RS("intSrl")) = INT(intSrl) THEN strConfigBoardID = RS("strBoardID")
%>
				<option value="<%=RS("intSrl")%>"<% IF INT(RS("intSrl")) = INT(intSrl) THEN %> selected<% END IF %>><%=RS("strTitle")%> [<%=RS("strBoardID")%>]</option>
<%
	RS.MOVENEXT
	WEND
%>
				</select>
				<span class="button medium ml5"><input type="button" id="btn_board_view" value="<%=objXmlLang("btn_board_view")%>" /></span>
				</div>
<script type="text/javascript">

	var configBoardID = "<%=strConfigBoardID%>";

	function configBoardChange(obj){
		document.location.href = "?Act=" + $("#boardAct").val() + "&intSrl=" + obj.value.split(",")[0];
		return false;
	}

	$(document).ready(function() {

		$("#btn_board_view").click(function(){
			window.open("../?bid=" + configBoardID);
		});

	});

</script>