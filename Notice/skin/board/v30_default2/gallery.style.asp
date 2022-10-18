<div class="albumList">
	<ul>
<%
	LIST_iCount = 0
	FOR tmpFor = 0 TO AdRs_List_Count
		AdRs_List_Temp = AdRs_List
%>
<!-- #include file = "../../../Include/Board.List.Disp.asp" -->
		<li>
			<a href="<%=GetBoardUrl("view", "seq=" & LIST_intSeq)%>"><% IF LIST_strImage = "" THEN %><span class="noimg">No Images </span><% ELSE %><span class="thumb"><img src="<%=LIST_strImage%>" alt="<%=LIST_strTitle%>" class="thrum_img"></span><% END IF %><strong><% IF CONF_bitBoardAdmin = True THEN %><input name="bbs_seq" type="checkbox" id="bbs_seq" value="<%=LIST_intSeq%>" /><% END IF %><%=GetCutDispData(AdRs_List(12, tmpFor), objSkinConfig("display_gallery_title"), "..")%></strong></a>
			<p class="date"><%=REPLACE(LEFT(LIST_strRegDate,10),"-",".")%></p>
			<p><%=LIST_strNickName%></p>
		</li>
<% NEXT %>
	</ul>
</div>