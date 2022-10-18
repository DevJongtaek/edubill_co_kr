<!-- #include file = "../../../Include/Search.Default.asp" -->
<link rel="stylesheet" type="text/css" href="style/?strSkinPath=search/<%=CONF_strSkinName%>/&strStyleFile=css/<%=CONF_strSkinColor%>.css" />
<script type="text/javascript" src="<%=CONF_skinPath%>js/search.js"></script>
<div class="pa5">
	<div style="padding:10px 0 10px 0;">
		<form id="theForm" name="theForm">
		<input type="text" id="is_keyword" name="is_keyword" class="input_keyword" />
		<span class="button strong" style="margin-top:1px;"><input type="submit" value="<%=objXmlLang("cmd_search")%>" /></span>
		</form>
	</div>
<%
	IF CONF_bitSearchDocument = True AND (subAct = "document" OR subAct = "") THEN
%>
<!-- #include file = "document.asp" -->
<%
	END IF
%>
<%
	IF CONF_bitSearchComment = True AND (subAct = "comment" OR subAct = "") THEN
%>
<!-- #include file = "comment.asp" -->
<%
	END IF
%>
<%
	IF CONF_bitSearchImage = True AND (subAct = "image" OR subAct = "") THEN
%>
<!-- #include file = "image.asp" -->
<%
	END IF
%>
<%
	IF CONF_bitSearchFile = True AND (subAct = "file" OR subAct = "") THEN
%>
<!-- #include file = "file.asp" -->
<%
	END IF
%>
</div>
<div id="pagingArea">
<% IF CONF_intBlockPage = 1 THEN %><a class="prev_page_disabled"><%=objXmlLang("cmd_prev")%></a><% ELSE %><a href="#" name="search_paging" id="page_<%=CONF_intBlockPage - 10%>" class="prev_page" onclick="return false;"><%=objXmlLang("cmd_prev")%></a><% END IF %>
	<span>
<%
	tmpFor = 1
	DO UNTIL tmpFor > 10 OR CONF_intBlockPage > CONF_intPageCount
%>
	<% IF INT(CONF_intBlockPage) = INT(intPage) THEN %><a class="current_page"><%=CONF_intBlockPage%></a><% ELSE %><a href="#" name="search_paging" id="page_<%=CONF_intBlockPage%>" onclick="return false;"><%=CONF_intBlockPage%></a><% END IF %>
<%
		CONF_intBlockPage = CONF_intBlockPage + 1
		tmpFor = tmpFor + 1
	LOOP
%>
	</span>
<% IF CONF_intBlockPage > CONF_intPageCount THEN %><a class="next_page_disabled"><%=objXmlLang("cmd_next")%></a><% ELSE %><a href="#" name="search_paging" id="page_<%=CONF_intBlockPage%>" onclick="return false;" class="next_page"><%=objXmlLang("cmd_next")%></a><% END IF %>
</div>