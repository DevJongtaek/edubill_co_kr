<div class="section_ul">
<h2>최신 <em>공지사항</em>
</h2>
<ul>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_MAIN_LIST] '{{board_srl}}', '', '{{count}}', '{{data_type}}' ")

	WHILE NOT(RS.EOF)
%>
<li>
<span class="bu">›</span> <a href="{{link_title}}">{{title}}</a>
<span class="time"><%=REPLACE(LEFT(RS("strRegDate"), 10), "-", ".")%></span>
</li>
<%
	RS.MOVENEXT
	WEND
%>
</ul>
<a class="more" href="{{link_board}}">
<span>›</span>더보기</a>
</div>