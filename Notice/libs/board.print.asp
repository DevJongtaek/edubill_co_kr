<!-- #include file = "../Include/Board.View.asp" -->
<script type="text/javascript">

	$(document).ready(function() {
		window.print();
	});

</script>
<style type="text/css">

	.print_wrap {padding:5px;}
	.subject	{border-bottom: 1px dashed #e9e9e9; padding: 13px 15px 10px 15px;}
	.writer	{padding: 7px 15px 5px 15px; font-size:11px;}
	.extra_vars {padding: 3px 15px 3px 15px;}
	.content	{padding: 8px 15px 5px 15px;}
	.bar {color: #d4d4d4; font-size: 11px; font-family:dotum,sans-serif; width: 2px; padding: 0 2px;}

</style>
<div class="print_wrap">
	<div class="subject">
		 <%=READ_strTitle%>
	</div>
	<div class="writer">
		<%=READ_strNickName%>
		<span class="bar">|</span> Read  <%=READ_intRead%> <span class="bar">|</span> <%=READ_strRegDate%>	
	</div>
<% IF UBOUND(READ_ExtraDataField) > 0 THEN %>
<% FOR EACH extraData IN READ_ExtraDataField %>
	<div class="extra_vars"><%=objXmlLang(extraData)%> : <%=objExtraVar(extraData)%></div>
<% NEXT %>
<% END IF %>
	<div class="content"><%=READ_strContent%></div>
</div>