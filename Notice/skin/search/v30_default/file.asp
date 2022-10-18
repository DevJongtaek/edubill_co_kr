<!-- #include file = "../../../Include/Search.File.asp" -->
		<h2><%=objXmlLang("search_file")%> <span>(<%=CONF_intFileCount%>)</span></h2>
<% IF AdRs_List_Count< 0 THEN %>
		<span class="noResult"><%=objXmlLang("no_search")%><br /></span>
<% ELSE %>
		<ul class="searchResult">
<%
	FOR tmpFor = 0 TO AdRs_List_Count
		CONF_strSearchMode = "file"
%>
<!-- #include file = "../../../Include/Search.List.Disp.asp" -->
			<li>
				<dl>
					<dt><a href="<%=LIST_strLink%>" onclick="window.open(this.href);return false;" target="_blank"><%=LIST_strFilename%></a> (<%=LIST_intSize%>)</dt>
				</dl>
				<address><strong><%=LIST_strNickName%></strong> | <span class="time"><%=LIST_strRegDate%></span> | <span class="recom"><%=objXmlLang("down_count")%></span> <span class="recomNum"><%=LIST_intDown%></span> </address>
			</li>
<%
	NEXT
%>
		</ul>
<% END IF %>
<% IF subAct = "" THEN %>
		<div class="isMore"><a href="#" id="file_more" onClick="return false;"><%=objXmlLang("cmd_more")%></a></div>
<% END IF %>