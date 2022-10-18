<!-- #include file = "../../../Include/Search.Image.asp" -->
		<h2><%=objXmlLang("search_image")%> <span>(<%=CONF_intImageCount%>)</span></h2>
<% IF AdRs_List_Count< 0 THEN %>
		<span class="noResult"><%=objXmlLang("no_search")%><br /></span>
<% ELSE %>
		<ul class="searchImageResult">
<%
	FOR tmpFor = 0 TO AdRs_List_Count
		CONF_strSearchMode = "image"
%>
<!-- #include file = "../../../Include/Search.List.Disp.asp" -->
			<li>    
				<a href="<%=LIST_strLink%>" onclick="window.open(this.href); return false;" target="_blank"><img src="<%=LIST_strImage%>" width="120" height="120" /></a>
				<dl>
					<dt><a href="<%=LIST_strLink%>" onclick="window.open(this.href); return false;" target="_blank"><%=LIST_strFilename%></a></dt>
				</dl>
				<address><strong><%=LIST_strNickName%></strong><br /><span class="time"><%=LEFT(LIST_strRegDate,10)%>&nbsp;<%=FORMATDATETIME(LIST_strRegDate,4)%></span></address>
			</li>
<%
	NEXT
%>
		</ul>
<% END IF %>
<% IF subAct = "" THEN %>
		<div class="isMore"><a href="#" id="image_more" onClick="return false;"><%=objXmlLang("cmd_more")%></a></div>
<% END IF %>