<!-- #include file = "../../../Include/Search.Comment.asp" -->
		<h2><%=objXmlLang("search_comment")%> <span>(<%=CONF_intCommentCount%>)</span></h2>
<% IF AdRs_List_Count< 0 THEN %>
		<span class="noResult"><%=objXmlLang("no_search")%><br /></span>
<% ELSE %>
		<ul class="searchResult comment">
<%
	FOR tmpFor = 0 TO AdRs_List_Count
		CONF_strSearchMode = "comment"
%>
<!-- #include file = "../../../Include/Search.List.Disp.asp" -->
			<li>
				<dl>
					<dt><a href="<%=LIST_strLink%>" onclick="window.open(this.href);return false;" target="_blank"><%=LIST_strContent%></a></dt>
				</dl>
				<address><strong><%=LIST_strNickName%></strong> | <span class="time"><%=LIST_strRegDate%></span></address>
			</li>
<%
	NEXT
%>
		</ul>
<% END IF %>
<% IF subAct = "" THEN %>
		<div class="isMore"><a href="#" id="comment_more" onClick="return false;"><%=objXmlLang("cmd_more")%></a></div>
<% END IF %>