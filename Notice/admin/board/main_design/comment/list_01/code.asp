<div class="section_ul">
	<h3>최근 댓글</h3>
	<ul>
<%
	SET RS = DBCON.EXECUTE("[ARTY30_SP_BOARD_MAIN_LIST] '{{board_srl}}', '', '{{count}}', '{{data_type}}' ")

	WHILE NOT(RS.EOF)
%>
		<li>
			<span class="date"><%=REPLACE(LEFT(RS("strRegDate"), 10), "-", ".")%></span>
			<a href="{{link_title}}">{{content}}</a>
		</li>
<%
	RS.MOVENEXT
	WEND
%>
	</ul>
</div>
