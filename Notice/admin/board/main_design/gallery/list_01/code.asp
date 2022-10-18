<div class="fixed_img_col">
<h3>최근 갤러리</h3>
<ul>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_MAIN_LIST] '{{board_srl}}', '', '{{count}}', '{{data_type}}' ")

	WHILE NOT(RS.EOF)
%>
<li>
<a href="{{link_title}}" class="thrum"><span class="thumb"><img alt="" src="{{image}}"></span></a>
<a href="{{link_title}}"><strong>{{title}}</strong></a>
<p><%=REPLACE(LEFT(RS("strRegDate"), 10), "-", ".")%></p>
</li>
<%
	RS.MOVENEXT
	WEND
%>
</ul>
<a class="more" href="{{link_board}}"><span>›</span>더보기</a></div>