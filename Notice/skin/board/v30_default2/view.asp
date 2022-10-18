<!-- #include file = "../../../Include/Board.View.asp" -->
<!-- #include file = "common.header.asp" --> 
<script type="text/javascript" src="<%=CONF_skinPath%>js/view.js"></script> 
<div class="box">
	<span class="rc-tp"><span></span></span>
	<div class="bd bd_white">
		<div class="read_header">
			<div class="title">
				<h4><%=READ_strTItle%></h4>
				<div class="title_line"></div>
			</div>
			<div class="author">
				<span><%=objXmlLang("write_user")%> : <%=READ_strNickName%></span>
			</div>
			<div class="meta">
				<span><%=objXmlLang("registration_date")%> : <%=READ_strRegDate%></span>
				<span><%=objXmlLang("readed_count")%> : <%=READ_intRead%></span>
				<span><%=objXmlLang("voted_count")%> : <%=READ_intVote%></span>
			</div>
		</div>
		<div class="read_body">
<% IF UBOUND(READ_ExtraDataField) > 0 THEN %>
			<div class="extravars">
<% FOR EACH extraData IN READ_ExtraDataField %>
<% IF extraData <> "" AND objExtraVar(extraData) <> "" THEN %>
				<p><%=objXmlLang(extraData)%> : <%=objExtraVar(extraData)%></p>
<% END IF %>
<% NEXT %>
			</div>
<% END IF %>
			<div class="contents"><%=READ_strContent%></div>
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
			<% IF READ_strPhotoImg <> "" OR READ_strUserSign <> "" THEN %>
			<div class="sign">
				<%=READ_strPhotoImg%>
				<div class="tx">
					<%=READ_strUserSign%>
				</div>
			</div>
			<% END IF %>
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
	</div>
	<div class="ft"></div>
		<span class="rc-bt"><span></span></span>
</div>
<div class="read_footer">
	<div class="btn_area">
		<div class="fl">
			<span class="button strong icon"><span class="write"></span><a href="<%=GetBoardUrl("write", "seq=" & REQ_intSeq)%>"><%=objXmlLang("cmd_write")%></a></span>
	<% IF CONF_strModifyLevel = True THEN %>
			<span class="button icon"><span class="modify"></span><a href="<%=GetBoardUrl("modify", "seq=" & REQ_intSeq)%>"><%=objXmlLang("cmd_modify")%></a></span> <span class="button icon"><span class="delete"></span><a href="<%=GetBoardUrl("remove", "seq=" & REQ_intSeq)%>"><%=objXmlLang("cmd_delete")%></a></span>
	<% END IF %>
		</div>
		<div class="fr">
			<span class="button icon"><span class="list"></span><a href="<%=GetBoardUrl("",  "page=1,search_keyword=,search_target=")%>" class="btn"><%=objXmlLang("cmd_new_list")%></a></span>
			<span class="button icon"><span class="list"></span><a href="<%=GetBoardUrl("",  "")%>"><%=objXmlLang("cmd_list")%></a></span>
<% IF CONF_bitDispPrevNextList = True THEN %>
			<% IF READ_intPrevSeq > 0 THEN %>
			<span class="button icon"><span class="up"></span><a href="<%=GetBoardUrl("view", "seq=" & READ_intPrevSeq)%>"><%=objXmlLang("prev_posts")%></a></span>
			<% END IF %>
			<% IF READ_intNextSeq > 0 THEN %>
			<span class="button icon"><span class="down"></span><a href="<%=GetBoardUrl("view", "seq=" & READ_intNextSeq)%>"><%=objXmlLang("next_posts")%></a></span>
			<% END IF %>
<% END IF %>
		</div>
	</div>
</div>
<div class="h10"></div>
<div class="box">
	<span class="rc-tp"><span></span></span>
	<div class="bd bd_white">

		<!-- #include file = "comment.asp" -->

	</div>
	<div class="ft"></div>
	<span class="rc-bt"><span></span></span>
</div>
<!-- #include file = "common.footer.asp" -->