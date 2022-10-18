<div class="fixed_img_row">
<h3>최근 갤러리</h3>
<ul>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_MAIN_LIST] '{{board_srl}}', '', '{{count}}', '{{data_type}}' ")

	WHILE NOT(RS.EOF)
%>
<li>
<a href="{{link_title}}">
<span class="thumb">
<img alt="" src="{{image}}" width="120">
</span></a> <a href="{{link_title}}"><strong>{{title}}</strong></a> 
<p>{{content}}</p>
</li>
<%
	RS.MOVENEXT
	WEND
%>
</ul>
<a class="more" href="{{link_board}}"><span>›</span>더보기</a>
</div>