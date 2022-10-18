<!-- #include file = "../../../Include/Search.Document.asp" -->
		<h2><%=objXmlLang("search_document")%> <span>(<%=CONF_intDocumentCount%>)</span></h2>
		<ul class="subNavigation">
			<li><a href="#" name="document_search_target" id="title_content" onclick="return false;"><%=objXmlLang("title")%>+<%=objXmlLang("content")%></a></li>
			<li><a href="#" name="document_search_target" id="title" onclick="return false;"><%=objXmlLang("title")%></a></li>
			<li><a href="#" name="document_search_target" id="content" onclick="return false;"><%=objXmlLang("content")%></a></li>
			<li class="last"><a href="#" name="document_search_target" id="tag" onclick="return false;"><%=objXmlLang("tag")%></a></li>
    </ul>
<% IF AdRs_List_Count< 0 THEN %>
		<span class="noResult"><%=objXmlLang("no_search")%><br /></span>
<% ELSE %>
		<ul class="searchResult">
<%
	FOR tmpFor = 0 TO AdRs_List_Count
		CONF_strSearchMode = "document"
%>
<!-- #include file = "../../../Include/Search.List.Disp.asp" -->
			<li>
<% IF LIST_strImage <> "" THEN %>
				<a href="<%=LIST_strLink%>" onclick="window.open(this.href);return false;" target="_blank"><img src="<%=LIST_strImage%>" alt="<%=LIST_strImage%>" width="80" height="80" class="thumb" /></a>
<% END IF %>
				<dl>
					<dt><a href="<%=LIST_strLink%>" onclick="window.open(this.href);return false;" target="_blank"><%=LIST_strTitle%></a><% IF LIST_intComment > 0 THEN %> <span class="reply">[<em><%=LIST_intComment%></em>]</span><% END IF %></dt>
					<dd><%=LIST_strContent%></dd>
				</dl>
				<address><strong><%=LIST_strNickName%></strong> | <span class="time"><%=LIST_strRegDate%></span> | <span class="read"><%=objXmlLang("readed_count")%></span> <span class="readNum"><%=LIST_intRead%></span></address>
			</li>
<%
	NEXT
%>
		</ul>
<% END IF %>
<% IF subAct = "" THEN %>
		<div class="isMore"><a href="#" id="document_more" onClick="return false;"><%=objXmlLang("cmd_more")%></a></div>
<% END IF %>