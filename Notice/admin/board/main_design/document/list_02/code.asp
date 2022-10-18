<div class="section_ol">
<h2>주간 <em>다운로드 순위</em>
</h2>
<ol>
<%
	DIM iCount
	iCount = 0

	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_MAIN_LIST] '{{board_srl}}', '', '{{count}}', '{{data_type}}' ")

	WHILE NOT(RS.EOF)
		iCount = iCount + 1
%>
<li class="best">
<span class="ranking">{{=iCount}}</span>
<a href="{{link_title}}">{{title}}</a>
<span class="num"><%=REPLACE(LEFT(RS("strRegDate"), 10), "-", ".")%></span>
</li>
<%
	RS.MOVENEXT
	WEND
%>
</ol>
<a class="more" href="{{link_board}}">
<span>›</span>더보기</a> </div>