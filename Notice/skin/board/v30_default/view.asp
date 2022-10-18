<!-- #include file = "../../../Include/Board.View.asp" -->
<!-- #include file = "common.header.asp" --> 
<script type="text/javascript" src="<%=CONF_skinPath%>js/view.js"></script> 
<div class="read_header">
	<h4><%=READ_strTitle%><span class="bar">|</span><span class="category"><%=READ_strCategory%></span></h4>
	<ul>
		<li><%=READ_strNickName%></li>
		<li class="stext"><span class="bar">|</span><%=objXmlLang("readed_count")%> : <%=READ_intRead%></li>
		<li class="stext"><span class="bar">|</span><%=objXmlLang("voted_count")%> : <%=READ_intVote%></li>
		<% IF objSkinConfig("display_ipaddr") = "Y" THEN %>
		<li class="stext"><span class="bar">|</span><%=objXmlLang("ip")%> : <%=READ_strIpAddr%></li>
		<% END IF %>
		<li class="stext"><span class="bar">|</span><%=READ_strRegDate%></li>
	</ul>
</div>
<div class="read_body">
	<% IF UBOUND(READ_ExtraDataField) > 0 THEN %>
	<table class="extraVarsList">
		<% FOR EACH extraData IN READ_ExtraDataField %>
		<% IF extraData <> "" THEN %>
		<tr>
			<th><%=objXmlLang(extraData)%></th>
			<td><%=objExtraVar(extraData)%></td>
		</tr>
		<% END IF %>
		<% NEXT %>
	</table>
	<% END IF %>
	<div class="contents"><%=READ_strContent%></div>
</div>
<div class="read_footer">
	<div class="file_list">
		<a href="#toggle_file" class="toggle_file" onclick="return false;"><%=objXmlLang("cmd_attach_file")%> <strong></strong> <%=objXmlLang("count")%><span>▼</span></a>
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
	<div class="read_btn_area">
		<div class="btn_left">
			<span class="button medium strong icon"><span class="write"></span><a href="<%=GetBoardUrl("write", "seq=" & REQ_intSeq)%>"><%=objXmlLang("cmd_write")%></a></span>
			<% IF CONF_strModifyLevel = True THEN %>
			<span class="button medium"><a href="<%=GetBoardUrl("modify", "seq=" & REQ_intSeq)%>"><%=objXmlLang("cmd_modify")%></a></span> <span class="button medium"><a href="<%=GetBoardUrl("remove", "seq=" & REQ_intSeq)%>"><%=objXmlLang("cmd_delete")%></a></span>
			<% END IF %>
		</div>
		<div class="btn_right">
			<a href="<%=GetBoardUrl("",  "page=1,search_keyword=,search_target=")%>" class="btn"><%=objXmlLang("cmd_new_list")%></a> <span class="bar">|</span> <a href="<%=GetBoardUrl("",  "")%>"><%=objXmlLang("cmd_list")%></a>
			<% IF CONF_bitDispPrevNextList = True THEN %>
			<span class="bar">|</span> <span class="arrow">▲</span><a href="<% IF READ_intPrevSeq = "0" THEN %>#prev_document<% ELSE %><%=GetBoardUrl("view", "seq=" & READ_intPrevSeq)%><% END IF %>"><span<% IF READ_intPrevSeq = "0" THEN %> class="disabled"<% END IF %>><%=objXmlLang("prev_posts")%></span></a> <span class="bar">|</span> <span class="arrow">▼</span><a href="<% IF READ_intNextSeq = "0" THEN %>#next_document<% ELSE %><%=GetBoardUrl("view", "seq=" & READ_intNextSeq)%><% END IF %>"><span<% IF READ_intNextSeq = "0" THEN %> class="disabled"<% END IF %>><%=objXmlLang("next_posts")%></span></a>
			<% END IF %>
		</div>
	</div>
	<% IF CONF_bitDispPrevNextList = True THEN %>
		<ul class="prenext_paging">
			<% IF READ_intPrevSeq <> "0" THEN %>
			<li> <span class="arrow">▲</span><a href="<%=GetBoardUrl("view", "seq=" & READ_intPrevSeq)%>"><label><%=objXmlLang("prev_posts")%></label></a><span class="bar">|</span>&nbsp;<a href="<%=GetBoardUrl("view", "seq=" & READ_intPrevSeq)%>"><%=READ_strPrevTitle%></a> <span class="date"><%=REPLACE(LEFT(READ_strPrevDate, 10),"-",".")%></span> </li>
			<% END IF %>
			<% IF READ_intNextSeq <> "0" THEN %>
			<li> <span class="arrow">▼</span><a href="<%=GetBoardUrl("view", "seq=" & READ_intNextSeq)%>"><label><%=objXmlLang("next_posts")%></label></a> <span class="bar">|</span>&nbsp;<a href="<%=GetBoardUrl("view", "seq=" & READ_intNextSeq)%>"><%=READ_strNextTitle%></a> <span class="date"><%=REPLACE(LEFT(READ_strNextDate, 10),"-",".")%></span> </li>
			<% END IF %>
		</ul>
	<% END IF %>
</div>
<!-- #include file = "comment.asp" -->
<!-- #include file = "common.footer.asp" -->