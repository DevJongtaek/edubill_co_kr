<!-- #include file = "../../../Include/Board.Tag.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/tag.js"></script>
<div class="tagList">
<%
	FOR tmpFor = 0 TO AdRs_List_Count
%>
<!-- #include file = "../../../Include/Board.Tag.Disp.asp" -->
<%
			IF LIST_intCount < 5 THEN
				strTagStyle = "rank5"
			ELSEIF LIST_intCount < 10 THEN
				strTagStyle = "rank4"
			ELSEIF LIST_intCount < 20 THEN
				strTagStyle = "rank3"
			ELSEIF LIST_intCount < 30 THEN
				strTagStyle = "rank2"
			ELSEIF LIST_intCount < 50 THEN
				strTagStyle = "rank1"
			END IF
%>
	<a class="<%=strTagStyle%>" href="<%=GetBoardUrl("", "page=" & CONF_intBlockPage & ",search_keyword=" & LIST_strTag & ",search_target=tag")%>" name="tag_link" id="<%=LIST_strTag%>"><%=LIST_strTag%></a>
<%
	NEXT
%>
</div>
<div class="tagFooter">
	<span class="button btn03"><a href="<%=GetBoardUrl("",  "search_keyword=,search_target=")%>"><%=objXmlLang("cmd_back")%></a></span>
</div>
<!-- #include file = "common.footer.asp" -->