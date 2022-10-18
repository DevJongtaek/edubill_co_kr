<!-- #include file = "../../../Include/Account.Id.Result.asp" -->
<!-- #include file = "common.header.asp" -->
<script type="text/javascript" src="<%=CONF_skinPath%>js/account.id.result.js"></script>
<form id="theForm" method="post">
<div id="bodyWrap" class="accountid_result">
	<div class="page_navi">
		<h4><%=objXmlLang("find_id")%></h4>
	</div>
	<div class="description"><%=objXmlLang("about_find_id_result")%></div>
	<div class="accountDiv">
		<h4><%=objXmlLang("find_id_result")%></h4>
		<div class="box01">
    	<fieldset>
				<ul>
<%
	FOR tmpFor = 0 TO UBOUND(FIND_UserID)
%>
					<li>
					<input type="radio" id="userid_<%=tmpFor%>" name="userid" value="<%=FIND_UserID(tmpFor)%>"<% IF tmpFor = 0 THEN %> checked="checked"<% END IF %> /> <label for="userid_<%=tmpFor%>"><strong><%=FIND_UserID(tmpFor)%></strong> (<%=FIND_Regdate(tmpFor)%>)</label></li>
<%
	NEXT
%>
				</ul>
			<ul class="field_desc">
				<li class="list"><%=objXmlLang("about_find_password_info")%></li>
			</ul>
  		</fieldset>
		</div>
		<div class="btn_area">
			<span class="button large strong"><input type="submit" value="<%=objXmlLang("cmd_find_password")%>" /></span>
		</div>
	</div>
</div>
</form>
<!-- #include file = "common.footer.asp" -->