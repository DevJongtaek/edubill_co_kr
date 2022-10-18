<!-- #include file = "../../../Include/Board.Tag.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/tag.js"></script>
<div class="boardTag fg">
	<p>
<%
	FOR tmpFor = 0 TO AdRs_List_Count
%>
<!-- #include file = "../../../Include/Board.Tag.Disp.asp" -->
<%
			IF LIST_intCount < 5 THEN
				strTagStyle = "i1"
			ELSEIF LIST_intCount < 10 THEN
				strTagStyle = "i2"
			ELSEIF LIST_intCount < 20 THEN
				strTagStyle = "i3"
			ELSEIF LIST_intCount < 30 THEN
				strTagStyle = "i4"
			ELSEIF LIST_intCount < 50 THEN
				strTagStyle = "i5"
			END IF
%>
<a href="<%=GetBoardUrl("", "page=" & CONF_intBlockPage & ",search_keyword=" & LIST_strTag & ",search_target=tag")%>" name="tag_link" id="<%=LIST_strTag%>" class="<%=strTagStyle%>"><%=LIST_strTag%></a>
<%
	NEXT
%>
	</p>
	<div class="buttonArea">
		<span class="button medium"><a href="<%=GetBoardUrl("",  "search_keyword=,search_target=")%>"><%=objXmlLang("cmd_back")%></a></span>
	</div>
</div>
<!-- #include file = "common.footer.asp" -->