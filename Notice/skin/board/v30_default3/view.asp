<!-- #include file = "../../../Include/Board.View.asp" -->
<!-- #include file = "common.header.asp" --> 
<script type="text/javascript" src="<%=CONF_skinPath%>js/view.js"></script> 
<div class="read_header">
	<h4><%=READ_strTitle%><span><%=READ_strRegDate%></span></h4>
	<div class="title_line"></div>
	<p class="meta">
		<%=READ_strNickName%>
		<span class="read_vote">
			<span><%=objXmlLang("readed_count")%>:<%=READ_intRead%></span>
			<span class="vote"><%=objXmlLang("voted_count")%>:<%=READ_intVote%></span>
		</span>
	</p>
</div>
<div class="read_body">
	<%=READ_strContent%>
</div>

<div class="read_footer">
	<div class="file_list">
		<a href="#toggle_file" class="toggle_file"><%=objXmlLang("cmd_attach_file")%> [<span></span>]</a>
		<ul class="files"></ul>
	</div>
	<div class="tns">
		<a href="#popup_menu_area" name="popup_menu_area" class="document_<%=READ_intSeq%> action" onclick="return false;"><%=objXmlLang("cmd_posts_popup")%></a>
		<ul class="sns">
			<li class="twitter link"><a href="http://twitter.com/">Twitter</a></li>
			<li class="me2day link"><a href="http://me2day.net/">Me2day</a></li>
			<li class="facebook link"><a href="http://facebook.com/">Facebook</a></li>
			<li class="delicious link"><a href="http://delicious.com/">Delicious</a></li>
		</ul>
		<script type="text/javascript">
			jQuery(function($){
				$('.twitter>a').snspost({
					type : 'twitter',
					content : '<%=READ_strTItle%> ' + ' <%=CONF_strBbsUrl%>?act=bbs&subAct=view&bid=<%=REQ_strBid%>&seq=<%=REQ_intSeq%>'
				});
				$('.me2day>a').snspost({
					type : 'me2day',
					content : '\"<%=READ_strTItle%>\":<%=CONF_strBbsUrl%>?act=bbs&subAct=view&bid=<%=REQ_strBid%>&seq=<%=REQ_intSeq%>'
				});
				$('.facebook>a').snspost({
					type : 'facebook',
					content : '<%=READ_strTItle%>'
				});
				$('.delicious>a').snspost({
					type : 'delicious',
					content : '<%=READ_strTItle%>'
				});
			});
		</script>
	</div>
	<% IF READ_strPhotoImg <> "" OR READ_strUserSign <> "" THEN %>
	<div class="sign">
		<%=READ_strPhotoImg%>
		<div class="tx">
			<%=READ_strUserSign%>
		</div>
	</div>
	<% END IF %>
	<div class="read_btn_area">
		<div style="display:inline; float:left;">
			<span class="button btn03"><a href="<%=GetBoardUrl("write", "seq=" & REQ_intSeq)%>"><%=objXmlLang("cmd_write")%></a></span>
<% IF CONF_strModifyLevel = True THEN %>
			<span class="button btn03"><a href="<%=GetBoardUrl("modify", "seq=" & REQ_intSeq)%>"><%=objXmlLang("cmd_modify")%></a></span>
			<span class="button btn03"><a href="<%=GetBoardUrl("remove", "seq=" & REQ_intSeq)%>"><%=objXmlLang("cmd_delete")%></a></span>
<% END IF %>
		</div>
		<div style="display:inline; float:right;">
			<span class="button btn03"><a href="<%=GetBoardUrl("",  "page=1,search_keyword=,search_target=")%>" class="btn"><%=objXmlLang("cmd_new_list")%></a></span>
			<span class="button btn03"><a href="<%=GetBoardUrl("",  "")%>"><%=objXmlLang("cmd_list")%></a></span>
		</div>
	</div>
<% IF CONF_bitDispPrevNextList = True AND (READ_intPrevSeq <> "0" OR READ_intNextSeq <> "0") THEN %>
	<div class="prev_next_document">
		<ul>
<% IF READ_intPrevSeq <> "0" THEN %>
			<li class="prev"><label><%=objXmlLang("prev_posts")%></label><span>|</span><a href="<%=GetBoardUrl("view", "seq=" & READ_intPrevSeq)%>"><%=READ_strPrevTitle%></a></li>
<% END IF %>
<% IF READ_intNextSeq <> "0" THEN %>
			<li class="next"><label><%=objXmlLang("next_posts")%></label><span>|</span><a href="<%=GetBoardUrl("view", "seq=" & READ_intNextSeq)%>"><%=READ_strNextTitle%></a></li>
<% END IF %>
		</ul>
	</div>
<% END IF %>
</div>
<!-- #include file = "comment.asp" -->
<!-- #include file = "common.footer.asp" -->